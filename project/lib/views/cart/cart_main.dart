import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class CartMain extends StatefulWidget {
  const CartMain({Key? key}) : super(key: key);

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain> {
  TextEditingController cityController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String fieldCityError = '';
  String fieldNameError = '';
  String fieldPhoneError = '';
  String fieldAddressError = '';
  String method = "";
  void getPayMethod(String method) {
    if (method == "banking") {
      setState(() {
        method = "banking";
      });
    }
    if (method == "cash") {
      setState(() {
        method = "cash";
      });
    }
  }

  Future<void> clearCart(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(documentId)
          .delete();
      print(
          'Document with ID "$documentId" successfully deleted from collection .');
    } catch (error) {
      print(
          'Error deleting document with ID "$documentId" from collection: $error');
    }
  }

  Future<void> addOrder() {
    CollectionReference orders = FirebaseFirestore.instance.collection('order');
    User? user = FirebaseAuth.instance.currentUser;
    String? email;

    if (user != null) {
      email = user.email;
    }
    return orders.add({
      'receiver': nameController.text,
      'email': email,
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'total': sumPrice,
      'method': method,
      'city': cityController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'status': '1',
      'items': itemscart,
    }).then((value) => {
          clearCart(email!),
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Đơn hàng đã đặt thành công'),
                actions: [
                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ))
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          ),
        });
  }

  void checkingInfo() {
    fieldCityError = '';
    fieldNameError = '';
    fieldPhoneError = '';
    fieldAddressError = '';
    if (cityController.text.isEmpty) {
      setState(() {
        fieldCityError = 'Vui lòng cung cấp đầy đủ thông tin';
      });
    }
    if (nameController.text.isEmpty) {
      setState(() {
        fieldNameError = 'Vui lòng cung cấp đầy đủ thông tin';
      });
    }
    if (phoneController.text.isEmpty) {
      setState(() {
        fieldPhoneError = 'Vui lòng cung cấp đầy đủ thông tin';
      });
    }
    if (addressController.text.isEmpty) {
      setState(() {
        fieldAddressError = 'Vui lòng cung cấp đầy đủ thông tin';
      });
    }
    if (cityController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      addOrder();
      itemscart = {};
    }
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value > 1000000)
        ? (value / 1000000).round() * 1000000
        : (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  double sumPrice = 0;
  double sumQuantity = 0;
  List<Widget> listInfoCart = [];
  List<Widget> listCart = [];
  Map<String, int> itemscart = {};

  Future<List<Widget>> fetchProducts() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      try {
        DocumentSnapshot<Map<String, dynamic>> userCart =
            await FirebaseFirestore.instance
                .collection('cart')
                .doc(userEmail)
                .get();
        if (userCart.exists) {
          Map<String, dynamic>? data = userCart.data();
          if (data!.containsKey('products')) {
            Map<String, dynamic> items = data['products'];
            items.forEach((key, value) async {
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
                setState(() {
                  sumPrice += (newprice * value);
                  sumQuantity += value;
                  itemscart[key] = value;
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

  bool cartVisible = true;
  bool shipVisible = false;
  String confirm = 'Tiến hành thanh toán';
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
                    Visibility(
                      visible: cartVisible,
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
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF3278f6)),
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20)),
                                    overlayColor: TransparentButton(),
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
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
                    ),
                    Visibility(
                      visible: shipVisible,
                      child: ShipInfo(
                        cityController: cityController,
                        nameController: nameController,
                        phoneController: phoneController,
                        addressController: addressController,
                        fieldCityError: fieldCityError,
                        fieldNameError: fieldNameError,
                        fieldPhoneError: fieldPhoneError,
                        fieldAddressError: fieldAddressError,
                        method: getPayMethod,
                      ),
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
                                onPressed: () {
                                  setState(() {
                                    cartVisible = false;
                                    shipVisible = true;
                                  });
                                  if (confirm == 'Tiến hành thanh toán') {
                                    setState(() {
                                      confirm = 'Xác nhận mua hàng';
                                    });
                                  } else if (confirm == 'Xác nhận mua hàng') {
                                    checkingInfo();
                                  }
                                },
                                child: Text(
                                  confirm,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(vertical: 22),
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Image(
                                    image:
                                        AssetImage('img/payment/pay_cart.png')))
                          ],
                        ),
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
                  ))),
        ],
      ),
    );
  }
}
