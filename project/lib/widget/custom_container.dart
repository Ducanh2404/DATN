import 'package:project/all_imports.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String category;
  final Widget content;
  final bool morebtn;
  CustomContainer({
    required this.title,
    required this.content,
    required this.morebtn,
    required this.category,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
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
                  child: Text(widget.title.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 21)),
                ),
                Visibility(
                  visible: widget.morebtn,
                  child: TextButton(
                    style: ButtonStyle(
                        overlayColor: TransparentButton(),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                          horizontal: 0.0,
                        ))),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Collection(
                                    category: widget.category,
                                  )),
                        );
                      });
                    },
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
          widget.content,
        ]));
  }
}
