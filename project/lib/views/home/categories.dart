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
      width: 1600,
      child: CarouselSlider(
      items: imageUrls.map((imageUrl) {
        return Builder(
            builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width/4,
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                      child: Row(children: [Image(image: AssetImage(imageUrl),width: 394,)],)
        );},
        );
      }).toList(),
      options: CarouselOptions(
       padEnds :false,
        height: 400.0,
        viewportFraction: 1.0/4.0,
        initialPage: 0,
        enableInfiniteScroll: true,
      ),
    ));
  }
}
