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
                      onPressed: imagepath == "" ? null : () {
                        MongoDatabase.insert(widget.name, base64string);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã đóng góp thành công")));
                        setState(() {
                          imagepath = "";
                          base64string = "";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: imagepath == "" ? Colors.grey : Color(0xFF29D890),
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