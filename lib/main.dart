import 'package:flutter/material.dart';
import 'home.dart';
// import mongo file from folder dbhandle
import 'dbhandle/mongo.dart';
import 'display.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicinal Plants',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
