import 'package:project/all_imports.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isHovered = false;

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
          TextButton(
            style: ButtonStyle(
              overlayColor: TransparentButton(),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(3)),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('img/product/product1.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            onPressed: () {},
          ),
          Container(
              decoration: BoxDecoration(color: Color(0xFF8FFF00)),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                "Best choice",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              )),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _isHovered ? double.infinity : 0.0,
                height: _isHovered ? 3.0 : 0.0,
                decoration: BoxDecoration(color: Color(0xFF3278f6)),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: _isHovered ? 3.0 : 0.0,
                height: _isHovered ? double.infinity : 0.0,
                decoration: BoxDecoration(color: Color(0xFF3278f6)),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: _isHovered ? 3.0 : 0.0,
                height: _isHovered ? double.infinity : 0.0,
                decoration: BoxDecoration(color: Color(0xFF3278f6)),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _isHovered ? double.infinity : 0.0,
                height: _isHovered ? 3.0 : 0.0,
                decoration: BoxDecoration(color: Color(0xFF3278f6)),
              )),
          Positioned.fill(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(12),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("123"),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
