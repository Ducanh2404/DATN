import 'package:project/all_imports.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isHovered = false;
  Color _textColor = Colors.black;
  void _changeColor() {
    setState(() {
      _textColor = _textColor == Colors.black ? Colors.red : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Stack(
        children: [
          Container(
            height: 250,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: TransparentButton(),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(3)),
              ),
              child: const Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage('img/product/product1.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
              onPressed: () {},
            ),
          ),
          Container(
              decoration: const BoxDecoration(color: Color(0xFF8FFF00)),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: const Text(
                "Best choice",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      border: BorderDirectional(
                          top: BorderSide(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Color(0xFFededed)))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 38,
                        child: TextButton(
                            style: ButtonStyle(
                              overlayColor: TransparentButton(),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                            ),
                            onPressed: () {},
                            onHover: (value) {
                              setState(() {
                                  _changeColor();
                              });
                            },
                            child: Text('PC Đỗ Đại Học 2023',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: _textColor))),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, size: 12, color: Color(0xFF8d94ac)),
                          Icon(Icons.star, size: 12, color: Color(0xFF8d94ac)),
                          Icon(Icons.star, size: 12, color: Color(0xFF8d94ac)),
                          Icon(Icons.star, size: 12, color: Color(0xFF8d94ac)),
                          Icon(Icons.star, size: 12, color: Color(0xFF8d94ac)),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'đánh giá',
                            style: TextStyle(
                                color: Color(0xFF8d94ac), fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('19.990.000 đ',style: TextStyle(color: Color(0xFF8d94ac),fontWeight: FontWeight.w700, fontSize: 14,decoration: TextDecoration.lineThrough,decorationColor: Color(0xFF8d94ac),),),
                      Row(
                        children: [
                          const Text('17.690.000 đ',style: TextStyle(color: Color(0xFFfb4e4e),fontSize: 20,fontWeight: FontWeight.w800,height: 1.25),),
                          Container(
                            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFfb4e4e),width: 2)),
                            padding:const EdgeInsets.symmetric(horizontal: 3),
                            margin: const EdgeInsets.only(left: 8),
                            child: const Text('-12%',style: TextStyle(color: Color(0xFFfb4e4e),fontSize: 12,fontWeight: FontWeight.w600),),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: _isHovered ? 3.0 : 1.0,
                color: _isHovered ? const Color(0xFF3278f6) : const Color(0xFFededed),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: _isHovered ? 3.0 : 1.0,
                height: double.infinity,
                color: _isHovered ? const Color(0xFF3278f6) : const Color(0xFFededed),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: _isHovered ? 3.0 : 1.0,
                height: double.infinity,
                color: _isHovered ? const Color(0xFF3278f6) : const Color(0xFFededed),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: _isHovered ? 3.0 : 1.0,
                color: _isHovered ? const Color(0xFF3278f6) : const Color(0xFFededed),
              )),
        ],
      ),
    );
  }
}
