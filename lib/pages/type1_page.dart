import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2_mobil_sorgular/theme/top_bar.dart';
import 'package:yazlab2_mobil_sorgular/widgets/widgets.dart';

class Type1Page extends StatefulWidget {
  @override
  _Type1PageState createState() => _Type1PageState();
}

class _Type1PageState extends State<Type1Page> {
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
                      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Text(
                        "Days and Distances \n of The 5 Longest Trip ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
          Flexible(
            child: FutureBuilder(
              future: getDataType1(),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TripInformationWidget(
                          pickupDate: snapshot.data[index]["taxiDatas"]
                                  ["tpep_pickup_datetime"]
                              .toString(),
                          dropoffDate: snapshot.data[index]["taxiDatas"]
                                  ["tpep_dropoff_datetime"]
                              .toString(),
                          pickupLocation: snapshot.data[index]["pickupLocation"]
                              ["Borough"],
                          dropoffLocation: snapshot.data[index]
                              ["dropoffLocation"]["Borough"],
                          passengerCount: snapshot.data[index]["taxiDatas"]
                              ["passenger_count"],
                          amount: snapshot.data[index]["taxiDatas"]
                              ["total_amount"],
                          distance: snapshot.data[index]["taxiDatas"]
                                  ["trip_distance"]
                              .toDouble(),
                        );
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

Future<List> getDataType1() async {
  List list = [];
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

    var doLocationQuery = await databaseReference
        .collection("lokasyonlar")
        .where("LocationID", isEqualTo: int.parse(data["DOLocationID"]))
        .get();

    Map<String, dynamic> oneTaxiData = {
      "taxiDatas": data,
      "pickupLocation": puLocationQuery.docs[0].data(),
      "dropoffLocation": doLocationQuery.docs[0].data(),
    };

    list.add(oneTaxiData);
  }
  return list;
}
