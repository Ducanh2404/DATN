import 'package:project/all_imports.dart';

class RelatedProduct extends StatefulWidget {
  const RelatedProduct({Key? key}) : super(key: key);

  @override
  _RelatedProductState createState() => _RelatedProductState();
}

class _RelatedProductState extends State<RelatedProduct> {
  CarouselController buttonCarouselController = CarouselController();

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
                    items: [1, 2, 3, 4, 5, 6].map((i) {
                      return ProductDetails(
                          productId: '1',
                          short_des: "",
                          new_price: '17.690.000đ',
                          old_price: '19.990.000đ',
                          product_name: 'PC Đỗ Đại Học 2023',
                          sale: "12",
                          status: 'new');
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
