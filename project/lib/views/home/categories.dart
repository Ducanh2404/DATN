import 'package:project/all_imports.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imageUrls = [
    'img/categories/cate1.png',
    'img/categories/cate2.jpg',
    'img/categories/cate3.png',
    'img/categories/cate4.png',
    'img/categories/cate5.png',
    'img/categories/cate6.png',
    // Add more image URLs as needed
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1600,
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              items: imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin:const EdgeInsets.only(right: 5),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: TransparentButton(),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)),
                        ),
                        child: Image(
                          image: AssetImage(imageUrl),
                          width: 588,
                          height: 320,
                        ),
                        onPressed: () {},
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                padEnds: false,
                viewportFraction: 1.0 / 4.0,
                initialPage: 0,
                enableInfiniteScroll: true,
              ),
            ),
            ButtonNext(buttonCarouselController: buttonCarouselController),
            ButtonPrev(buttonCarouselController: buttonCarouselController),
          ],
        ));
  }
}
