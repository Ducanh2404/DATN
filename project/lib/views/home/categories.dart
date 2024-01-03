import 'package:project/all_imports.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/categories%2Fcate1.png?alt=media&token=6303b68b-4e1c-4813-8ef8-7c7c246fbe63',
    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/categories%2Fcate2.jpg?alt=media&token=217eaad6-e458-483a-aa45-5f78b77c6cd6',
    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/categories%2Fcate3.png?alt=media&token=172bf928-866d-4a28-8e3b-efb9022961cc',
    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/categories%2Fcate4.png?alt=media&token=9bd2b0bc-de1e-4b92-a7a7-d23c9657d6ef',
    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/categories%2Fcate5.png?alt=media&token=bbe06f9d-e333-446e-a67d-c69e624f054e',
    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/categories%2Fcate6.png?alt=media&token=03ea0acd-3377-4d24-a3b8-7e9396494d42',
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
                      margin: const EdgeInsets.only(right: 5),
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor: TransparentButton(),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)),
                        ),
                        child: Image(
                          image: NetworkImage(imageUrl),
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
                height: Responsive.isDesktop(context)
                    ? 250
                    : Responsive.isTablet(context)
                        ? 150
                        : 150,
                padEnds: false,
                viewportFraction: Responsive.isDesktop(context)
                    ? 1 / 4
                    : Responsive.isTablet(context)
                        ? 1 / 3
                        : 1,
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
