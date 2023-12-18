import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class PruductSlider extends StatefulWidget {
  final String category;
  const PruductSlider({super.key, required this.category});

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
  late double newprice;

  Future<List<Widget>> fetchDocuments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("category", arrayContains: widget.category)
          .get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String name = data['name'];
        String price = formatAsCurrency(data['money']).toString();
        String sale = data['sale'].toString();
        String shortDes = data['short-des'];
        String productId = doc.id;
        newprice = data['money'] - (data['money'] * (data['sale'] / 100));
        Widget product = ProductDetails(
            productId: productId,
            short_des: shortDes,
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
        category: widget.category,
        title: widget.category,
        morebtn: true,
        content: Row(
          children: [
            TextButton(
                onPressed: () {
                  CollectionReference orders =
                      FirebaseFirestore.instance.collection('products');
                  Future<void> addProduct() {
                    return orders.add({
                      'category': ['Màn Hình Máy Tính'],
                      'filter': {
                        'Kích thước': '27 inch',
                        'Tấm nền': 'Nano IPS',
                        'Tần số quét': '180Hz',
                      },
                      'money': '11990000',
                      'name': 'Màn Hình Gaming LG 27GP850-B NanoIPS/ 2K/ 165Hz',
                      'sale': 35,
                      'short-des':
                          '-Kích thước: 27 inch-Tấm nền: Nano IPS-Độ phân giải: QHD (2560 x 1440)-Tốc độ làm mới: 165Hz , 180Hz (Overclock)-Thời gian đáp ứng: 1ms (GtG at Faster)-Nổi bật : DCI-P3 98% Color Gamut with VESA DisplayHDR 400, AMD FreeSync™ , Vesa 100 x 100 mm , G-SYNC Compatible-Cổng kết nối: 2x HDMI, DisplayPort-Phụ kiện: Cáp nguồn, cáp DisplayPort',
                      // ignore: unnecessary_set_literal
                    }).then((value) => {print('ok')});
                  }

                  addProduct();
                },
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
