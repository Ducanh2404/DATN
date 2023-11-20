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
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: _isHovered ? Color(0xFF3278f6) : Color(0xFFededed),
                width: _isHovered ? 3.0 : 1.0)),
        child: Column(
          children: [
            TextButton(
              style: ButtonStyle(
                overlayColor: TransparentButton(),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(0)),
              ),
              child: Image(
                image: AssetImage('img/product/product1.jpg'),
                fit: BoxFit.contain,
              ),
              onPressed: () {},
            ),
            Text("123")
          ],
        ),
      ),
    );
  }
}
