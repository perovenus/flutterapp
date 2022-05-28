import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
import 'bottombar.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'searchbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MongoDatabase.connect();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
