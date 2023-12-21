import 'package:intl/intl.dart';
import 'package:project/all_imports.dart';

class RelatedProduct extends StatefulWidget {
  final List<dynamic> category;
  const RelatedProduct({Key? key, required this.category}) : super(key: key);

  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  CarouselController buttonCarouselController = CarouselController();
  List<Widget> listRelatedCollection = [];
  @override
  void initState() {
    fetchRelatedCollection();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  Future<List<Widget>> fetchRelatedCollection() async {
    List<String> categories =
        widget.category.map((element) => element.toString()).toList();
    print(categories.first);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("products")
        .where("category", arrayContains: categories.first)
        .get();
    querySnapshot.docs.forEach((doc) {
      late double newprice;
      Map<String, dynamic> data = doc.data();
      String name = data['name'];
      List<dynamic> category = data['category'];
      String price = formatAsCurrency(data['money']).toString();
      String sale = data['sale'].toString();
      String shortDes = data['short-des'];
      String img_url = data['image'];
      String productId = doc.id;
      newprice = data['money'] - (data['money'] * (data['sale'] / 100));
      Widget product = SizedBox(
        child: ProductDetails(
          productId: productId,
          short_des: shortDes,
          new_price: price,
          old_price: formatAsCurrency(newprice).toString(),
          product_name: name,
          sale: sale,
          status: 'new',
          img_url: img_url,
          category: category,
        ),
      );
      setState(() {
        listRelatedCollection.add(product);
      });
    });
    return listRelatedCollection;
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: 'sản phẩm tương tự',
      morebtn: true,
      content: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    height: 405,
                    padEnds: false,
                    viewportFraction: 1.0 / 6.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                  ),
                  items: listRelatedCollection,
                ),
                ButtonPrev(buttonCarouselController: buttonCarouselController),
                ButtonNext(buttonCarouselController: buttonCarouselController),
              ],
            ),
          )
        ],
      ),
      category: '',
    );
  }
}
