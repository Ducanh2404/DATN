import 'package:project/all_imports.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
    return Container(
        child: CarouselSlider(
      items: imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 3),
        aspectRatio: 1.0,
        enableInfiniteScroll: true,
      ),
    ));
  }
}

class OwlCarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                Image(image: AssetImage('img/cate1.png')),
                Image(image: AssetImage('img/cate2.jpg')),
                Image(image: AssetImage('img/cate3.png')),
                Image(image: AssetImage('img/cate4.png')),
                Image(image: AssetImage('img/cate5.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OwlCarouselDemo(),
  ));
}
