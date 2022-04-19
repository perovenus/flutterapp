import 'package:flutter/material.dart';
class CategoryListPage extends StatelessWidget{
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
  Widget build(BuildContext context) {
      return Scrollbar(
      child: ListView.builder(
        itemCount: DATA.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print('Djtme cuoc doi');
            },
            child: Card(
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: Container(
                  height: 170,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0), 
                          child:Image.asset(DATA[index]['source'])),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  DATA[index]['Ten'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Tên khoa học',
                                                style: TextStyle(
                                                  color: Color(0xFFA1A8B9),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              )
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                DATA[index]['Ten khoa hoc'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Họ',
                                                style: TextStyle(
                                                  color: Color(0xFFA1A8B9),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              )
                                            ),
                                            Align(alignment: Alignment.topLeft,
                                              child: Text(
                                                DATA[index]['Ho'],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400
                                                )
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Align(alignment: Alignment.topLeft,
                                  child: Text('Mô tả',
                                    style: TextStyle(
                                      color: Color(0xFFA1A8B9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  DATA[index]['Cong nang'],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                  )
                                ),
                              )
                            ],
                          )
                        )
                      )
                    ],
                  )
                )
              ),
            ),
          );
        }
      ),
    );
  }
}