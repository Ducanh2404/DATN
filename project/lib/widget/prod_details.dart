import 'package:project/all_imports.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final String new_price;
  final String old_price;
  final String product_name;
  final String sale;
  final String status;
  final String short_des;
  final String img_url;
  final List<dynamic> category;
  ProductDetails(
      {super.key,
      required this.new_price,
      required this.old_price,
      required this.product_name,
      required this.sale,
      required this.status,
      required this.short_des,
      required this.productId,
      required this.img_url,
      required this.category});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var banner = true;
  bool _isHovered = false;
  Color _textColor = Colors.black;
  void _changeColor() {
    setState(() {
      _textColor = _textColor == Colors.black ? Colors.red : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    var titleBanner;
    var bannerColor;
    var colorTitleBanner =
        (widget.status == "new") ? Colors.black : Colors.white;

    if (widget.status == "none") {
      banner = false;
      titleBanner = "";
    }
    ;
    if (widget.status == "sell") {
      titleBanner = "Best Seller";
      bannerColor = Color(0xFFf28902);
    }
    ;
    if (widget.status == "choice") {
      titleBanner = "Best Choice";
      bannerColor = Color(0xFFE30019);
    }
    ;
    if (widget.status == "new") {
      titleBanner = "New";
      bannerColor = Color(0xFF8FFF00);
    }
    ;
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
              child: Align(
                alignment: Alignment.topCenter,
                child: Image(
                  image: AssetImage('img/product/${widget.img_url}'),
                  fit: BoxFit.contain,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleProduct(
                              productId: widget.productId,
                              short_des: widget.short_des,
                              new_price: widget.new_price,
                              old_price: widget.old_price,
                              product_name: widget.product_name,
                              sale: widget.sale,
                              status: widget.status,
                              image: widget.img_url,
                              category: widget.category,
                            )));
              },
            ),
          ),
          Visibility(
            visible: banner,
            child: Container(
                decoration: BoxDecoration(color: bannerColor),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  titleBanner,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorTitleBanner),
                )),
          ),
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
                        child: TextButton(
                            style: ButtonStyle(
                              overlayColor: TransparentButton(),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleProduct(
                                            category: widget.category,
                                            productId: widget.productId,
                                            short_des: widget.short_des,
                                            new_price: widget.new_price,
                                            old_price: widget.old_price,
                                            product_name: widget.product_name,
                                            sale: widget.sale,
                                            status: widget.status,
                                            image: widget.img_url,
                                          )));
                            },
                            onHover: (value) {
                              setState(() {
                                _changeColor();
                              });
                            },
                            child: Text(widget.product_name,
                                maxLines: 2,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
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
                      Text(
                        widget.new_price,
                        style: TextStyle(
                          color: Color(0xFF8d94ac),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Color(0xFF8d94ac),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.old_price,
                            style: TextStyle(
                                color: Color(0xFFfb4e4e),
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                height: 1.25),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFfb4e4e), width: 2)),
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            margin: const EdgeInsets.only(left: 8),
                            child: Text(
                              '-${widget.sale}%',
                              style: TextStyle(
                                  color: Color(0xFFfb4e4e),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
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
                color: _isHovered
                    ? const Color(0xFF3278f6)
                    : const Color(0xFFededed),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: _isHovered ? 3.0 : 1.0,
                height: double.infinity,
                color: _isHovered
                    ? const Color(0xFF3278f6)
                    : const Color(0xFFededed),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: _isHovered ? 3.0 : 1.0,
                height: double.infinity,
                color: _isHovered
                    ? const Color(0xFF3278f6)
                    : const Color(0xFFededed),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: _isHovered ? 3.0 : 1.0,
                color: _isHovered
                    ? const Color(0xFF3278f6)
                    : const Color(0xFFededed),
              )),
        ],
      ),
    );
  }
}
