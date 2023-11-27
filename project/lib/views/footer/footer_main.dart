import 'package:project/all_imports.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

class FooterMain extends StatelessWidget {
  const FooterMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1600,
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(children: [
          const Row(
            children: [
              FooterItem(
                  title: 'Danh Mục Sản Phẩm',
                  item1: 'PC Gaming',
                  item2: 'Laptop Gaming',
                  item3: 'VGA NVidia Rtx 4070',
                  item4: 'Màn Hình giá rẻ',
                  item5: 'VGA NVidia Rtx 4060'),
              FooterItem(
                  title: 'Thông Tin Chung',
                  item1: 'Giới Thiệu',
                  item2: 'Tuyển Dụng',
                  item3: 'VGA NVidia Rtx 4070',
                  item4: 'Tin Tức',
                  item5: 'Ý Kiến Khách Hàng'),
              FooterItem(
                  title: 'Chính Sách',
                  item1: 'Quy Định Chung',
                  item2: 'Chính Sách Vận Chuyển',
                  item3: 'Chính Sách Bảo Hành',
                  item4: 'Chính Sách Đổi, Trả Hàng',
                  item5: 'Chính Sách Cho Doanh Nghiệp'),
              FooterItem(
                  title: 'Thông Tin Khuyến Mại',
                  item1: 'Quy Định Chung',
                  item2: 'Chính Sách Vận Chuyển',
                  item3: 'Chính Sách Bảo Hành',
                  item4: 'Chính Sách Đổi, Trả Hàng',
                  item5: 'Chính Sách Cho Doanh Nghiệp'),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Container(
                width: 350,
                height: 210,
                child: const HtmlWidget(
                    '''<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.767559905542!2d105.84159807591003!3d21.001952588697478!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac70cf94287f%3A0x7362ea6005b5ac6e!2sTNC%20Store!5e0!3m2!1svi!2s!4v1701075821731!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'''),
              ),
              SizedBox(width: 32,),
              Column(children: [],)
            ],
          ),
        ]));
  }
}

class FooterItem extends StatelessWidget {
  final String title;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  const FooterItem(
      {Key? key,
      required this.title,
      required this.item1,
      required this.item2,
      required this.item3,
      required this.item4,
      required this.item5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 5,
          ),
          Links(cnt: item1),
          Links(cnt: item2),
          Links(cnt: item3),
          Links(cnt: item4),
          Links(cnt: item5),
        ],
      ),
    );
  }
}

class Links extends StatefulWidget {
  const Links({Key? key, required this.cnt}) : super(key: key);
  final String cnt;
  @override
  _LinksState createState() => _LinksState();
}

class _LinksState extends State<Links> {
  TextDecoration underline = TextDecoration.none;
  Color textColor = Colors.black;
  void hoverLink() {
    setState(() {
      underline = underline == TextDecoration.none
          ? TextDecoration.underline
          : TextDecoration.none;
      textColor = textColor == Colors.black ? Color(0xFF3278f6) : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            alignment: Alignment.centerLeft,
            overlayColor: TransparentButton(),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
        onPressed: () {},
        onHover: (hover) {
          setState(() {
            hoverLink();
          });
        },
        child: Text(
          widget.cnt,
          style: TextStyle(
              color: textColor,
              decoration: underline,
              decorationColor: Color(0xFF3278f6),
              fontSize: 16,
              height: 1.25),
        ));
  }
}
