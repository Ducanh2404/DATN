import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class FilterSideBar extends StatefulWidget {
  final String category;
  const FilterSideBar({
    super.key,
    required this.category,
  });

  @override
  State<FilterSideBar> createState() => _FilterSideBarState();
}

class _FilterSideBarState extends State<FilterSideBar> {
  Map<String, Set<String>>? filterList = {};
  List<Widget> filterItems = [];
  Future<List<Widget>> fetchFilters() async {
    try {
      QuerySnapshot<Map<String, dynamic>> products =
          await FirebaseFirestore.instance.collection('products').get();
      if (products.size > 0) {
        for (var doc in products.docs) {
          Map<String, dynamic>? data = doc.data();
          if (data.isNotEmpty) {
            Map<String, dynamic> filters = data['filter'];
            filters.forEach((key, value) {
              filterList?.putIfAbsent(key, () => {}).add(value.toString());
            });
          }
        }
        filterList!.forEach((key, value) {
          Widget item = FilterContainer(
            category: widget.category,
            filterItems: value.toList(),
            title: key,
          );
          setState(() {
            filterItems.add(item);
          });
        });
        print(filterList);
      }
    } catch (e) {
      print('Failed to fetch documents: $e');
    }
    return filterItems;
  }

  @override
  void initState() {
    fetchFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bộ lọc sản phẩm',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            children: filterItems,
          )
        ],
      ),
    );
  }
}

class FilterContainer extends StatefulWidget {
  final String category;
  final List<String> filterItems;
  final String title;
  const FilterContainer({
    super.key,
    required this.title,
    required this.filterItems,
    required this.category,
  });

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value > 1000000)
        ? (value / 1000000).round() * 1000000
        : (value / 1000).round() * 1000; // Round to the nearest million
    return numberFormat.format(roundedValue);
  }

  List<Widget> listCollection = [];

  late double newprice;

  Future<List<Widget>> fetchDocuments() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("category", arrayContains: widget.category)
          .get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String name = data['name'];
        String price = formatAsCurrency(data['money']).toString();
        String sale = data['sale'].toString();
        String shortDes = data['short-des'];
        String productId = doc.id;
        newprice = data['money'] - (data['money'] * (data['sale'] / 100));
        Widget product = SizedBox(
          child: ProductDetails(
              productId: productId,
              short_des: shortDes,
              new_price: price,
              old_price: formatAsCurrency(newprice).toString(),
              product_name: name,
              sale: sale,
              status: 'new'),
        );
        setState(() {
          listCollection.add(product);
        });
      });
    } catch (e) {
      print('Failed to fetch documents: $e');
    }
    return listCollection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
                  width: 1, style: BorderStyle.solid, color: Colors.grey))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                height: 0.5),
          ),
          SizedBox(
            height: 16,
          ),
          Builder(
            builder: (BuildContext context) {
              return Column(
                children: List.generate(widget.filterItems.length, (index) {
                  return FilterItem(
                    title: widget.filterItems[index],
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FilterItem extends StatefulWidget {
  final String title;

  const FilterItem({required this.title});

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CheckboxListTile(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        overlayColor: TransparentButton(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(widget.title),
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
