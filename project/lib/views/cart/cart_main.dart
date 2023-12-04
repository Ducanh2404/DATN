import 'package:project/all_imports.dart';

class CartMain extends StatelessWidget {
  const CartMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1600,
      child: Row(
        children: [
          Expanded(
              flex: 7,
              child: Container(
                  padding: const EdgeInsets.all(24.0),
                  margin: const EdgeInsets.only(top: 32),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Thông tin sản phẩm",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18)),
                    ],
                  ))),
          SizedBox(
            width: 24,
          ),
          Expanded(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.all(24.0),
                  margin: const EdgeInsets.only(top: 32),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Thông tin giỏ hàng",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18)),
                    ],
                  ))),
        ],
      ),
    );
  }
}
