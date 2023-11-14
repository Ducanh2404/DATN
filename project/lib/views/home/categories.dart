import 'package:project/all_imports.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imageUrls = [
    'cate1.png',
    'cate2.jpg',
    'cate3.png',
    'cate4.png',
    'cate5.png',
    'cate6.png',
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
                              EdgeInsets.all(0)),
                          
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
