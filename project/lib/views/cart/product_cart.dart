import 'package:project/all_imports.dart';

// ignore: must_be_immutable
class CartProduct extends StatefulWidget {
  final String productId;
  final String productName;
  final String price;
  final String image;
  int quantity;
  CartProduct({
    Key? key,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.image,
  }) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  String emailUser = "";
  void getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {});
      emailUser = user.email!;
    }
  }

  Future<void> increaseQuantity(
    String user,
    String productId,
  ) async {
    DocumentReference cartRef =
        FirebaseFirestore.instance.collection('cart').doc(user);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(cartRef);
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        Map<String, dynamic> product = data!['products'];
        int currentValue = product[productId] ?? 0;
        int newValue = currentValue + 1;
        product[productId] = newValue;
        transaction.update(cartRef, {'products': product});
      }
    });
  }

  Future<void> decreaseQuantity(
    String user,
    String productId,
  ) async {
    DocumentReference cartRef =
        FirebaseFirestore.instance.collection('cart').doc(user);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(cartRef);
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        Map<String, dynamic> product = data!['products'];
        int currentValue = product[productId] ?? 0;
        int newValue = currentValue - 1;
        product[productId] = newValue;
        transaction.update(cartRef, {'products': product});
      }
    });
  }

  Future<void> deleteProduct(
    String user,
    String productId,
  ) async {
    DocumentReference cartRef =
        FirebaseFirestore.instance.collection('cart').doc(user);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(cartRef);
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        Map<String, dynamic> product =
            data?['products'] as Map<String, dynamic>;
        product.remove(productId);
        transaction.update(cartRef, {'products': product});
      }
    });
  }

  void add() {
    setState(() {
      widget.quantity++;
      increaseQuantity(emailUser, widget.productId);
    });
  }

  void minus() {
    setState(() {
      widget.quantity = widget.quantity - 1;
      if (widget.quantity > 0) {
        decreaseQuantity(emailUser, widget.productId);
      } else if (widget.quantity == 0) {
        deleteProduct(emailUser, widget.productId);
        visible = false;
      }
    });
  }

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
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
                  image: AssetImage('img/product/${widget.image}'),
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
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(0)),
                                ),
                                onPressed: () {},
                                child: Text(widget.productName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.chakraPetch()
                                            .fontFamily,
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
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              IconButton(
                                  iconSize: 15,
                                  style: ButtonStyle(
                                    overlayColor: TransparentButton(),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
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
                              style: ButtonStyle(
                                  overlayColor: TransparentButton()),
                              onPressed: () {
                                setState(() {
                                  visible = false;
                                });
                                deleteProduct(emailUser, widget.productId);
                              },
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
      ),
    );
  }
}
