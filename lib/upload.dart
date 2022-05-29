import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dbhandle/mongo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
class Upload extends  StatefulWidget {
    final name ;
    Upload({this.name =""});
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String imagepath = "";
  String base64string = "";
  bool _loading = true;
  File _image = new File('');
  List _output = [];
  int name = -1;
  final ImagePicker imgpicker = ImagePicker();
  @override
  void initState() {
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel1().then((value) {
      setState(() {});
    });
  }
  classifyImage1(File image) async {
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
      });
    }

    loadModel1() async {
      //this function loads our model
      await Tflite.loadModel(
          model: 'assets/model_unquant.tflite', labels: 'assets/uploadlabels.txt');
    }
  openImage() async {
    try {
        var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
        //you can use ImageCourse.camera for Camera capture
        if(pickedFile != null){
              imagepath = pickedFile.path;
              File imagefile = File(imagepath); //convert Path to File
              Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
              String _base64string = base64.encode(imagebytes); //convert bytes to base64 string
              setState(() {
                base64string = _base64string;
              });
              classifyImage1(imagefile);
        }else{
           print("No image is selected.");
        }
    }catch (e) {
        print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //linear color gradient
          backgroundColor: const Color(0xFF29D890),
          title: const Text(
            'Đóng góp cây thuốc',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.8),
          ),
        ),
         body: Container(
             alignment: Alignment.center,
             padding: EdgeInsets.all(20),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  Container(
                    width: 300,
                    height: 450,
                    child: imagepath != ""?Image.file(File(imagepath)):Image.asset('assets/images/altimage.png')),

                    //open button ----------------
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ElevatedButton(
                        onPressed: (){
                            openImage();
                        }, 
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                          child: Text("Chọn ảnh",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          )
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: name != 0 ? (){ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text("Không tìm thấy thực vật trong ảnh"),backgroundColor: Colors.deepOrange,));} : () {
                        MongoDatabase.insert(widget.name, base64string);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã đóng góp thành công")));
                        setState(() {
                          imagepath = "";
                          base64string = "";
                          name = -1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: name != 0 ? Colors.grey : Color(0xFF29D890),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                        child: Text("Đóng góp",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      )
                    ),
               ]
             ),
         )

    );
  } 
}