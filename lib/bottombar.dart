import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
// import 'listitem.dart';
import 'favorite.dart';
import 'home.dart';
import 'category.dart';
class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}
class _NavbarState extends State<Navbar> {
    final List<Widget> _children = [
      Category(),
      Home(name:-1, percent: 0.00),
      Favorite(),
    ];
    void OpenPage(int index) {
      setState(() {
        selectedIndex = index;
      });
    }
    int selectedIndex = 1;
    double percent = 0.00;
    int name = -1;
    bool _loading = true;
    File _image = new File('');
    List _output = [];

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
        numResults: 10, //the amout of categories our neural network can predict
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        _loading = false;
        _output = [output];
        name = _output[0][0]['index'];
        percent = _output[0][0]['confidence'];
        _children[1] = Home(name: name, percent: percent);
      });
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
        return null;
      }else{

        setState(() {
          _image = File(image.path);
        });
        classifyImage(_image);
      }
    }

    bool pressCategory = false;
    bool pressFavourite = false;
    bool firstpress = true;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        
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
              InkWell(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.folder,
                        size: 40,
                        color: pressCategory ? Color(0xFF2DDA93) : Color.fromRGBO(38, 38, 38, 0.4),
                      ),
                      Text(
                        'Danh mục',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: pressCategory ? Color(0xFF2DDA93) : Color.fromRGBO(38, 38, 38, 0.4),
                        )
                      )
                    ],
                  )
                ),
                onTap: (){
                  setState((){
                    firstpress = true;
                  });
                  OpenPage(0);
                  if (!pressCategory & !pressFavourite){
                    setState(() {
                      pressCategory = !pressCategory;
                    });
                  }
                  else if(!pressCategory & pressFavourite) {
                    pressCategory = !pressCategory;
                    pressFavourite = !pressFavourite;
                  }
                },
              ),
              InkWell(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 40,
                        color: pressFavourite ? Color(0xFF2DDA93) : Color.fromRGBO(38, 38, 38, 0.4),
                      ),
                      Text(
                        'Bộ sưu tập',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: pressFavourite ? Color(0xFF2DDA93) : Color.fromRGBO(38, 38, 38, 0.4),
                        )
                      )
                    ],
                  )
                ),
                onTap: (){
                  setState(() {
                    firstpress = true;
                  });
                  OpenPage(2);
                  if (!pressCategory & !pressFavourite){
                    setState(() {
                      pressFavourite = !pressFavourite;
                    });
                  }
                  else if(pressCategory & !pressFavourite) {
                    pressCategory = !pressCategory;
                    pressFavourite = !pressFavourite;
                  }
                },
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (firstpress){
              setState(() {
                firstpress = false;
                pressCategory = false;
                pressFavourite = false;
              });
              OpenPage(1);
            }else{
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
                          Navigator.pop(context);
                          //show image in modal bottom sheet
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
                              child: Text(
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
            }


          },
          child: const Icon(
            Icons.camera_alt
          )
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
    
}

