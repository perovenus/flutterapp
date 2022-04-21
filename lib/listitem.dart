import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
import 'details.dart';
class MongoDbinsert extends StatefulWidget {
  @override
  _MongoDbinsertState createState() => _MongoDbinsertState();
}
class _MongoDbinsertState extends State<MongoDbinsert> {
        @override
    Widget build(BuildContext context) {
        return new FutureBuilder(
        future: MongoDatabase.getAllData(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List DATA = snapshot.data ?? [];
          return new Scaffold(
            body: new ListView.builder(
              itemCount: DATA.length,
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details(item:[DATA[index]])),
                    );
                  },
                  child: new Card(
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Container(
                        height: 170,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0), 
                                child:Image.network(DATA[index]['image_src'])),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        DATA[index]['name'],
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Tên khoa học',
                                                    style: TextStyle(
                                                      color: Color(0xFFA1A8B9),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  Text(
                                                    DATA[index]['science_name'],
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Họ',
                                                    style: TextStyle(
                                                      color: Color(0xFFA1A8B9),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  Text(
                                                    DATA[index]['family'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400
                                                    )
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: 
                                      Text('Mô tả',
                                        style: TextStyle(
                                          color: Color(0xFFA1A8B9),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DATA[index]['functions'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400
                                      )
                                    ),
                                  ],
                                )
                              )
                            )
                          ],
                        )
                      )
                    ),
                  ),
              );
            },
          ),
        );
      }
    ); //end builder
  }
}