import 'package:project/all_imports.dart';

class HalfContainer extends StatelessWidget {
  final String title;
  final Widget content;
  final bool morebtn;
  HalfContainer({
    required this.title,
    required this.content,
    required this.morebtn,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.only(top: 32),
        color: Colors.white,
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
                  child: Text(title.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 21)),
                ),
                Visibility(
                  visible: morebtn,
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
          content,
        ]));
  }
}
