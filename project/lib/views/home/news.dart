import 'package:project/all_imports.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'img/product/product1.jpg',
      'img/product/product1.jpg',
      'img/product/product1.jpg',
      'img/product/product1.jpg',
    ];
    return CustomContainer(
        title: 'chuyên trang khuyến mãi',
        morebtn: false,
        content: [
          Container(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Container(width: 20, color: Colors.red),
                Container(width: 20, color: Colors.blue),
              ],
            ),
          )
        ]);
  }
}
