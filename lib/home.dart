import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'details.dart';
import 'dbhandle/mongo.dart';
class Home extends StatefulWidget {
  final name;
  final percent;
  Home({this.name = "Hãy chọn 1 ảnh", this.percent = 0.00});
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDatabase.getDataByName(widget.name),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      List DATA = snapshot.data ?? [];
      if (DATA.length == 0) {
        DATA = [
          {
            "name": "Hãy chọn 1 ảnh",
            "image_src": "https://docs.google.com/uc?export=download&id=1JZwV3VUB3E_6mF40cT1QsqjTYJSG823C"
          }
        ];
      }
      return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 80),
            child: Container(
              // width: MediaQuery.of(context).size.width,
              child: Column(
                    children: <Widget>[
                      // Padding(
                      //   padding: EdgeInsets.only(top:16.0),
                      // ),
                      Text( DATA[0]['name'], style: TextStyle(fontSize: 20),),
                      Padding(
                        padding: EdgeInsets.only(top:16.0),
                      ),
                      CircularPercentIndicator(
                            radius: 110.0,
                            lineWidth: 10.0,
                            animation: true,
                            percent: widget.percent,
                            center:CircleAvatar(
                              backgroundImage: NetworkImage(DATA[0]['image_src']),
                              radius: 100.0,
                            ),
                            progressColor: Colors.green,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16.0),
                      ),
                      Text('Chính xác: ' +(widget.percent*100).toStringAsFixed(2) +'%', style: TextStyle(fontSize: 20),),
                      //add button to see details
                      Padding(
                        padding: EdgeInsets.only(top:16.0),
                      ),
                      RaisedButton(
                        color: Color(0xFF29D890),
                        child: Text('Xem chi tiết', style: TextStyle(fontSize: 20, color:Colors.white),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Details(item :DATA)));
                        },
                      ),

                    ]
                  ),
            )
          ),
      ),
    );

    }

    ); //end return 
  } //end build 
}