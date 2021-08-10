import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip1.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip2.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip3.dart';
import 'package:yazlab2_mobil_sorgular/widgets/anasayfa_islem_widget.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 300,
                color: Color.fromRGBO(252, 206, 50, 1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        child: Image(
                          image: AssetImage("images/logo.png"),
                        ),
                      ),
                      Text(
                        "MOBİL SORGULAR",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Georgia',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Merhabalar, lütfen aşağıdan işlem seçiniz.",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  Text(
                    "İşlemler",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: AnasayfaIslemWidget(
                      tip: "TİP 1",
                      islem:
                          "En uzun Mesafeli 5 Yolculuğun\n Gün ve Mesafeleri",
                      islemFontBoyutu: 14,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tip1Sayfasi(),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                      child: AnasayfaIslemWidget(
                        tip: "TİP 2",
                        islem:
                            "İki Tarih Arasında Belirli Bir \nLokasyondan Hareket Eden Araç Sayısı",
                        islemFontBoyutu: 11,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Tip2Sayfasi(),
                          ),
                        );
                      }),
                  GestureDetector(
                    child: AnasayfaIslemWidget(
                      tip: "TİP 3",
                      islem:
                          "Belirli Bir Gündeki En Uzun Seyehatin \nBilgileri ve Yolu ",
                      islemFontBoyutu: 12,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tip3Sayfasi(),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      "Mobil Sorgular\n Emre ARIK - Halim Ahat AKTURAN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
