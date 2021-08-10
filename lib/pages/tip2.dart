import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2_mobil_sorgular/data/TaksiVerileri.dart';
import 'package:yazlab2_mobil_sorgular/data/Tarih.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip2_view.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip2_view.dart';
import 'package:yazlab2_mobil_sorgular/theme/top_bar.dart';
import 'package:yazlab2_mobil_sorgular/widgets/yolculuk_bilgisi_widget.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class Tip2Sayfasi extends StatefulWidget {
  @override
  _Tip2SayfasiState createState() => _Tip2SayfasiState();
}

class _Tip2SayfasiState extends State<Tip2Sayfasi> {
  var selectedLokasyon;
  DateTime _startDate = DateTime.utc(2020, 12, 1, 0, 0, 0);
  DateTime _endDate =
      (DateTime.utc(2020, 12, 2, 0, 0, 0)).add(new Duration(days: 1));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
      context: context,
      initialFirstDate: _startDate,
      initialLastDate: _endDate,
      firstDate: DateTime.utc(2020, 11, 30, 0, 0, 0),
      lastDate: DateTime.utc(2020, 12, 31, 0, 0, 0),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.yellow,
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await displayDateRangePicker(context);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    width: 350,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: 0.1, //extend the shadow
                          offset: Offset(
                            0.05, // Move to right 10  horizontally
                            0.05, // Move to bottom 10 Vertically
                          ),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade600,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.date_range,
                              ),
                            ),
                          ),
                          Text(
                            "Tarih Seçimi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 100)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  width: 350,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 0.1, //extend the shadow
                        offset: Offset(
                          0.05, // Move to right 10  horizontally
                          0.05, // Move to bottom 10 Vertically
                        ),
                      ),
                    ],
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade600,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_pin,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("lokasyonlar")
                            .orderBy("LocationID", descending: false)
                            .snapshots(),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            List<DropdownMenuItem> lokasyonVerileri = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              lokasyonVerileri.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap["LocationID"].toString() +
                                        " - " +
                                        snap["Zone"],
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  value: "${snap["LocationID"]}",
                                ),
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 220,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      items: lokasyonVerileri,
                                      onChanged: (lokasyonValue) {
                                        setState(() {
                                          selectedLokasyon = lokasyonValue;
                                        });
                                      },
                                      value: selectedLokasyon,
                                      hint: Text(
                                        "Lokasyon seçiniz...",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 0.1, //extend the shadow
                        offset: Offset(
                          0.05, // Move to right 10  horizontally
                          0.05, // Move to bottom 10 Vertically
                        ),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Seçilen Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.date_range_rounded,
                              color: Colors.black,
                              size: 24.0,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Seçilen Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                )
              ],
            ),
            FloatingActionButton(
              child: Icon(
                Icons.arrow_forward,
              ),
              backgroundColor: Color.fromRGBO(253, 216, 53, 1),
              onPressed: () {
                Tarih tarih =
                    new Tarih(startDate: _startDate, endDate: _endDate);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tip2SayfaVerileri(
                      tarih: tarih,
                      secilenLokasyon: selectedLokasyon,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
