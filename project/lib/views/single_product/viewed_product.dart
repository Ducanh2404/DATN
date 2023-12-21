import 'package:project/all_imports.dart';

class ViewedProduct extends StatefulWidget {
  const ViewedProduct({Key? key}) : super(key: key);

  @override
  _ViewedProductState createState() => _ViewedProductState();
}

class _ViewedProductState extends State<ViewedProduct> {
  CarouselController buttonCarouselController = CarouselController();
  List<Widget> listViewed = [];

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: 'sản phẩm đã xem',
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
                    items: listViewed),
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
