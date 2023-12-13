import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class CartMain extends StatefulWidget {
  const CartMain({Key? key}) : super(key: key);

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value > 1000000)
        ? (value / 1000000).round() * 1000000
        : (value / 1000).round() * 1000; // Round to the nearest million
    return numberFormat.format(roundedValue);
  }

  double sumPrice = 0;
  double sumQuantity = 0;
  List<Widget> listInfoCart = [];
  List<Widget> listCart = [];
  Future<List<Widget>> fetchProducts() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      try {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await FirebaseFirestore.instance
                .collection('cart')
                .doc(userEmail)
                .get();
        if (documentSnapshot.exists) {
          Map<String, dynamic>? data = documentSnapshot.data();
          if (data!.containsKey('products')) {
            Map<String, dynamic> fieldValue = data['products'];
            fieldValue.forEach((key, value) async {
              DocumentSnapshot<Map<String, dynamic>> product =
                  await FirebaseFirestore.instance
                      .collection("products")
                      .doc(key)
                      .get();
              if (product.exists) {
                Map<String, dynamic>? productDetail = product.data();
                dynamic nameProd = productDetail!['name'];
                dynamic price = productDetail['money'];
                dynamic sale = productDetail['sale'];
                double newprice = price - (price * (sale / 100));
                Widget prod = CartProduct(
                    productName: nameProd,
                    price: formatAsCurrency(newprice).toString(),
                    quantity: value);
                Widget prodInfo = InfoCart(
                  name: nameProd,
                  price: formatAsCurrency(newprice).toString(),
                );
                void updateCart() {
                  sumPrice += (newprice * value);
                  sumQuantity += value;
                }

                setState(() {
                  sumPrice += (newprice * value);
                  sumQuantity += value;
                  listCart.add(prod);
                  listInfoCart.add(prodInfo);
                });
              }
            });
          }
        }
      } catch (e) {
        print('Failed to fetch documents: $e');
      }
    }
    return listCart;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1600,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.only(top: 32),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Thông tin sản phẩm",
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18)),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: listCart,
                    )
                  ],
                ),
              )),
          SizedBox(
            width: 24,
          ),
          Expanded(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.all(24.0),
                  margin: const EdgeInsets.only(top: 32),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Thông tin giỏ hàng",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18)),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: listInfoCart,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng số lượng sản phẩm',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            sumQuantity.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng chi phí',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            formatAsCurrency(sumPrice).toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF3278f6)),
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
                                child: Text(
                                  'Tiến hành thanh toán',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}

class InfoCart extends StatefulWidget {
  final String name;
  final String price;
  const InfoCart({Key? key, required this.name, required this.price})
      : super(key: key);

  @override
  _InfoCartState createState() => _InfoCartState();
}

class _InfoCartState extends State<InfoCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Image(
                image: AssetImage('img/product/product1.jpg'),
                fit: BoxFit.contain,
              )),
          SizedBox(
            width: 16,
          ),
          Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              clipBehavior: Clip.hardEdge,
                              style: ButtonStyle(
                                overlayColor: TransparentButton(),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(0)),
                              ),
                              onPressed: () {},
                              child: Text(widget.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.chakraPetch().fontFamily,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black))),
                          Text(
                            widget.price,
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.chakraPetch().fontFamily,
                                color: Colors.red,
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CartProduct extends StatefulWidget {
  final String productName;
  final String price;
  int quantity;
  CartProduct(
      {Key? key,
      required this.productName,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  void initState() {
    super.initState();
  }

  int add() {
    setState(() {
      widget.quantity++;
    });
    return widget.quantity;
  }

  int minus() {
    setState(() {
      widget.quantity = (widget.quantity == 1) ? 1 : widget.quantity - 1;
    });
    return widget.quantity;
  }

  double parseCurrencyString(String currencyString) {
    String cleanString = currencyString.replaceAll('.', '').replaceAll('₫', '');
    return double.parse(cleanString);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Image(
                image: AssetImage('img/product/product1.jpg'),
              )),
          SizedBox(
            width: 16,
          ),
          Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                overlayColor: TransparentButton(),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(0)),
                              ),
                              onPressed: () {},
                              child: Text(widget.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.chakraPetch().fontFamily,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black))),
                          Text(
                            widget.price,
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.chakraPetch().fontFamily,
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 15,
                                style: ButtonStyle(
                                  overlayColor: TransparentButton(),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
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
                                widget.quantity.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ),
                            IconButton(
                                iconSize: 15,
                                style: ButtonStyle(
                                  overlayColor: TransparentButton(),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
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
                        TextButton(
                            style:
                                ButtonStyle(overlayColor: TransparentButton()),
                            onPressed: () {},
                            child: Text(
                              'Xóa',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
