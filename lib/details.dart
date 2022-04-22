import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
class Details extends StatefulWidget {
  final item;
  Details({this.item});
  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> { 
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
                      icon: const Icon(Icons.close),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20.0) //                 <--- border radius here
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Image.file(image, fit: BoxFit.fill),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(res, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                ),
                TextButton(
                    onPressed: () {Navigator.pop(context);
                    },
                    child: const Text('Xem chi tiết'),
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
    double width = MediaQuery.of(context).size.width;
    print(widget.item[0]['flag'].runtimeType);
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
                    top: width-30,
<<<<<<< Updated upstream
                    left: width-80,
=======
                    left: width - 80,
>>>>>>> Stashed changes
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite,
                        size: 35
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(13),
                        primary: Color(0xFFFF6262),
                        elevation: 15,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 13,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 15),
                            child: Text(
                              widget.item[0]['name'],
                              style: TextStyle(
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF36455A),
                              ),
                            )
                          ),
                        ),
                        widget.item[0]['flag'] == '0' ?
                        Expanded(
                          flex: 7,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 15),
                            child: ElevatedButton(
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
                              },
                              child: Container(
                                width: 80,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    'Đóng góp hình ảnh',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ),
                                )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF2DDA93),
                                shadowColor: Color(0xFF2DDA93),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                                )
                              )
                              
                            )
                          )
                        ) :
                        Container()

                      ]
                    ),
                    widget.item[0]['flag'] == '0' ?
                    Text(
                      'Hiện tại ứng dụng chưa có đủ dữ liệu hình ảnh để tiến hành nhận diện loài cây này',
                      style: TextStyle(
                        color: Color(0xFFFF6262),
                        fontSize: 16,
                      )
                    ) :
                    Container(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                            flex: 6,
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
                            flex: 6,
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
                            flex: 6,
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