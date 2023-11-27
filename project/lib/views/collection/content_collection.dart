import 'package:project/all_imports.dart';

class ContentCollection extends StatefulWidget {
  const ContentCollection({Key? key}) : super(key: key);

  @override
  _ContentCollectionState createState() => _ContentCollectionState();
}

class _ContentCollectionState extends State<ContentCollection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1600,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bộ lọc sản phẩm',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    FilterItems(filterTitle: 'Hãng sản xuất'),
                  ],
                ),
              )),
          Expanded(flex: 8, child: Column()),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

class FilterItems extends StatefulWidget {
  final String filterTitle;
  const FilterItems({super.key, required this.filterTitle});

  @override
  State<FilterItems> createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems> {
  final List<Item> _data = [
    Item(expandedValue: Container(), headerValue: 'Hãng sản xuất'),
    Item(expandedValue: Container(), headerValue: 'Khoảng giá'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      margin: EdgeInsets.only(bottom: 24),
      child: _buildPanel(),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: Colors.white,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: item.expandedValue,
              subtitle: Container(),
              onTap: () {
                setState(() {});
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
