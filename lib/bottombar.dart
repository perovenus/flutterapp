import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'display.dart';
import 'favorite.dart';
import 'home.dart';
import 'detailS.dart';
class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}
class _NavbarState extends State<Navbar> {
    int selectedIndex = 1;
    final List<Widget> _children = [
      MongoDbinsert(),
      Home(),
      Favorite(),
    ];
    void OpenPage(int index) {
        setState(() {
          selectedIndex = index;
        });
    }

    bool _loading = true;
    File _image = new File('');
    List _output = [];
    String res = "";
    final picker = ImagePicker(); //allows us to pick image from gallery or camera
  
    @override
    void initState() {
      //initS is the first function that is executed by default when this class is called
      super.initState();
      loadModel().then((value) {
        setState(() {});
      });
    }

    @override
    void dispose() {
      //dis function disposes and clears our memory
      super.dispose();
      Tflite.close();
    }

    classifyImage(File image) async {
      //this function runs the model on the image
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 36, //the amout of categories our neural network can predict
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      print("output: $output");
      setState(() {
        _loading = false;
        _output = [output];
        res = _output[0][0]['confidence'] > 0.8  ?'Đây là: ${_output[0][0]['label']}\nĐộ chính xác: ${(_output[0][0]['confidence']*100).toStringAsFixed(2)}':'Chưa thể kết luận được';
      });
      showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 800,
            child:Column(
              
              children: <Widget>[
                //button icon close in left top corner
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(20.0) //                 <--- border radius here
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    child: Image.file(image, fit: BoxFit.fill),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(res, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                ),
                TextButton(
                    onPressed: () {Navigator.pop(context);
                    },
                    child: Text('Xem chi tiết'),
                  ) 
              ],
            ),
          );
        },
      );
    }

    loadModel() async {
      //this function loads our model
      await Tflite.loadModel(
          model: 'assets/model.tflite', labels: 'assets/labels.txt');
    }

    pickImage() async {
      //this function to grab the image from camera
      var image = await picker.getImage(source: ImageSource.camera);
      if (image == null) return null;

      setState(() {
        _image = File(image.path);
      });
      classifyImage(_image);
      
    }

    pickGalleryImage() async {
      //this function to grab the image from gallery
      var image = await picker.getImage(source: ImageSource.gallery);
      if (image == null){
        print('null');
        return null;
      }else{
        print('not null');
        setState(() {
          _image = File(image.path);
        });
        classifyImage(_image);
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          //linear color gradient
          backgroundColor: Color(0xFF000000),
          title: const Text(
            'Nhận diện cây thuốc nam',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.8),
          ),
        ),
        body: _children[selectedIndex], 
        bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle() ,
        child: Container(
          height: 60,
          //pading left right 20
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              IconButton(
                icon: Icon(Icons.folder, size:  40,),
                onPressed: (){
                  OpenPage(0);
                },
                //color of icon is 0xD2D2D2

                color: Color.fromRGBO(38, 38, 38, 0.4),
              ),
              IconButton(
                icon: Icon(Icons.favorite, size:  40,),
                onPressed: () {
                  OpenPage(2);
                },
                color: Color.fromRGBO(38, 38, 38, 0.4),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            OpenPage(1);
            showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                  bottom: Radius.circular(10.0)
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  height: 180,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          pickImage();
                          Navigator.pop(context);
                        },
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Container (
                            height: 60,
                            child: Center(
                              child: const Text(
                                'Chụp ảnh',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF007AFF)
                                )
                              )
                            )
                          ),
                        )
                      ),
                      Divider(
                        height: 0,
                      ),
                      InkWell(
                        onTap: () {
                          //pickGalleryImage and show image in modal bottom sheet
                          pickGalleryImage();
                          //show image in modal bottom sheet
                          Navigator.pop(context);
                        },
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Container (
                            height: 60,
                            child: Center(
                              child: const Text(
                                'Ảnh từ thư viện',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF007AFF)
                                )
                              )
                            )
                          ),
                        )
                      ),
                      Divider(
                        height: 0,
                      ),
                      InkWell(
                        onTap: () {Navigator.pop(context);},
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: Container (
                            height: 60,
                            child: Center(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFEF5757)
                                ),
                              )
                            )
                          ),
                        )
                      )
                    ],
                  )
                  
                  // child: Container()
                );
              }
            );
          },
          child: const Icon(
            Icons.camera_alt
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
    
}

