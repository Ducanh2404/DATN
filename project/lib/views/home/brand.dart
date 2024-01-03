import 'package:project/all_imports.dart';

class Brand extends StatefulWidget {
  const Brand({Key? key}) : super(key: key);

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    List<String> brand = [
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand1.png?alt=media&token=a252ba7a-2245-4a46-ad7d-1ff9831ec07d',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand2.png?alt=media&token=e1032e2e-733a-460b-b8d9-16494c705c16',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand3.png?alt=media&token=5224ed55-f3bf-4574-b7e1-13999b013999',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand4.png?alt=media&token=0a4a38c8-8678-4af0-af9d-abc519706fac',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand5.png?alt=media&token=20470bf6-78ce-47ca-94c8-c4bd97ae7631',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand6.png?alt=media&token=e2cd21da-0579-4fcd-b472-264a1c4cc490',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand7.png?alt=media&token=f510e20b-05ca-49b2-bb05-0e55f357d3a6',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand8.png?alt=media&token=b7412b53-e3d2-46d3-9ad0-4043f73d6643',
      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/brand%2Fbrand9.png?alt=media&token=1ffa431e-a011-460e-9934-bfdff8ef953e',
    ];
    return CustomContainer(
      title: 'thương hiệu đồng hành',
      morebtn: false,
      content: Stack(
        children: [
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: 80,
              padEnds: false,
              viewportFraction: Responsive.isDesktop(context)
                  ? 1.0 / 9.0
                  : Responsive.isTablet(context)
                      ? 1 / 6
                      : 1 / 3,
              initialPage: 0,
              enableInfiniteScroll: true,
            ),
            items: brand.map((image) {
              return Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: NetworkImage(image),
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ));
            }).toList(),
          ),
        ],
      ),
      category: '',
    );
  }
}
