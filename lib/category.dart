import 'package:flutter/material.dart';
class CategoryListPage extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: Text('Category List'),
        ),
        body: Center(
            child: Column(
                        children: [
                         Container(
                                height: 180,
                                color: Colors.pink,
                                child: Card(
                                child: Row(
                                    children: [
                                        Container(
                                            height: 128,
                                            width: 128,
                                            color: Colors.pink,
                                            child: Image.network('https://picsum.photos/250?image=9'),
                                        ),
                                        Icon(Icons.arrow_right),
                                    ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.all(10),
                                ),
                            ),
                            Text('Push'),
                        ],
                        ),
        ),
        );
    }
}