import 'package:flutter/material.dart';
class Details extends StatefulWidget {
  final item;
  Details({this.item});
  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFFBFDFF),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(219, 215, 215, 0.0),
          elevation: 0,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Image.network(widget.item[0]['image_src']),
                    Positioned(
                      top: 200,
                      left: 320,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          size: 35
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(13),
                          primary: Color(0xFFFF6262) 

                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text(
                          widget.item[0]['name'],
                          style: TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF36455A)
                          )
                        )
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Tên khoa học',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF495566)
                                ),
                              )
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                widget.item[0]['science_name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF495566)
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Thuộc họ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6A6F7D),
                                ),
                              )
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                widget.item[0]['family'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6A6F7D),
                                )
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          'Mô tả',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF495566)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          widget.item[0]['describe'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6A6F7D),
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Bộ phận dùng',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF495566)
                                ),
                              )
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                widget.item[0]['parts_used'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6A6F7D),
                                )
                              )
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Công năng, chủ trị',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF495566)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          widget.item[0]['functions'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6A6F7D),
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Liều lượng và cách dùng',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF495566)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          widget.item[0]['usage'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6A6F7D),
                          )
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          )
        )
      );
    }
}