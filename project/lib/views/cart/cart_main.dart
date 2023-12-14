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
                    productId: key,
                    productName: nameProd,
                    price: formatAsCurrency(newprice).toString(),
                    quantity: value);
                Widget prodInfo = InfoCart(
                  productId: key,
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
                    ),
                    Center(
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF3278f6)),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20)),
                              overlayColor: TransparentButton(),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    color: Color(0xFF3278f6), width: 1),
                              ))),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Cart(),
                                  ));
                            });
                          },
                          child: Text(
                            'Cập nhật giỏ hàng',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          )),
                    ),
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
