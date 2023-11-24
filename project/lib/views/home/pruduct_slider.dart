import 'package:project/all_imports.dart';

class PruductSlider extends StatefulWidget {
  const PruductSlider({super.key});

  @override
  _PruductSliderState createState() => _PruductSliderState();
}

class _PruductSliderState extends State<PruductSlider> {
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
                    items: [1, 2, 3, 4, 5].map((i) {
                      return ProductDetails();
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
