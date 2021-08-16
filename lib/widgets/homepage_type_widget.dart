import 'package:flutter/material.dart';

class HomepageTypeWidget extends StatelessWidget {
  final String type;
  final String trip;
  final double tripFontSize;

  const HomepageTypeWidget({Key key, this.type, this.trip, this.tripFontSize})
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flexible(
              flex: 1,
              child: Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 206, 50, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    type,
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 2,
            child: Text(
              trip,
              textAlign: TextAlign.start,
              style: TextStyle(fontFamily: 'Poppins', fontSize: tripFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
