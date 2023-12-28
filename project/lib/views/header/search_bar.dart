import 'package:intl/intl.dart';
import 'package:project/all_imports.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  List<String> searchResults = [];
  List<String> searchHistory = [];

  @override
  initState() {
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
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

  Future<Iterable<Widget>> getSuggestions(SearchController controller) async {
    final String input = controller.value.text;
    List<Widget> listSearch = [];
    QuerySnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection("products").get();
    query.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      String name = data['name'];
      List<dynamic> category = data['category'];
      String price = formatAsCurrency(data['money']).toString();
      String sale = data['sale'].toString();
      String shortDes = data['short-des'];
      String img_url = data['image'];
      String productId = doc.id;
      String img = data['image'];
      double newprice = data['money'] - (data['money'] * (data['sale'] / 100));
      if (name.toLowerCase().contains(input.toLowerCase()) == true) {
        listSearch.add(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SingleProduct(
                            image: img_url,
                            productId: productId,
                            short_des: shortDes,
                            new_price: price,
                            old_price: formatAsCurrency(newprice).toString(),
                            product_name: name,
                            sale: sale,
                            status: 'new',
                            category: category,
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(width: 1, color: Colors.grey))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          name,
                          style: TextStyle(
                            fontFamily: GoogleFonts.chakraPetch().fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          formatAsCurrency(newprice).toString(),
                          style: TextStyle(
                              fontFamily: GoogleFonts.chakraPetch().fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage('img/product/$img'),
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      }
    });
    return listSearch;
  }

  void handleSelection(String name) {
    setState(() {
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: SearchAnchor.bar(
        barOverlayColor: TransparentButton(),
        viewBackgroundColor: Color(0xFFFFFFFF),
        barHintText: 'Tìm kiếm sản phẩm',
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
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
      ),
    );
  }
}
