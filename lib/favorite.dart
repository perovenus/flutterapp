import 'dart:io';
import 'package:flutter/material.dart';
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}
class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This  is Favorite Page'),
      ),
    );
  }
}