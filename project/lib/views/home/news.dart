import 'package:project/all_imports.dart';
import 'package:project/widget/news_item.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1600,
      child: Row(
        children: [
          Expanded(
              child: HalfContainer(
                  title: 'tnc channel',
                  content: Column(
                    children: [
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                    ],
                  ),
                  morebtn: true)),
          SizedBox(
            width: 32,
          ),
          Expanded(
              child: HalfContainer(
                  title: 'tin tức',
                  content: Column(
                    children: [
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                      NewsItem(
                          title: 'So sánh RTX 3070Ti 8GB vs RTX 4060Ti 16GB',
                          image_url: 'img/channel/channel1.jpg',
                          publish_date: DateTime.now()),
                    ],
                  ),
                  morebtn: true)),
        ],
      ),
    );
  }
}
