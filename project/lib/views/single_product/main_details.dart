import 'package:project/all_imports.dart';

class MainDetails extends StatefulWidget {
  final String new_price;
  final String old_price;
  final String product_name;
  final String sale;
  const MainDetails(
      {Key? key,
      required this.new_price,
      required this.old_price,
      required this.product_name,
      required this.sale})
      : super(key: key);

  @override
  State<MainDetails> createState() => _MainDetailsState();
}

class _MainDetailsState extends State<MainDetails> {
  int num = 1;
  Color color1 = Colors.white;
  Color color2 = Color(0xFF3278f6);
  Color color3 = Colors.white;
  Color color4 = Color(0xFF3278f6);

  void add() {
    setState(() {
      num++;
    });
  }

  void minus() {
    setState(() {
      num = (num == 1) ? 1 : num - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.only(top: 32),
      color: Colors.white,
      width: 1600,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Image(
                    image: AssetImage('img/product/product1.jpg'),
                  ),
                ],
              )),
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.product_name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'MSP: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF8d94ac)),
                    ),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xffededed)))),
                    ),
                    Row(
                      children: [
                        Text(widget.new_price,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.red)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            widget.old_price,
                            style: TextStyle(
                              color: Color(0xFF8d94ac),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xFF8d94ac),
                            ),
                          ),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      height: 16,
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xffededed)))),
                    ),
                    Row(
                      children: [
                        Text(
                          'Số lượng',
                          style: TextStyle(
                              color: Color(0xFF8d94ac),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        IconButton(
                            iconSize: 15,
                            style: ButtonStyle(
                              overlayColor: TransparentButton(),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                      color: Color(0xFF8d94ac), width: 1),
                                ),
                              ),
                            ),
                            onPressed: () {
                              minus();
                            },
                            icon: FaIcon(FontAwesomeIcons.minus)),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xFF8d94ac), width: 1)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 4.5),
                          child: Text(
                            "$num",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                            iconSize: 15,
                            style: ButtonStyle(
                              overlayColor: TransparentButton(),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(
                                      color: Color(0xFF8d94ac), width: 1),
                                ),
                              ),
                            ),
                            onPressed: () {
                              add();
                            },
                            icon: FaIcon(FontAwesomeIcons.plus))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            color2),
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 20.0)),
                                    overlayColor: TransparentButton(),
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(
                                          color: Color(0xFF3278f6), width: 1),
                                    ))),
                                onPressed: () {},
                                onHover: (a) {
                                  setState(() {
                                    color1 = color1 == Colors.white
                                        ? Color(0xFF3278f6)
                                        : Colors.white;
                                    color2 = color2 == Color(0xFF3278f6)
                                        ? Colors.white
                                        : Color(0xFF3278f6);
                                  });
                                },
                                child: Text(
                                  'Thêm Vào Giỏ Hàng',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: color1),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(color3),
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 20.0)),
                                  overlayColor: TransparentButton(),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                        color: Color(0xFF3278f6), width: 1),
                                  ))),
                              onPressed: () {},
                              onHover: (b) {
                                setState(() {
                                  color3 = color3 == Colors.white
                                      ? Color(0xFF3278f6)
                                      : Colors.white;
                                  color4 = color4 == Color(0xFF3278f6)
                                      ? Colors.white
                                      : Color(0xFF3278f6);
                                });
                              },
                              child: Text('Mua Ngay',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: color4,
                                  ))),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFfb4e4e), width: 1)),
                    child: Column(
                      children: [
                        Container(
                            color: Color(0xFFfb4e4e),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: CustomIcon(
                                titleColor: Colors.white,
                                title: '  Khuyến mãi khi mua sản phẩm',
                                icon: FontAwesomeIcons.gift,
                                color: Colors.white)),
                        Container(
                          height: 200,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 16,
                    decoration: BoxDecoration(
                        border: BorderDirectional(
                            bottom: BorderSide(
                                width: 1, color: Color(0xffededed)))),
                  ),
                  CustomIcon(
                      titleColor: Colors.black,
                      title: '  Hỗ trợ trả góp 0%, trả trước 0 đ',
                      icon: FontAwesomeIcons.creditCard,
                      color: Color(0xFF29324e)),
                  CustomIcon(
                      titleColor: Colors.black,
                      title: '  Hoàn tiền 200% nếu có hàng giả',
                      icon: FontAwesomeIcons.moneyBill,
                      color: Color(0xFF29324e)),
                  CustomIcon(
                      titleColor: Colors.black,
                      title: '  Giao hàng nhanh trên toàn quốc',
                      icon: FontAwesomeIcons.truckFast,
                      color: Color(0xFF29324e)),
                  CustomIcon(
                      titleColor: Colors.black,
                      title: '  Hỗ trợ kĩ thuật online 24/7',
                      icon: FontAwesomeIcons.headphones,
                      color: Color(0xFF29324e)),
                  CustomIcon(
                      titleColor: Colors.black,
                      title: '  Vệ sinh miễn phí PC, Laptop trọn đời',
                      icon: FontAwesomeIcons.wrench,
                      color: Color(0xFF29324e)),
                ],
              )),
        ],
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final String title;
  final Color titleColor;
  final IconData icon;
  final Color color;

  CustomIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(size: 18, color: color, icon),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: titleColor),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
