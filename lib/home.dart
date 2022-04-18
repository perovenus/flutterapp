import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image = new File('assets/images/plant.jpg');
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
    print(output);
    setState(() {
      _loading = false;
      _output = [output];
      res = _output[0][0]['confidence'] > 0.8  ?'Đây là: ${_output[0][0]['label']}\nĐộ chính xác: ${(_output[0][0]['confidence']*100).toStringAsFixed(2)}':'Chưa thể kết luận được';
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
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF29D890),
        title: const Text(
          'Nhận diện cây thuốc nam',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.8),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle() ,
        child: Container(
          height: 60,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                        pickGalleryImage();
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