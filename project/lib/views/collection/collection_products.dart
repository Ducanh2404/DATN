import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class CollectionProducts extends StatefulWidget {
  final String category;
  final String title;
  const CollectionProducts({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  State<CollectionProducts> createState() => _CollectionProductsState();
}

class _CollectionProductsState extends State<CollectionProducts> {
  @override
  void initState() {
    fetchDocuments();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value > 1000000)
        ? (value / 1000000).round() * 1000000
        : (value / 1000).round() * 1000; // Round to the nearest million
    return numberFormat.format(roundedValue);
  }

  List<Widget> listCollection = [];

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
        Widget product = SizedBox(
          child: ProductDetails(
              productId: productId,
              short_des: shortDes,
              new_price: price,
              old_price: formatAsCurrency(newprice).toString(),
              product_name: name,
              sale: sale,
              status: 'new'),
        );
        setState(() {
          listCollection.add(product);
        });
      });
    } catch (e) {
      print('Failed to fetch documents: $e');
    }
    return listCollection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32),
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 3, color: Color(0xFF3278f6)))),
                child: Text(widget.title.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 21)),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double containWidth = constraints.maxWidth;
                  double childWidth = containWidth / 5;

                  return Wrap(
                    children: [
                      for (var widget in listCollection)
                        SizedBox(
                          width: childWidth,
                          height: 405,
                          child: widget,
                        )
                    ],
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
