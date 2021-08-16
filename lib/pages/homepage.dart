import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:yazlab2_mobil_sorgular/pages/pages.dart';
import 'package:yazlab2_mobil_sorgular/pages/type2_page.dart';
import 'package:yazlab2_mobil_sorgular/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        "MOBILE QUERIES",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Poppins',
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
                    "Hello, please select type.",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  Text(
                    "TYPES",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: HomepageTypeWidget(
                      type: "TYPE 1",
                      trip: "Days and Distances of the \n5 Longest Trips",
                      tripFontSize: 14,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Type1Page(),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                      child: HomepageTypeWidget(
                        type: "TYPE 2",
                        trip:
                            "Number of Vehicles Departing From\n A Given Location Between Two Dates",
                        tripFontSize: 11,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Type2SelectPage(),
                          ),
                        );
                      }),
                  GestureDetector(
                    child: HomepageTypeWidget(
                      type: "TYPE 3",
                      trip: "The Longest Trips of The Selected Date",
                      tripFontSize: 12,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Type3SelectPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
