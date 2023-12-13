import 'package:project/all_imports.dart';

class ViewedProduct extends StatefulWidget {
  const ViewedProduct({Key? key}) : super(key: key);

  @override
  _ViewedProductState createState() => _ViewedProductState();
}

class _ViewedProductState extends State<ViewedProduct> {
  CarouselController buttonCarouselController = CarouselController();

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
                    items: [1, 2, 3, 4, 5, 6].map((i) {
                      return ProductDetails(
                        productId: '1',
                        new_price: '17.690.000đ',
                        old_price: '19.990.000đ',
                        product_name: 'PC Đỗ Đại Học 2023',
                        sale: "12",
                        status: 'new',
                        short_des: '',
                      );
                    }).toList(),
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
