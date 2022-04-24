import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
import 'bottombar.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'searchbar.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabase.connect();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicinal Plants',
      home: Navbar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
