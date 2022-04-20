import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
import 'bottombar.dart';
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
      home: Navbar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
