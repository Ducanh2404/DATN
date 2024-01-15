import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class PruductSlider extends StatefulWidget {
  final String category;
  final String thumbnailImg;
  const PruductSlider(
      {super.key, required this.category, required this.thumbnailImg});

  @override
  _PruductSliderState createState() => _PruductSliderState();
}

class _PruductSliderState extends State<PruductSlider> {
  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue =
        (value / 1000).round() * 1000; // Round to the nearest million
    return numberFormat.format(roundedValue);
  }

  List<Widget> listProducts = [];
  late double newprice;

  Future<List<Widget>> fetchDocuments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("category", arrayContains: widget.category)
          .get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<dynamic> category = data['category'];
        String name = data['name'];
        String price = formatAsCurrency(data['money']).toString();
        String sale = data['sale'].toString();
        String shortDes = data['short-des'];
        String img_url = data['image'];
        String productId = doc.id;
        newprice = data['money'] - (data['money'] * (data['sale'] / 100));
        Widget product = ProductDetails(
          productId: productId,
          short_des: shortDes,
          new_price: price,
          old_price: formatAsCurrency(newprice).toString(),
          product_name: name,
          sale: sale,
          status: 'new',
          img_url: img_url,
          category: category,
        );
        setState(() {
          listProducts.add(product);
        });
      });
    } catch (e) {
      print(' $e');
    }
    return listProducts;
  }

  @override
  void initState() {
    fetchDocuments();
    super.initState();
  }

  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        category: widget.category,
        title: widget.category,
        morebtn: true,
        content: Row(
          children: [
            if (Responsive.isDesktop(context))
              TextButton(
                  onPressed: () {
                    // FirebaseFirestore.instance
                    //     .collection('products')
                    //     .get()
                    //     .then((QuerySnapshot prod) {
                    //   prod.docs.forEach((element) {
                    //     Map<String, dynamic> data =
                    //         element.data() as Map<String, dynamic>;
                    //     newprice = data['money'] -
                    //         (data['money'] * (data['sale'] / 100));
                    //     DocumentReference document = FirebaseFirestore.instance
                    //         .collection('products')
                    //         .doc(element.id);
                    //     document
                    //         .update({'sell': (newprice / 1000).round() * 1000});
                    //     print('ô kê');
                    //   });
                    // });
                  },
                  style: ButtonStyle(
                      overlayColor: TransparentButton(),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 0.0))),
                  child: Image(image: NetworkImage(widget.thumbnailImg))),
            Expanded(
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 405,
                      padEnds: false,
                      viewportFraction: Responsive.isDesktop(context)
                          ? 1.0 / 5
                          : Responsive.isTablet(context)
                              ? 1.0 / 3.0
                              : 1,
                      initialPage: 0,
                    ),
                    items: listProducts,
                  ),
                  ButtonPrev(
                      buttonCarouselController: buttonCarouselController),
                  ButtonNext(
                      buttonCarouselController: buttonCarouselController),
                ],
              ),
            )
          ],
        ));
  }
}
