import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dbhandle/mongo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends  StatefulWidget {
    final name ;
    Upload({this.name =""});
  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String base64string = "";
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
               children: [

                  imagepath != ""?Image.file(File(imagepath)):Image.asset('assets/images/altimage.png'),

                    //open button ----------------
                    ElevatedButton(
                      onPressed: (){
                          openImage();
                      }, 
                      child: Text("Chọn ảnh")
                    ),  
                    ElevatedButton(
                      onPressed: (){
                        MongoDatabase.insert(widget.name, base64string);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã đóng góp thành công")));
                        setState(() {
                          imagepath = "";
                          base64string = "";
                        });
                      }, 
                      child: Text("Đóng góp")
                    ),
               ]
             ),
         )

    );
  } 
}