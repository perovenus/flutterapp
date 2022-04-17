import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';
import 'dart:convert';
class MongoDatabase{
    static var db, userCollection;
    static connect() async {
        db = await Db.create(MONOGO_CONN_URL);
        await db.open();
        userCollection = db.collection(USER_COLLECTION);
        print("Connect Successfull!!!");

    }
    static  Future<List<dynamic>> getData(String x) async {
    //create variable to get object from collection with name  = x
    final arrData = await userCollection.find({"Name": x}).toList();
    return arrData;
}
}