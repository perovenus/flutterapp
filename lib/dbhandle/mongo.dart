import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';
import 'dart:convert';
class MongoDatabase{
    static var db, detailCollection, imageCollection;
    static connect() async {
        db = await Db.create(MONOGO_CONN_URL);
        await db.open();
        detailCollection = db.collection(DETAIL_COLLECTION);
        imageCollection = db.collection(IMAGE_COLLECTION);
        print("Connect Successfull!!!");

    }
//Get all data from collection
    static Future<List<dynamic>>  getAllData() async {
        print("Get all data");
        List result = await detailCollection.find().toList();
        return result;
    }

    static  Future<List<dynamic>> getDataByName(int x) async {
        List arrData = await detailCollection.find({"name": x}).toList();
        print('arrData: $arrData');
        return arrData;
    }
    static Future<void> insert(String _name, String _image_base64 ) async {
        final  detail = {
            'id': ObjectId(),
            'name': _name,
            'image_base64': _image_base64
        };
        await imageCollection.insert(detail);
        print("Insert Successfull!!!");
    }
}