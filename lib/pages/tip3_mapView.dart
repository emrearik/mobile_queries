import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yazlab2_mobil_sorgular/data/TaksiVerileri.dart';
import 'package:yazlab2_mobil_sorgular/widgets/map_ust_kisim_widget.dart';
import 'package:yazlab2_mobil_sorgular/widgets/map_yolculuk_bilgileri.dart';

LatLng SOURCE_LOCATION = LatLng(0, 0);
LatLng DEST_LOCATION = LatLng(0, 0);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITIPN = 20;
const double PIN_INVISIBLE_POSITION = -220;

class Tip3HaritaSayfasi extends StatefulWidget {
  final DateTime secilenTarih;

  const Tip3HaritaSayfasi({Key key, this.secilenTarih}) : super(key: key);
  @override
  _Tip3HaritaSayfasiState createState() => _Tip3HaritaSayfasiState();
}

class _Tip3HaritaSayfasiState extends State<Tip3HaritaSayfasi> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();

  LatLng currentLocation;
  LatLng destinationLocation;

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    polylinePoints = PolylinePoints();
    //set up initial locations
    this.setInitialLocation();
    //set up the marker icons
    this.setSourceAndDestinationMarkerIcons();
  }

  void setSourceAndDestinationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'images/source_pin.png',
    );

    destinationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.0),
      'images/destination_pin.png',
    );
  }

  void setInitialLocation() {
    currentLocation = LatLng(
      SOURCE_LOCATION.latitude,
      SOURCE_LOCATION.longitude,
    );
    destinationLocation = LatLng(
      DEST_LOCATION.latitude,
      DEST_LOCATION.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(widget.secilenTarih),
        builder: (context, AsyncSnapshot<BirlestirilmisVeriler> snapshot) {
          if (snapshot.hasData) {
            SOURCE_LOCATION = LatLng(snapshot.data.baslangicNoktasiLatitude,
                snapshot.data.baslangicNoktasiLongitude);
            DEST_LOCATION = LatLng(snapshot.data.bitisNoktasiLatitude,
                snapshot.data.bitisNoktasiLongitude);

            CameraPosition initialCameraPosition = CameraPosition(
              zoom: CAMERA_ZOOM,
              tilt: CAMERA_TILT,
              bearing: CAMERA_BEARING,
              target: SOURCE_LOCATION,
            );

            return Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    polylines: _polylines,
                    zoomGesturesEnabled: true,
                    markers: _markers,
                    mapType: MapType.normal,
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);

                      showPinsOnMap(SOURCE_LOCATION, DEST_LOCATION);
                      setPolylines(SOURCE_LOCATION, DEST_LOCATION);
                    },
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 0,
                  right: 0,
                  child: MapUstKisim(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 5,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return MapYolculukBilgileri(
                          pickupDate: snapshot.data.tpepPickupDatetime,
                          dropoffDate: snapshot.data.tpepDropoffDatetime,
                          binisYeri: snapshot.data.baslangicNoktasi,
                          inisYeri: snapshot.data.bitisNoktasi,
                          passengerCount: snapshot.data.passengerCount,
                          tripDistance: snapshot.data.tripDistance,
                          totalAmount: snapshot.data.totalAmount,
                        );
                      }),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<BirlestirilmisVeriler> getData(secilenTarih) async {
    var baslangicTarihi = int.parse(
        (DateTime.parse(secilenTarih.toString()).millisecondsSinceEpoch / 1000)
            .toStringAsFixed(0));
    var enUzunMesafe = 0;

    List veriler = [];

    final databaseReference = FirebaseFirestore.instance;

    var snapshot = await databaseReference
        .collection("veriler")
        .orderBy("tpep_pickup_datetime")
        .startAt([baslangicTarihi])
        .endAt([baslangicTarihi + 86400])
        .limit(1000)
        .get();

    //firestoreden gelen veriler alındı ve diziye atandı.
    for (var item in snapshot.docs) {
      var veri = item.data();
      veriler.add(veri);
    }
    //diziye atanan verilerden en yüksek mesafeli yolculuk bulundu. veriler[0] dizisine atandı.
    for (var i = 0; i < veriler.length; i++) {
      if (veriler[0]["trip_distance"] < veriler[i]["trip_distance"]) {
        veriler[0] = veriler[i];
      }
    }

    //yolculuk tespit edildi. ui de gösterilmek için hazırlanıyor.
    //veri başlangıç lokasyonu bulunuyor.
    var puLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(veriler[0]["PULocationID"]))
        .get();

    var baslangicNoktasi = puLocationQuery.docs[0].data();
    //veri bitiş lokasyonu bulunuyor.
    var doLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(veriler[0]["DOLocationID"]))
        .get();

    var bitisNoktasi = doLocationQuery.docs[0].data();

    //alınan veri bilgileri, başlangıç bilgileri, bitiş bilgileri alınır ve taksiverileri
    //isimli listeye atanır.
    Map<String, dynamic> taksiVerileri = {
      "veriler": veriler[0],
      "baslangicNoktasi": baslangicNoktasi,
      "bitisNoktasi": bitisNoktasi
    };

    // liste birlestirilmis veri kısmıyla yeni bir listeye dönüştürülür.
    var birlestirilmisVeri =
        BirlestirilmisVeriler.fromJsonFormattedDateWithCoordinates(
            taksiVerileri);

    return birlestirilmisVeri;
  }

  void showPinsOnMap(LatLng sourceLocation, LatLng destLocation) {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("sourcePin"),
            position: sourceLocation,
            icon: sourceIcon),
      );
      _markers.add(
        Marker(
          markerId: MarkerId("destinationPin"),
          position: destLocation,
          icon: destinationIcon,
        ),
      );
    });
  }

  void setPolylines(LatLng sourceLocation, LatLng destLocation) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_MAP_API_KEY'],
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destLocation.latitude, destLocation.longitude),
    );

    if (result.status == 'OK') {
      result.points.forEach(
        (PointLatLng point) {
          polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          );
        },
      );

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF0BA5CB),
            points: polylineCoordinates,
          ),
        );
      });
    }
  }
}
