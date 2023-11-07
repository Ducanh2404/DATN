import 'package:project/all_imports.dart';

class CarouselBanner extends StatefulWidget {
  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  CarouselController buttonCarouselController = CarouselController();
  final List<int> imageIndex = [1, 2, 3];
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 1600,
        child: Stack(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 580,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 900),
            ),
            carouselController: buttonCarouselController,
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                      child: Image(image: AssetImage('img/banner$i.jpg')));
                },
              );
            }).toList(),
          ),
          Container(
            height: 580,
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i in imageIndex)
                GestureDetector(
                    onTap: () => buttonCarouselController.animateToPage(i),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ))
            ]),
          ),
          Container(
              height: 580,
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: ButtonStyle(overlayColor: TransparentButton()),
                onPressed: () {
                  buttonCarouselController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                icon: Icon(Icons.arrow_back, size: 30),
                label: Text(""),
              )),
          Container(
              height: 580,
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                style: ButtonStyle(overlayColor: TransparentButton()),
                icon: Icon(Icons.arrow_forward, size: 30),
                onPressed: () {
                  buttonCarouselController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                label: Text(""),
              )),

          // for (var index in imageIndex)
          //   Container(
          //       child: ConstrainedBox(
          //           constraints: BoxConstraints.expand(),
          //           child: TextButton(
          //               onPressed: null,
          //               child: Image.asset('path/the_image.png'))))
        ]),
      );
}
