import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
import 'details.dart';
class ListItem extends StatefulWidget {
  @override
  _ListItem createState() => _ListItem();
}
class _ListItem extends State<ListItem> {
        @override
    Widget build(BuildContext context) {
        return FutureBuilder(
        future: MongoDatabase.getAllData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List DATA = snapshot.data ?? [];
          return Scaffold(
            body: ListView.builder(
              itemCount: DATA.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details(item:[DATA[index]])),
                    );
                  },
                  child: Card(
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Stack(
                        children: [
                          Container(
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
                                        DATA[index]['flag'] == '0' ? 
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Text(
                                            'Thiếu dữ liệu',
                                            style: TextStyle(
                                              color: Color(0xFFFF6262),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ),
                                        ) : 
                                        Container(),
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
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Text(
                                                          DATA[index]['science_name'],
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w400
                                                          )
                                                        )
                                                      )
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
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                        child: Text(
                                                          DATA[index]['family'],
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w400
                                                          )
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
                                          margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                                          maxLines: DATA[index]['flag'] == '0' ? 2 : 3,
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
                          ),
                          DATA[index]['flag'] == '0' ? 
                          Container(
                            height: 170,
                            color: Color.fromRGBO(199, 199, 199, 0.278)
                          ) : 
                          Container()
                        ]
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