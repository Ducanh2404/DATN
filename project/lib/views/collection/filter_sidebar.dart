import 'dart:ffi';

import 'package:project/all_imports.dart';
import 'package:intl/intl.dart';

class FilterSideBar extends StatefulWidget {
  final Function(List<Widget>) listFiltedCollection;
  final String category;
  const FilterSideBar({
    super.key,
    required this.category,
    required this.listFiltedCollection,
  });

  @override
  State<FilterSideBar> createState() => _FilterSideBarState();
}

class _FilterSideBarState extends State<FilterSideBar> {
  Map<String, Set<String>>? filterList = {};
  List<Widget> filterWidget = [];
  Map<String, List<String>> selectedFilter = {};
  void addSelectedFilter(String key, List<String> values, bool selected) {
    if (selected == true) {
      setState(() {
        if (selectedFilter.containsKey(key)) {
          selectedFilter[key]!.addAll(values);
        } else {
          selectedFilter[key] = values;
        }
      });
    } else if (selected == false) {
      setState(() {
        if (selectedFilter.containsKey(key)) {
          selectedFilter[key]!.remove(values.join());
        }
      });
    }
    fetchFiltedCollection();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value > 1000000)
        ? (value / 1000000).round() * 1000000
        : (value / 1000).round() * 1000; // Round to the nearest million
    return numberFormat.format(roundedValue);
  }

  Future<List<Widget>> fetchFiltedCollection() async {
    List<Widget> listFiltedCollection = [];
    try {
      CollectionReference<Map<String, dynamic>> products =
          FirebaseFirestore.instance.collection('products');
      Query<Map<String, dynamic>> query = products;
      selectedFilter.forEach((field, values) {
        values.forEach((value) {
          query = query.where('filter.$field', isEqualTo: value);
        });
      });

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await query.where('category', arrayContains: widget.category).get();
      if (selectedFilter.values.every((value) => value.isEmpty) ||
          selectedFilter.isEmpty) {
        QuerySnapshot<Map<String, dynamic>> defaultQuerySnapshot =
            await FirebaseFirestore.instance
                .collection("products")
                .where("category", arrayContains: widget.category)
                .get();
        setState(() {
          querySnapshot = defaultQuerySnapshot;
        });
      }
      querySnapshot.docs.forEach((doc) {
        late double newprice;
        Map<String, dynamic> data = doc.data();
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
          listFiltedCollection.add(product);
        });
      });
      widget.listFiltedCollection(listFiltedCollection);
    } catch (e) {
      print('Failed to fetch documents: $e');
    }
    return listFiltedCollection;
  }

  Future<List<Widget>> fetchFilters() async {
    try {
      QuerySnapshot<Map<String, dynamic>> products = await FirebaseFirestore
          .instance
          .collection('products')
          .where("category", arrayContains: widget.category)
          .get();
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
            updateSelected: addSelectedFilter,
          );
          setState(() {
            filterWidget.add(item);
          });
        });
        print(filterList);
      }
    } catch (e) {
      print('Failed to fetch documents: $e');
    }
    return filterWidget;
  }

  @override
  void initState() {
    fetchFilters();
    super.initState();
  }

  RangeValues range = RangeValues(40, 80);

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
            children: filterWidget,
          ),
          Row(
            children: [
              Expanded(
                child: RangeSlider(
                    values: range,
                    min: range.start,
                    max: range.end,
                    divisions: 10000,
                    labels: RangeLabels(range.start.round().toString(),
                        range.end.round().toString()),
                    onChanged: (RangeValues newPrice) {
                      setState(() {
                        range = newPrice;
                      });
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FilterContainer extends StatefulWidget {
  final Function(String, List<String>, bool) updateSelected;
  final String category;
  final List<String> filterItems;
  final String title;
  const FilterContainer({
    super.key,
    required this.title,
    required this.filterItems,
    required this.category,
    required this.updateSelected,
  });

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  void getSelectedFilter(String filter, bool selected) {
    setState(() {
      widget.updateSelected(widget.title, [filter], selected);
    });
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
                    selectedFilter: getSelectedFilter,
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

// ignore: must_be_immutable
class FilterItem extends StatefulWidget {
  final Function(String, bool) selectedFilter;
  final String title;

  FilterItem({
    required this.title,
    required this.selectedFilter,
  });

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
            widget.selectedFilter(widget.title, isChecked);
          });
        },
      ),
    );
  }
}
