import 'package:project/all_imports.dart';

class InfoCart extends StatefulWidget {
  final String productId;
  final String name;
  final String price;
  final String image;
  const InfoCart({
    Key? key,
    required this.name,
    required this.price,
    required this.productId,
    required this.image,
  }) : super(key: key);

  @override
  _InfoCartState createState() => _InfoCartState();
}

class _InfoCartState extends State<InfoCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Image(
                image: AssetImage('img/product/${widget.image}'),
                fit: BoxFit.contain,
              )),
          SizedBox(
            width: 16,
          ),
          Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                              clipBehavior: Clip.hardEdge,
                              style: ButtonStyle(
                                overlayColor: TransparentButton(),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(0)),
                              ),
                              onPressed: () {},
                              child: Text(widget.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.chakraPetch().fontFamily,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black))),
                          Text(
                            widget.price,
                            style: TextStyle(
                                fontFamily:
                                    GoogleFonts.chakraPetch().fontFamily,
                                color: Colors.red,
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
