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
    static  Future<List<Map>> getData(String x) async {
    //create variable to get object from collection with name  = x
    final arrData = await userCollection.find().toList();
    //Convert arraydata to json
    final arr = toJson(arrData).toList();
    print(arr.where((o)=>{o["Name"]==x}).toList());
    print("djtme cuoc doi");
    return arrData;
}
}