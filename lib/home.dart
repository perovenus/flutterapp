import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dbhandle/mongo.dart';
import 'category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image = new File('');
  List _output = [];
  String res = "";
  final picker = ImagePicker(); //allows us to pick image from gallery or camera

  List DATA = [
    { 
      'id': 1,
      'source': 'assets/images/bacha.jpg',
      'Ten': 'Bạc hà',
      'Ten khoa hoc': 'Mentha arvensis L',
      'Ho': 'Lamiaceae',
      'Bo phan dung': 'Bộ phận trên mặt đất',
      'Cong nang': 'Sơ phong, thanh nhiệt, thấu chẩn, sơ can, giải uất, giải độc. Chữa cảm mạo phong nhiệt, cảm cúm, ngạt mũi, nhức đầu, đau mắt đỏ, thúc đẩy sởi mọc, ngực sườn đầy tức.'
    },
    { 
      'id': 2,
      'source': 'assets/images/bachho.jpg',
      'Ten': 'Bách hộ',
      'Ten khoa hoc': 'Stemona tuberosa Lour',
      'Ho': 'Stemonaceae',
      'Bo phan dung': 'Rễ',
      'Cong nang': 'Nhuận phế, chỉ ho, sát trùng. Chữa các chứng ho mới hoặc ho lâu ngày, viêm phế quản mạn tính, trị giun kim, ngứa, ghẻ lở.'
    },
    { 
      'id': 3,
      'source': 'assets/images/bachdongnu.jpg',
      'Ten': 'Bạch đồng nữ',
      'Ten khoa hoc': 'Clerodendrum chinense (Osbeck.) Mabb var. simplex (Mold.) S. L. Chen',
      'Ho': 'Verbenaceae',
      'Bo phan dung': 'Rễ, lá, hoa',
      'Cong nang': 'Thanh nhiệt, giải độc, khu phong trừ thấp, tiêu viêm. Rễ cây chữa gân xương đau nhức, mỏi lưng, mỏi gối, kinh nguyệt không đều, viêm túi mật, vàng da, vàng mắt. Dùng ngoài ngâm rửa trĩ, lòi dom. Lá cây chữa tăng huyết áp, khí hư bạch đới, Lá dùng ngoài trị vết thương, tắm ghẻ, chốc đầu. Hoa dùng trị ngứa'
    },
    { 
      'id': 4,
      'source': 'assets/images/bachhoaxaxietthao.jpg',
      'Ten': 'Bạch hoa xà thiệt thảo',
      'Ten khoa hoc': 'Hedyotis diffusa Willd',
      'Ho': 'Rubiaceae',
      'Bo phan dung': 'Toàn cây',
      'Cong nang': 'Thanh nhiệt giải độc, lợi niệu thông lâm, tiêu ung tán kết. Chữa phế nhiệt, hen suyễn, viêm họng, viêm Amydal, viêm đường tiết niệu, viêm đại tràng (trường ung). Dùng ngoài chữa vết thương, rắn cắn, côn trùng đốt.'
    },
    { 
      'id': 5,
      'source': 'assets/images/banhanam.jpg',
      'Ten': 'Bán hạ nam',
      'Ten khoa hoc': 'Typhonium trilobatum (L.) Schott',
      'Ho': 'Araceae',
      'Bo phan dung': 'Thân rễ. Khi dùng phải qua chế biến cẩn thận',
      'Cong nang': 'Hóa đàm táo thấp, giáng nghịch chỉ nôn, giáng khí chỉ ho. Chữa nôn, buồn nôn, đầy trướng bụng, ho có đờm, ho lâu ngày. Dùng ngoài chữa ong đốt, rắn rết cắn.'
    },
    { 
      'id': 6,
      'source': 'assets/images/boconganh.jpg',
      'Ten': 'Bố công anh',
      'Ten khoa hoc': 'Lactuca indica L',
      'Ho': 'Asteraceae',
      'Bo phan dung': 'Phần trên mặt đất',
      'Cong nang': 'Thanh nhiệt giải độc, tiêu viêm tán kết. Chữa mụn nhọt sang lở, tắc tia sữa, viêm tuyến vú, nhiễm trùng đường tiết niệu.'
    },
  ];

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
                  onPressed: () {Navigator.pop(context);},
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
        backgroundColor: Color(0xFF29D890),
        title: const Text(
          'Nhận diện cây thuốc nam',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 0.8),
        ),
      ),
      body: CategoryListPage(),
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
                onPressed: () {},
                //color of icon is 0xD2D2D2

                color: Color.fromRGBO(38, 38, 38, 0.4),
              ),
              IconButton(
                icon: Icon(Icons.favorite, size:  40,),
                onPressed: () {},
                color: Color.fromRGBO(38, 38, 38, 0.4),
              ),
            ],
          ),
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