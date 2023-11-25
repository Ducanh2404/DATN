import 'package:project/all_imports.dart';

class NewsItem extends StatefulWidget {
  final String title;
  final String image_url;
  final DateTime publish_date;

  NewsItem(
      {Key? key,
      required this.title,
      required this.image_url,
      required this.publish_date})
      : super(key: key);

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                horizontal: 0.0,
              ))),
              onPressed: () {},
              child: Image(
                image: AssetImage(widget.image_url),
                width: 160,
                height: 90,
              )),
          Container(
            height: 90,
            margin: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: ButtonStyle(
                        alignment: Alignment.topLeft,
                        overlayColor: TransparentButton(),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                          horizontal: 0.0,
                        ))),
                    onPressed: () {},
                    child: Text(widget.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black))),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 12,
                      color: Color(0xFF8d94ac),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '$currentDate',
                      style: TextStyle(color: Color(0xFF8d94ac), fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
