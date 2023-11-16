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
    // Add more image URLs as needed
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
                    style:
                        const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
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
        Row(
          children: [
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor: TransparentButton(),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 0.0))),
                child: const Image(image: AssetImage('img/category1.jpg'))),
            Stack(
              children: [
                CarouselSlider(
                  carouselController: buttonCarouselController,
                  items:[Container(

                  )]
                  //: [1, 2, 3].map((i) {
                  //   return Builder(
                  //     builder: (BuildContext context) {
                  //       return Container(
                  //         height: 100,
                  //         width: 100,
                  //         decoration:BoxDecoration(
                  //             color: Colors.amber
                  //           ),
                  //           child: Text('$i'),
                  //       );
                  //     },
                  //   );
                  // })
                  .toList(),
                  options: CarouselOptions(
                    height: 100,
                    padEnds: false,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                  ),
                ),
                ButtonNext(buttonCarouselController: buttonCarouselController),
                ButtonPrev(buttonCarouselController: buttonCarouselController),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
