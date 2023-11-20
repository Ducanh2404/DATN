import 'package:project/all_imports.dart';

class PruductSlider extends StatefulWidget {
  const PruductSlider({super.key});

  @override
  _PruductSliderState createState() => _PruductSliderState();
}

class _PruductSliderState extends State<PruductSlider> {
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imageUrls = [
    'https://via.placeholder.com/300',
    'https://via.placeholder.com/300',
    'https://via.placeholder.com/300',
    'https://via.placeholder.com/300',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.only(top: 32),
        color: Colors.white,
        width: 1600,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 3, color: Color(0xFF3278f6)))),
                  child: Text("pc đồ họa nổi bật".toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20)),
                ),
                Container(
                  child: TextButton(
                    style: ButtonStyle(
                        overlayColor: TransparentButton(),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                          horizontal: 0.0,
                        ))),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          "Xem tất cả",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(children: [
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor: TransparentButton(),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 0.0))),
                child: const Image(image: AssetImage('img/product-thumbnail/category1.jpg'))),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 405,
                  padEnds: false,
                  viewportFraction: 1.0 / 5.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return ProductDetails();
                }).toList(),
              ),
            )
          ]),
        ]));
  }
}

