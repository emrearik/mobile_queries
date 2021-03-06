import 'package:flutter/material.dart';
import 'package:yazlab2_mobil_sorgular/pages/type3_map_page.dart';
import 'package:yazlab2_mobil_sorgular/theme/top_bar.dart';
import 'package:intl/intl.dart';

class Type3SelectPage extends StatefulWidget {
  @override
  _Type3SelectPageState createState() => _Type3SelectPageState();
}

class _Type3SelectPageState extends State<Type3SelectPage> {
  DateTime _selectedDate = DateTime.utc(2020, 12, 1, 0, 0, 0);

  showSelectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime.utc(2020, 12, 01, 0, 0, 0),
      lastDate: DateTime.utc(2020, 12, 31, 0, 0, 0),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Text(
                        "The Longest Trips \nof The Selected Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                  await showSelectedDate(context);
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
                          "Select Date",
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.date_range_rounded,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Selected Date : ${DateFormat('dd/MM/yyyy').format(_selectedDate).toString()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          FloatingActionButton(
            child: Icon(
              Icons.arrow_forward,
            ),
            backgroundColor: Color.fromRGBO(253, 216, 53, 1),
            onPressed: () {
              final DateTime selectedDate = _selectedDate;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Type3MapPage(
                    selectedDate: selectedDate,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
