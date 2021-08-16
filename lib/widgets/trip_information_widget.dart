import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripInformationWidget extends StatefulWidget {
  final String pickupDate;
  final String dropoffDate;
  final String pickupLocation;
  final String dropoffLocation;
  final int passengerCount;
  final double amount;
  final double distance;

  TripInformationWidget(
      {Key key,
      this.pickupDate,
      this.dropoffDate,
      this.pickupLocation,
      this.dropoffLocation,
      this.passengerCount,
      this.amount,
      this.distance})
      : super(key: key);

  @override
  _TripInformationWidgetState createState() => _TripInformationWidgetState();
}

class _TripInformationWidgetState extends State<TripInformationWidget> {
  var formattedDate = new DateFormat('dd/MM/yyyy H:m:s');
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
                    formattedDate.format(
                      DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(widget.pickupDate) * 1000000),
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.pickupLocation,
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
                    formattedDate.format(
                      DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(widget.dropoffDate) * 1000000),
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.dropoffLocation,
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
                      "Passenger Count: " + widget.passengerCount.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Distance: " + widget.distance.toString() + " mil",
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
                  widget.amount.toString() + " \$",
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
