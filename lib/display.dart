import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
class MongoDbinsert extends StatefulWidget {
  @override
  _MongoDbinsertState createState() => _MongoDbinsertState();
}
class _MongoDbinsertState extends State<MongoDbinsert> {
        @override
    Widget build(BuildContext context) {
        return new FutureBuilder(
        future: MongoDatabase.getData("Bạc Hà"),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            return new SingleChildScrollView(
            padding: new EdgeInsets.all(8.0),
            child: new Text(
                snapshot.data[0]['Name'].toString(),
                style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
                ),
            ));
        });
  }

}