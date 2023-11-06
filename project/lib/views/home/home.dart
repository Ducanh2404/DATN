import 'package:project/all_imports.dart';

class CarouselDemo extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 1600,
        child: Column(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 580,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
            ),
            carouselController: buttonCarouselController,
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image(image: AssetImage('img/banner$i.jpg')));
                },
              );
            }).toList(),
          ),
        ]),
      );
}
