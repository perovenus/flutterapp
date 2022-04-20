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
//Get all data from collection
    static Future<List<dynamic>>  getAllData() async {
        print('djtmecuocdoi');
        List result = await userCollection.find().toList();
        return result;
    }

    static  Future<List<dynamic>> getDataByName(String x) async {
        final arrData = await userCollection.find({"name": x}).toList();
        return arrData;
    }
}