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
    static  Future<List<dynamic>> getDataByName(String x) async {
        print(x);
        final arrData = await userCollection.find({"name": x}).toList();
        print(arrData);
        return arrData;
    }
}