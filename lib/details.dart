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
        body: 
        SingleChildScrollView(
        child: Column(
            children: <Widget>[
                InkWell(
                   onTap:(){
                      Navigator.pop(context);
                    },
                   child:  Container(
                    child: Image.network(widget.item[0]['image_src']),
                )
               ),
                Container(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                    child: SingleChildScrollView(
                        child: Column(
                    children: <Widget> [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>  [
                                Text(widget.item[0]['name'] , style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),),
                                Icon(Icons.favorite, size: 40, color: Colors.red),
                                ]
                        ),
                        Divider(
                        height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>  [
                                Text('Tên khoa học' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(widget.item[0]['science_name'], style: TextStyle(fontSize: 20))
                            ]
                        ),
                        Divider(
                        height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>  [
                                Text('Thuộc họ' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text(widget.item[0]['family'], style: TextStyle(fontSize: 20))
                            ]
                        ),
                        Divider(
                        height: 10,
                        ),
                        Row(
                            children: <Widget>  [
                                Text('Mô tả' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ]
                        ),
                        Text(widget.item[0]['describe'], style: TextStyle(fontSize: 16)),
                        Divider(
                        height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>  [
                                Text('Bộ phận dùng' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Text('Phần trên mặt đất', style: TextStyle(fontSize: 20),)
                            ]
                        ),
                        Divider(
                        height: 10,
                        ),
                        Row(
                            children: <Widget>  [
                                Text('Công năng, chủ trị' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ]
                        ),
                        Text('Thanh nhiệt, giải độc, khu phong trừ thấp, tiêu viêm. Rễ cây chữa gân xương đau nhức, mỏi lưng, mỏi gối, kinh nguyệt không đều, viêm túi mật, vàng da, vàng mắt. Dùng ngoài ngâm rửa trĩ, lòi dom. Lá cây chữa tăng huyết áp, khí hư bạch đới, Lá dùng ngoài trị vết thương, tắm ghẻ, chốc đầu. Hoa dùng trị ngứa', style: TextStyle(fontSize: 16)),
                        Divider(
                        height: 10,
                        ),
                        Row(
                            children: <Widget>  [
                                Text('Cách dùng' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ]
                        ),
                        Divider(
                        height: 10,
                        ),
                        Text('Rễ ngày dùng 12 - 16g, sắc uống. Dùng 1 kg cành lá, rửa sạch, đun sôi với nước 30 phút, lọc lấy nước, nhỏ giọt liên tục lên vết thương hoặc ngâm vết thương ngày 2 lần, mỗi lần 1 giờ.', style: TextStyle(fontSize: 16),),

                    ]
                )
                    )
                )
            ]
        )
      )

    );}
}