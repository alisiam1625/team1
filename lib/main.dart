import 'package:flutter/material.dart';
import 'package:team1/11theam.dart';
import 'package:team1/home.dart';
import 'package:team1/theam3.dart';
import 'package:team1/them10.dart';
import 'package:team1/them11.dart';
import 'package:team1/them2.dart';
import 'package:team1/them4.dart';
import 'package:team1/them5l.dart';
import 'package:team1/them6.dart';
import 'package:team1/them7.dart';
import 'package:team1/them8.dart';
import 'package:team1/them9.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      // home:   DemoDashboard6(),
      // home:   DemoDashboard6(),
      // home:   DemoCHomePage(),
      home:   DemoTinderHomePage(),
    );
  }
}

