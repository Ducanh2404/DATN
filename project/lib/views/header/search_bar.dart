import 'package:intl/intl.dart';
import 'package:project/all_imports.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final SearchController _searchController = SearchController();
  List<String> searchResults = [];
  List<String> searchHistory = [];
  List<String> listName = [];

  @override
  initState() {
    super.initState();
    getProducts();
  }

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (result) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(result),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = result;
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return listName
        .where((name) => name.toLowerCase().contains(input.toLowerCase()))
        .map(
          (String name) => ListTile(
            title: Text(name),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = name;
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              controller.closeView(name);
              handleSelection(name);
            },
          ),
        );
  }

  void handleSelection(String name) {
    setState(() {
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, name);
    });
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  Future<List<String>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection("products").get();
    query.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      String name = data['name'];
      String img = data['image'];
      double newprice = data['money'] - (data['money'] * (data['sale'] / 100));
      setState(() {
        listName.add(name);
      });
    });
    return listName;
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: 'Tìm kiếm sản phẩm',
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        if (controller.text.isEmpty) {
          if (searchHistory.isNotEmpty) {
            return getHistoryList(controller);
          }
          return <Widget>[
            Center(
                child: Text(
              'Không có lịch sử tìm kiếm.',
            ))
          ];
        }
        return getSuggestions(controller);
      },
    );
  }
}
