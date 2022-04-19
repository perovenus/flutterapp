import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
class MongoDbinsert extends StatelesWidget {
  @override
  _MongoDbinsertState createState() => _MongoDbinsertState();
}
class _MongoDbinsertState extends State<MongoDbinsert> {
        @override
    Widget build(BuildContext context) {
        return new FutureBuilder(
        future: MongoDatabase.getDataByName("Cây Nghệ"),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null){
            return new Container(
              child: Center(
                child: Text("Loading..."),
              ),
            );
          }
          else{
            return new Container(
              child: Center(
                child: Text(snapshot.data.toString()),
              ),
            );
          }
        });
  }

}