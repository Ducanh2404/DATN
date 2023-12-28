import 'package:project/all_imports.dart';

class SingleProduct extends StatefulWidget {
  final List<dynamic> category;
  final String productId;
  final String new_price;
  final String old_price;
  final String product_name;
  final String sale;
  final String status;
  final String short_des;
  final String image;
  const SingleProduct(
      {Key? key,
      required this.new_price,
      required this.old_price,
      required this.product_name,
      required this.sale,
      required this.status,
      required this.short_des,
      required this.productId,
      required this.image,
      required this.category})
      : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFf3f3f3),
          ),
          child: Column(children: [
            Header(),
            MainDetails(
              productId: widget.productId,
              short_des: widget.short_des,
              price: widget.new_price,
              sale_price: widget.old_price,
              product_name: widget.product_name,
              sale: widget.sale,
              image: widget.image,
            ),
            ProductContent(),
            RelatedProduct(
              category: widget.category,
            ),
            // ViewedProduct(),
            Footer(),
          ]),
        ),
      ),
    );
  }
}
