import 'package:project/all_imports.dart';

class ContentCollection extends StatefulWidget {
  final String category;
  const ContentCollection({Key? key, required this.category}) : super(key: key);

  @override
  _ContentCollectionState createState() => _ContentCollectionState();
}

class _ContentCollectionState extends State<ContentCollection> {
  List<Widget> listFiltedCollection = [];
  @override
  void initState() {
    listFiltedCollection = [];
    super.initState();
  }

  void getListFiltedCollection(List<Widget> list) {
    setState(() {
      listFiltedCollection = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1600,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: FilterSideBar(
              category: widget.category,
              listFiltedCollection: getListFiltedCollection,
            ),
          ),
          Expanded(
            flex: 8,
            child: CollectionProducts(
              title: widget.category,
              category: widget.category,
              listCollection: listFiltedCollection,
            ),
          )
        ],
      ),
    );
  }
}
