import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dbhandle/mongo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        return Category(data: DATA, initdata: DATA);
      }
    ); //end builder

    
  }
}

class Category extends StatefulWidget {
  
  List data = [];
  List initdata = [];
  
  Category({ Key? key, required this.data, required this.initdata }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Danh mục');

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //linear color gradient
        backgroundColor: const Color(0xFF29D890),
        title: customSearchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar =  ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      controller: myController,
                      onEditingComplete: () {
                        if(myController.text.isEmpty) {
                          setState(() {
                            widget.data = widget.initdata;
                          });
                        } else {
                          setState(() {
                            widget.data = widget.data.where((plant) => 
                              plant['name'].toLowerCase().contains(myController.text.toLowerCase())
                            ).toList();
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm...',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('Danh mục',
                    style: const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 0.8
                  ));
                }
              });
            },
            icon: customIcon
          )
        ]
      ),
      body: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Details(item:[widget.data[index]])),
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
                              child:Image.network(widget.data[index]['image_src'])),
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
                                      widget.data[index]['name'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  ),
                                  widget.data[index]['flag'] == '0' ? 
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
                                                    widget.data[index]['science_name'],
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
                                                    widget.data[index]['family'],
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
                                    widget.data[index]['functions'],
                                    maxLines: widget.data[index]['flag'] == '0' ? 2 : 3,
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
                    widget.data[index]['flag'] == '0' ? 
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
}