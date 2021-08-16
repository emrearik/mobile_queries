import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yazlab2_mobil_sorgular/widgets/widgets.dart';

LatLng SOURCE_LOCATION = LatLng(0, 0);
LatLng DEST_LOCATION = LatLng(0, 0);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITIPN = 20;
const double PIN_INVISIBLE_POSITION = -220;

class Type3MapPage extends StatefulWidget {
  final DateTime selectedDate;

  const Type3MapPage({Key key, this.selectedDate}) : super(key: key);
  @override
  _Type3MapPageState createState() => _Type3MapPageState();
}

class _Type3MapPageState extends State<Type3MapPage> {
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
        future: getData(widget.selectedDate),
        builder: (context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            SOURCE_LOCATION = LatLng(snapshot.data["pickupLocation"]["lat"],
                snapshot.data["pickupLocation"]["long"]);
            DEST_LOCATION = LatLng(snapshot.data["dropoffLocation"]["lat"],
                snapshot.data["dropoffLocation"]["long"]);

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
                  child: MapTopWidget(),
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
                        return MapTripInformationWidget(
                          pickupDate: snapshot.data["taxiDatas"]
                                  ["tpep_pickup_datetime"]
                              .toString(),
                          dropoffDate: snapshot.data["taxiDatas"]
                                  ["tpep_dropoff_datetime"]
                              .toString(),
                          pickupLocation: snapshot.data["pickupLocation"]
                              ["Borough"],
                          dropoffLocation: snapshot.data["dropoffLocation"]
                              ["Borough"],
                          passengerCount: snapshot.data["taxiDatas"]
                              ["passenger_count"],
                          tripDistance: snapshot.data["taxiDatas"]
                              ["trip_distance"],
                          totalAmount: snapshot.data["taxiDatas"]
                              ["total_amount"],
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

  Future<Map> getData(selectedDate) async {
    List taxiDatas = [];
    //filter selected day.
    var startDate = int.parse(
        (DateTime.parse(selectedDate.toString()).millisecondsSinceEpoch / 1000)
            .toStringAsFixed(0));

    final databaseReference = FirebaseFirestore.instance;

    var snapshot = await databaseReference
        .collection("veriler")
        .orderBy("tpep_pickup_datetime")
        .startAt([startDate])
        .endAt([startDate + 86400])
        .limit(1000)
        .get();

    //firestore snapshots data add to list
    for (var item in snapshot.docs) {
      var data = item.data();
      taxiDatas.add(data);
    }
    //find the longest distance
    for (var i = 0; i < taxiDatas.length; i++) {
      if (taxiDatas[0]["trip_distance"] < taxiDatas[i]["trip_distance"]) {
        taxiDatas[0] = taxiDatas[i];
      }
    }

    //success. process to show ui
    //find pickup location
    var puLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(taxiDatas[0]["PULocationID"]))
        .get();

    //find dropoff location
    var doLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(taxiDatas[0]["DOLocationID"]))
        .get();

    //merge taxi datas, pickup location and dropoff location. add to map.
    Map<String, dynamic> taxiDataMap = {
      "taxiDatas": taxiDatas[0],
      "pickupLocation": puLocationQuery.docs[0].data(),
      "dropoffLocation": doLocationQuery.docs[0].data()
    };

    return taxiDataMap;
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
