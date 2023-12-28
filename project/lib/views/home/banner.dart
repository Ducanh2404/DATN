import 'package:project/all_imports.dart';

class CarouselBanner extends StatefulWidget {
  const CarouselBanner({super.key});

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  CarouselController buttonCarouselController = CarouselController();
  final List<String> image = [
    'img/banner/banner1.jpg',
    'img/banner/banner2.jpg',
    'img/banner/banner3.jpg',
  ];
  int _current = 0;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 1600,
        child: Stack(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: Responsive.isDesktop(context)
                  ? 580
                  : Responsive.isTablet(context)
                      ? 350
                      : 150,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 900),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            carouselController: buttonCarouselController,
            items: image.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                      child: Image(
                        image: AssetImage(url),
                        fit: BoxFit.cover,
                      ));
                },
              );
            }).toList(),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var i = 0; i < image.length; i++)
                  GestureDetector(
                      onTap: () => buttonCarouselController.animateToPage(i),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                                .withOpacity(_current == i ? 0.9 : 0.4)),
                      )),
              ]),
            ),
          ),
          ButtonPrev(buttonCarouselController: buttonCarouselController),
          ButtonNext(buttonCarouselController: buttonCarouselController),
        ]),
      );
}
