import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2_mobil_sorgular/data/TaksiVerileri.dart';
import 'package:yazlab2_mobil_sorgular/data/Tarih.dart';
import 'package:yazlab2_mobil_sorgular/theme/top_bar.dart';
import 'package:yazlab2_mobil_sorgular/widgets/yolculuk_bilgisi_widget.dart';
import 'package:intl/intl.dart';

class Tip2SayfaVerileri extends StatefulWidget {
  final Tarih tarih;
  final String secilenLokasyon;

  const Tip2SayfaVerileri({Key key, this.tarih, this.secilenLokasyon})
      : super(key: key);
  @override
  _Tip2SayfaVerileriState createState() => _Tip2SayfaVerileriState();
}

class _Tip2SayfaVerileriState extends State<Tip2SayfaVerileri> {
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
                            color: Color.fromRGBO(233, 213, 28, 1),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "İki Tarih Arasında Belirli Bir \nLokasyondan Hareket Eden Araç Sayısı",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
              future: getData(widget.tarih, widget.secilenLokasyon),
              builder: (context,
                  AsyncSnapshot<List<BirlestirilmisVeriler>> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Seçilen Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(widget.tarih.startDate).toString()}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Seçilen Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(widget.tarih.endDate).toString()}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Toplam Araç Sayısı: " +
                            snapshot.data.length.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return YolculukBilgisiWidget(
                                  pickupDate:
                                      snapshot.data[index].tpepPickupDatetime,
                                  dropoffDate:
                                      snapshot.data[index].tpepDropoffDatetime,
                                  binisYeri:
                                      snapshot.data[index].baslangicNoktasi,
                                  inisYeri: snapshot.data[index].bitisNoktasi,
                                  yolcuSayisi:
                                      snapshot.data[index].passengerCount,
                                  tutar: snapshot.data[index].totalAmount,
                                  mesafe: snapshot.data[index].tripDistance);
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
          ),
        ],
      ),
    );
  }
}

Future<List<BirlestirilmisVeriler>> getData(
    Tarih tarih, String secilenLokasyon) async {
  var baslangicTarihi = int.parse(
      (DateTime.parse(tarih.startDate.toString()).millisecondsSinceEpoch / 1000)
          .toStringAsFixed(0));
  var bitisTarihi = int.parse(
      (DateTime.parse(tarih.endDate.toString()).millisecondsSinceEpoch / 1000)
          .toStringAsFixed(0));

  final databaseReference = FirebaseFirestore.instance;

  var snapshot = await databaseReference
      .collection("veriler")
      .where("PULocationID", isEqualTo: secilenLokasyon)
      .get();

  List<BirlestirilmisVeriler> birlestirilmisVeriler = [];

  for (var item in snapshot.docs) {
    var data = item.data();
    if (data["tpep_pickup_datetime"] >= baslangicTarihi &&
        data["tpep_pickup_datetime"] <= bitisTarihi) {
      //yolculuk tespit edildi. ui de gösterilmek için hazırlanıyor.
      //veri başlangıç lokasyonu bulunuyor.
      var puLocationQuery = await databaseReference
          .collection("lokasyonlar")
          .where("LocationID", isEqualTo: int.parse(data["PULocationID"]))
          .get();

      var baslangicNoktasi = puLocationQuery.docs[0].data();
      //veri bitiş lokasyonu bulunuyor.
      var doLocationQuery = await databaseReference
          .collection("lokasyonlar")
          .where("LocationID", isEqualTo: int.parse(data["DOLocationID"]))
          .get();

      var bitisNoktasi = doLocationQuery.docs[0].data();

      //alınan veri bilgileri, başlangıç bilgileri, bitiş bilgileri alınır ve taksiverileri
      //isimli listeye atanır.
      Map<String, dynamic> taksiVerileri = {
        "veriler": data,
        "baslangicNoktasi": baslangicNoktasi,
        "bitisNoktasi": bitisNoktasi
      };

      // liste birlestirilmis veri kısmıyla yeni bir listeye dönüştürülür.
      var birlestirilmisVeri =
          BirlestirilmisVeriler.fromJsonFormattedDate(taksiVerileri);
      birlestirilmisVeriler.add(birlestirilmisVeri);
    }
  }
  return birlestirilmisVeriler;
}
