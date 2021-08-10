import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2_mobil_sorgular/data/TaksiVerileri.dart';
import 'package:yazlab2_mobil_sorgular/theme/top_bar.dart';
import 'package:yazlab2_mobil_sorgular/widgets/yolculuk_bilgisi_widget.dart';

class Tip1Sayfasi extends StatefulWidget {
  @override
  _Tip1SayfasiState createState() => _Tip1SayfasiState();
}

class _Tip1SayfasiState extends State<Tip1Sayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              TopBar(),
              Container(
                margin: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Color.fromRGBO(252, 206, 50, 1),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "En Uzun Mesafeli 5 Yolculuktaki\n Gün ve Mesafeler ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
          Flexible(
            child: FutureBuilder(
              future: getData(),
              builder: (context,
                  AsyncSnapshot<List<BirlestirilmisVeriler>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return YolculukBilgisiWidget(
                            pickupDate: snapshot.data[index].tpepPickupDatetime,
                            dropoffDate:
                                snapshot.data[index].tpepDropoffDatetime,
                            binisYeri: snapshot.data[index].baslangicNoktasi,
                            inisYeri: snapshot.data[index].bitisNoktasi,
                            yolcuSayisi: snapshot.data[index].passengerCount,
                            tutar: snapshot.data[index].totalAmount,
                            mesafe: snapshot.data[index].tripDistance);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<BirlestirilmisVeriler>> getData() async {
  List<BirlestirilmisVeriler> birlestirilmisVeriler = [];

  final databaseReference = FirebaseFirestore.instance;

  var snapshot = await databaseReference
      .collection("veriler")
      .orderBy("trip_distance", descending: true)
      .limit(5)
      .get();

  for (var item in snapshot.docs) {
    var data = item.data();

    var puLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(data["PULocationID"]))
        .get();

    var baslangicNoktasi = puLocationQuery.docs[0].data();

    var doLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(data["DOLocationID"]))
        .get();

    var bitisNoktasi = doLocationQuery.docs[0].data();

    Map<String, dynamic> taksiVerileri = {
      "veriler": data,
      "baslangicNoktasi": baslangicNoktasi,
      "bitisNoktasi": bitisNoktasi
    };

    var birlestirilmisVeri =
        BirlestirilmisVeriler.fromJsonFormattedDate(taksiVerileri);

    birlestirilmisVeriler.add(birlestirilmisVeri);
  }
  return birlestirilmisVeriler;
}
