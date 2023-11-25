import 'package:project/all_imports.dart';

class Brand extends StatefulWidget {

  Brand({ Key? key }) : super(key: key);

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
    CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
                children: [
                  CarouselSlider(
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      height: 80,
                      padEnds: false,
                      viewportFraction: 1.0 / 9.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                    ),
                    items: [1, 2, 3, 4, 5,6,7,8,9].map((i) {
                        return Image(image: AssetImage('img/brand/brand1.jpg'));
                    }).toList(),
                  ),
                  ButtonPrev(
                      buttonCarouselController: buttonCarouselController),
                  ButtonNext(
                      buttonCarouselController: buttonCarouselController),
                ],
              );
  }
}