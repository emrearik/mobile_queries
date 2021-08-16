import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yazlab2_mobil_sorgular/data/Date.dart';
import 'package:yazlab2_mobil_sorgular/theme/themes.dart';
import 'package:yazlab2_mobil_sorgular/widgets/widgets.dart';
import 'package:intl/intl.dart';

class Type2Page extends StatefulWidget {
  final Date date;
  final String selectedLocation;

  Type2Page({Key key, this.date, this.selectedLocation}) : super(key: key);

  var formattedDate = new DateFormat('dd/MM/yyyy H:m:s');

  @override
  _Type2PageState createState() => _Type2PageState();
}

class _Type2PageState extends State<Type2Page> {
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
                      "Number of Vehicles Departing From\n A Given Location Between Two Dates",
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
              future: getDataType2(widget.date, widget.selectedLocation),
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Selected Start Date: ${DateFormat('dd/MM/yyyy').format(widget.date.startDate).toString()}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Selected End Date: ${DateFormat('dd/MM/yyyy').format(widget.date.endDate).toString()}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total Vehicle Count: " +
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
                              return TripInformationWidget(
                                pickupDate: snapshot.data[index]["taxiDatas"]
                                        ["tpep_pickup_datetime"]
                                    .toString(),
                                dropoffDate: snapshot.data[index]["taxiDatas"]
                                        ["tpep_dropoff_datetime"]
                                    .toString(),
                                pickupLocation: snapshot.data[index]
                                    ["pickupLocation"]["Borough"],
                                dropoffLocation: snapshot.data[index]
                                    ["dropoffLocation"]["Borough"],
                                passengerCount: snapshot.data[index]
                                    ["taxiDatas"]["passenger_count"],
                                amount: snapshot.data[index]["taxiDatas"]
                                    ["total_amount"],
                                distance: snapshot.data[index]["taxiDatas"]
                                        ["trip_distance"]
                                    .toDouble(),
                              );
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

Future<List> getDataType2(Date date, String selectedLocation) async {
  var startDate = int.parse(
      (DateTime.parse(date?.startDate.toString()).millisecondsSinceEpoch / 1000)
          .toStringAsFixed(0));
  var endDate = int.parse(
      (DateTime.parse(date?.endDate.toString()).millisecondsSinceEpoch / 1000)
          .toStringAsFixed(0));

  final databaseReference = FirebaseFirestore.instance;

  var snapshot = await databaseReference
      .collection("veriler")
      .where("PULocationID", isEqualTo: selectedLocation)
      .get();

  List taxiDatas = [];

  for (var item in snapshot.docs) {
    var data = item.data();
    if (data["tpep_pickup_datetime"] >= startDate &&
        data["tpep_pickup_datetime"] <= endDate) {
      //find pickup location.
      var puLocationQuery = await databaseReference
          .collection("lokasyonlar")
          .where("LocationID", isEqualTo: int.parse(data["PULocationID"]))
          .get();

      //find dropoff location
      var doLocationQuery = await databaseReference
          .collection("lokasyonlar")
          .where("LocationID", isEqualTo: int.parse(data["DOLocationID"]))
          .get();

      //create map with oneTaxiData and location information.
      Map<String, dynamic> oneTaxiData = {
        "taxiDatas": data,
        "pickupLocation": puLocationQuery.docs[0].data(),
        "dropoffLocation": doLocationQuery.docs[0].data(),
      };

      taxiDatas.add(oneTaxiData);
    }
  }
  return taxiDatas;
}
