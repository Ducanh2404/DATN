import 'package:project/all_imports.dart';

class ContentCollection extends StatefulWidget {
  const ContentCollection({Key? key}) : super(key: key);

  @override
  _ContentCollectionState createState() => _ContentCollectionState();
}

class _ContentCollectionState extends State<ContentCollection> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 1600,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: FilterSideBar(),
          ),
          Expanded(
            flex: 8,
            child: CollectionProducts(
              title: 'pc gaming',
            ),
          )
        ],
      ),
    );
  }
}
