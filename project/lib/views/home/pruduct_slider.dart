import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class PruductSlider extends StatefulWidget {
  const PruductSlider({super.key});

  @override
  _PruductSliderState createState() => _PruductSliderState();
}

class _PruductSliderState extends State<PruductSlider> {
  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value > 1000000)
        ? (value / 1000000).round() * 1000000
        : (value / 1000).round() * 1000; // Round to the nearest million
    return numberFormat.format(roundedValue);
  }

  List<Widget> listProducts = [];
  var newprice;
  Future<List<Widget>> fetchDocuments() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String name = data['name'].toString();
        String price = formatAsCurrency(data['money']).toString();
        String sale = data['sale'].toString();
        newprice = data['money'] - (data['money'] * (data['sale'] / 100));
        Widget product = ProductDetails(
            new_price: price,
            old_price: formatAsCurrency(newprice).toString(),
            product_name: name,
            sale: sale,
            status: 'new');
        setState(() {
          listProducts.add(product);
        });
      });
    } catch (e) {
      print('Failed to fetch documents: $e');
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
        title: 'pc đồ họa nổi bật',
        morebtn: true,
        content: Row(
          children: [
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor: TransparentButton(),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 0.0))),
                child: const Image(
                    image: AssetImage('img/product-thumbnail/category1.jpg'))),
            Expanded(
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 405,
                      padEnds: false,
                      viewportFraction: 1.0 / 5.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
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
