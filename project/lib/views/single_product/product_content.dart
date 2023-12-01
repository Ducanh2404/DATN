import 'package:project/all_imports.dart';

class ProductContent extends StatelessWidget {
  const ProductContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32),
      width: 1600,
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(24),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 3, color: Color(0xFF3278f6)))),
                      child: Text('mô tả sản phẩm'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 21)),
                    ),
                  ],
                ),
              )),
          SizedBox(
            width: 32,
          ),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(24),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 3, color: Color(0xFF3278f6)))),
                      child: Text('thông số kỹ thuật'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 21)),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
