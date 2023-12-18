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
                      'category': ['Laptop Dell'],
                      'filter': {
                        'Hãng sản xuất': 'Dell',
                        'core': 'Intel i5',
                        'ram': '16 GB',
                        'VGA': 'MX570',
                        'Màn hình': '15 inch',
                      },
                      'money': '27990000',
                      'name':
                          'Laptop Dell Vostro 5620 VWXVW i5 1240P/ 16GB/ 512GB/ MX570/ 16 inch FHD/ Win 11',
                      'sale': 11,
                      'short-des':
                          '- CPU: Intel® Core™ i5 1240P ( up to 4.40 GHz, 12 MB)- RAM: 16GB DDR4 3200 MHz- Ổ cứng: 512GB SSD M.2 NVMe PCIe- VGA: Nvidia GeForce MX570 2GB GDDR6- Màn hình: 16 inch FHD- Pin: 4-cell, 54 WHr- Cân nặng: 1.97 kg- Tính năng: Bảo mật vân tay- Màu sắc: Xám- OS: Windows 11 Home + Office Student',
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
