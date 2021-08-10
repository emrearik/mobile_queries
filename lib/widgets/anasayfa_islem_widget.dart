import 'package:flutter/material.dart';

class AnasayfaIslemWidget extends StatelessWidget {
  final String tip;
  final String islem;
  final double islemFontBoyutu;

  const AnasayfaIslemWidget(
      {Key key, this.tip, this.islem, this.islemFontBoyutu})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Color.fromRGBO(252, 206, 50, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                tip,
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Text(
            islem,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: islemFontBoyutu,
            ),
          ),
        ],
      )),
    );
  }
}
