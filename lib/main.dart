import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yazlab2_mobil_sorgular/pages/Anasayfa.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip1.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip2.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip3.dart';
import 'package:yazlab2_mobil_sorgular/pages/tip3_mapView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: Color.fromRGBO(253, 216, 53, 1),
        accentColor: Color.fromRGBO(253, 216, 53, 1),
      ),
      home: Anasayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}
