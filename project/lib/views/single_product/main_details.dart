import 'package:project/all_imports.dart';

class MainDetails extends StatefulWidget {
  final String productId;
  final String price;
  final String sale_price;
  final String product_name;
  final String sale;
  final String short_des;
  final String image;
  const MainDetails(
      {Key? key,
      required this.price,
      required this.sale_price,
      required this.product_name,
      required this.sale,
      required this.short_des,
      required this.productId,
      required this.image})
      : super(key: key);

  @override
  State<MainDetails> createState() => _MainDetailsState();
}

class _MainDetailsState extends State<MainDetails> {
  String separateItems(String text) {
    List<String> items = text.split('*');
    String separatedText = items.join('\n- ');
    return separatedText;
  }

  int num = 1;
  Color color1 = Colors.white;
  Color color2 = const Color(0xFF3278f6);
  Color color3 = Colors.white;
  Color color4 = const Color(0xFF3278f6);
  @override
  void initState() {
    super.initState();
  }

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

  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  void addToCart(String productId, int quantity) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      CollectionReference cart = FirebaseFirestore.instance.collection('cart');
      cart.doc(userEmail).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic>? cartData =
              documentSnapshot.data() as Map<String, dynamic>?;
          Map<String, dynamic>? products =
              cartData?['products'] as Map<String, dynamic>?;
          int updatedQuantity = quantity;
          if (products != null && products.containsKey(productId)) {
            updatedQuantity += products[productId] as int;
          }
          cart.doc(userEmail).set({
            'products': {productId: updatedQuantity},
          }, SetOptions(merge: true)).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thêm vào giỏ hàng thành công'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }).catchError((error) {
            print('$error');
          });
        } else {
          cart.doc(userEmail).set({
            'products': {productId: quantity},
          }, SetOptions(merge: true)).then((value) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thêm vào giỏ hàng thành công'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }).catchError((error) {
            print(' $error');
          });
        }
      }).catchError((error) {
        print(' $error');
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Vui lòng đăng nhập để sử dụng tính năng này'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      margin: const EdgeInsets.only(top: 32),
      color: Colors.white,
      width: 1600,
      child: Responsive.isDesktop(context)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(widget.image),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.product_name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          Container(
                            height: 16,
                            decoration: const BoxDecoration(
                                border: BorderDirectional(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffededed)))),
                          ),
                          Text(
                            separateItems(widget.short_des),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Row(
                            children: [
                              Text(widget.sale_price,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.red)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  widget.price,
                                  style: const TextStyle(
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
                                        color: const Color(0xFFfb4e4e),
                                        width: 2)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '-${widget.sale}%',
                                  style: const TextStyle(
                                      color: Color(0xFFfb4e4e),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            height: 16,
                            decoration: const BoxDecoration(
                                border: BorderDirectional(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffededed)))),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Số lượng',
                                style: TextStyle(
                                    color: Color(0xFF8d94ac),
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                width: 16,
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
                                    minus();
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.minus)),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF8d94ac),
                                        width: 1)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 4.5),
                                child: Text(
                                  "$num",
                                  style: const TextStyle(
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
                                  icon: const FaIcon(FontAwesomeIcons.plus))
                            ],
                          ),
                          const SizedBox(
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
                                                color: Color(0xFF3278f6),
                                                width: 1),
                                          ))),
                                      onPressed: () {
                                        addToCart(widget.productId, num);
                                      },
                                      onHover: (a) {
                                        setState(() {
                                          color1 = color1 == Colors.white
                                              ? const Color(0xFF3278f6)
                                              : Colors.white;
                                          color2 =
                                              color2 == const Color(0xFF3278f6)
                                                  ? Colors.white
                                                  : const Color(0xFF3278f6);
                                        });
                                      },
                                      child: Text(
                                        'Thêm Vào Giỏ Hàng',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: color1),
                                      ))),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                color3),
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
                                              color: Color(0xFF3278f6),
                                              width: 1),
                                        ))),
                                    onPressed: () {
                                      addToCart(widget.productId, num);
                                      Future<void> _delayedFunction() async {
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Cart(),
                                            ));
                                      }

                                      _delayedFunction();
                                    },
                                    onHover: (b) {
                                      setState(() {
                                        color3 = color3 == Colors.white
                                            ? const Color(0xFF3278f6)
                                            : Colors.white;
                                        color4 =
                                            color4 == const Color(0xFF3278f6)
                                                ? Colors.white
                                                : const Color(0xFF3278f6);
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
                        CustomIcon(
                            titleColor: Colors.black,
                            title: '  Hỗ trợ trả góp 0%, trả trước 0 đ',
                            icon: FontAwesomeIcons.creditCard,
                            color: const Color(0xFF29324e)),
                        CustomIcon(
                            titleColor: Colors.black,
                            title: '  Hoàn tiền 200% nếu có hàng giả',
                            icon: FontAwesomeIcons.moneyBill,
                            color: const Color(0xFF29324e)),
                        CustomIcon(
                            titleColor: Colors.black,
                            title: '  Giao hàng nhanh trên toàn quốc',
                            icon: FontAwesomeIcons.truckFast,
                            color: const Color(0xFF29324e)),
                        CustomIcon(
                            titleColor: Colors.black,
                            title: '  Hỗ trợ kĩ thuật online 24/7',
                            icon: FontAwesomeIcons.headphones,
                            color: const Color(0xFF29324e)),
                        CustomIcon(
                            titleColor: Colors.black,
                            title: '  Vệ sinh miễn phí PC, Laptop trọn đời',
                            icon: FontAwesomeIcons.wrench,
                            color: const Color(0xFF29324e)),
                      ],
                    )),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.product_name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      Container(
                        height: 16,
                        decoration: const BoxDecoration(
                            border: BorderDirectional(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffededed)))),
                      ),
                      Text(
                        separateItems(widget.short_des),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(widget.sale_price,
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              widget.price,
                              style: const TextStyle(
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
                              style: const TextStyle(
                                  color: Color(0xFFfb4e4e),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        height: 16,
                        decoration: const BoxDecoration(
                            border: BorderDirectional(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xffededed)))),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Số lượng',
                            style: TextStyle(
                                color: Color(0xFF8d94ac),
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 16,
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
                                minus();
                              },
                              icon: const FaIcon(FontAwesomeIcons.minus)),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF8d94ac), width: 1)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4.5),
                            child: Text(
                              "$num",
                              style: const TextStyle(
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
                              icon: const FaIcon(FontAwesomeIcons.plus))
                        ],
                      ),
                      const SizedBox(
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
                                  onPressed: () {
                                    addToCart(widget.productId, num);
                                  },
                                  onHover: (a) {
                                    setState(() {
                                      color1 = color1 == Colors.white
                                          ? const Color(0xFF3278f6)
                                          : Colors.white;
                                      color2 = color2 == const Color(0xFF3278f6)
                                          ? Colors.white
                                          : const Color(0xFF3278f6);
                                    });
                                  },
                                  child: Text(
                                    'Thêm Vào Giỏ Hàng',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: color1),
                                  ))),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            color3),
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
                                  addToCart(widget.productId, num);
                                  Future<void> _delayedFunction() async {
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Cart(),
                                        ));
                                  }

                                  _delayedFunction();
                                },
                                onHover: (b) {
                                  setState(() {
                                    color3 = color3 == Colors.white
                                        ? const Color(0xFF3278f6)
                                        : Colors.white;
                                    color4 = color4 == const Color(0xFF3278f6)
                                        ? Colors.white
                                        : const Color(0xFF3278f6);
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
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomIcon(
                          titleColor: Colors.black,
                          title: '  Hỗ trợ trả góp 0%, trả trước 0 đ',
                          icon: FontAwesomeIcons.creditCard,
                          color: const Color(0xFF29324e)),
                      CustomIcon(
                          titleColor: Colors.black,
                          title: '  Hoàn tiền 200% nếu có hàng giả',
                          icon: FontAwesomeIcons.moneyBill,
                          color: const Color(0xFF29324e)),
                      CustomIcon(
                          titleColor: Colors.black,
                          title: '  Giao hàng nhanh trên toàn quốc',
                          icon: FontAwesomeIcons.truckFast,
                          color: const Color(0xFF29324e)),
                      CustomIcon(
                          titleColor: Colors.black,
                          title: '  Hỗ trợ kĩ thuật online 24/7',
                          icon: FontAwesomeIcons.headphones,
                          color: const Color(0xFF29324e)),
                      CustomIcon(
                          titleColor: Colors.black,
                          title: '  Vệ sinh miễn phí PC, Laptop trọn đời',
                          icon: FontAwesomeIcons.wrench,
                          color: const Color(0xFF29324e)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
