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
      appBar: AppBar(
          //linear color gradient
        backgroundColor: const Color(0xFF29D890),
        title: const Text(
          'Bộ sưu tập',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.8),
        ),
      ),
      body: Center(
        child: Text('This  is Favorite Page'),
      ),
    );
  }
}