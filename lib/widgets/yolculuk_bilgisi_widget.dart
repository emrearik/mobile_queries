import 'package:flutter/material.dart';

class YolculukBilgisiWidget extends StatefulWidget {
  final String pickupDate;
  final String dropoffDate;
  final String binisYeri;
  final String inisYeri;
  final int yolcuSayisi;
  final double tutar;
  final double mesafe;

  const YolculukBilgisiWidget(
      {Key key,
      this.pickupDate,
      this.dropoffDate,
      this.binisYeri,
      this.inisYeri,
      this.yolcuSayisi,
      this.tutar,
      this.mesafe})
      : super(key: key);
  @override
  _YolculukBilgisiWidgetState createState() => _YolculukBilgisiWidgetState();
}

class _YolculukBilgisiWidgetState extends State<YolculukBilgisiWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 380,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 2, //extend the shadow
            offset: Offset(
              3, // Move to right 10  horizontally
              0.50, // Move to bottom 10 Vertically
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(252, 206, 50, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    widget.pickupDate.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.binisYeri,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 0.3,
                    width: 320,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.dropoffDate.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.inisYeri,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              )
            ],
          ),
          Container(
            height: 0.3,
            width: 345,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yolcu Sayısı: " + widget.yolcuSayisi.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Mesafe: " + widget.mesafe.toString() + " mil",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.tutar.toString() + " \$",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
