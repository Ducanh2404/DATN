import 'package:project/all_imports.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imageUrls = [
    'img/cate1.png',
    'img/cate2.jpg',
    'img/cate3.png',
    'img/cate4.png',
    'img/cate5.png',
    'img/cate6.png',
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
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: TransparentButton(),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)),
                          
                        ),
                        child: Image(image: AssetImage(imageUrl),width: MediaQuery.sizeOf(context).width,),
                        onPressed: () {},
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                aspectRatio: 7.4,
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
