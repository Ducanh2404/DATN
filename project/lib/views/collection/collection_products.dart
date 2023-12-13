import 'package:project/all_imports.dart';

class CollectionProducts extends StatelessWidget {
  final String title;
  const CollectionProducts({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32),
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 3, color: Color(0xFF3278f6)))),
                child: Text(title.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 21)),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double containWidth = constraints.maxWidth;
                  double childWidth =
                      containWidth / 5; // Calculate one-fifth width

                  return Wrap(
                      children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                    return SizedBox(
                      width: childWidth,
                      height: 405,
                      child: ProductDetails(
                          productId: '1',
                          short_des: '123',
                          new_price: 'new_price',
                          old_price: 'old_price',
                          product_name:
                              'PC xịn nhất quả đất 2023 luôn các bạn ơi!',
                          sale: '10',
                          status: 'sell'),
                    );
                  }).toList());
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
