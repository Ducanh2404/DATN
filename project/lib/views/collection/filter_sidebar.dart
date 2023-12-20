import 'dart:math';
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
  Map<String, double> filterPrice = {};
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

  final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  addFilterPrice() {
    filterPrice = {'minPrice': rangePrice.start, 'maxPrice': rangePrice.end};
    print(filterPrice);
    print(filterPrice['minPrice']);
    print(filterPrice['minPrice'].runtimeType);
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
      if (filterPrice.isNotEmpty) {
        query = query.where('money',
            isGreaterThanOrEqualTo: filterPrice['minPrice']);
        query =
            query.where('money', isLessThanOrEqualTo: filterPrice['maxPrice']);
      }
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

  late TextEditingController startPriceController;
  late TextEditingController endPriceController;
  @override
  void initState() {
    fetchFilters();
    getPrice();
    startPriceController = TextEditingController();
    endPriceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    startPriceController.dispose();
    endPriceController.dispose();
    super.dispose();
  }

  Future<void> getPrice() async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('products')
          .where('category', arrayContains: widget.category);
      final querySnapshot = await collection.get();

      double minMoney = double.infinity;
      double maxMoney = double.negativeInfinity;

      querySnapshot.docs.forEach((doc) {
        late double newprice;
        Map<String, dynamic> data = doc.data();
        newprice = data['money'] - (data['money'] * (data['sale'] / 100));
        minMoney = min(minMoney, newprice);
        maxMoney = max(maxMoney, newprice);
      });

      setState(() {
        rangePrice = RangeValues(minMoney, maxMoney);
        minPrice = minMoney;
        maxPrice = maxMoney;
        startPriceController.text =
            numberFormat.format(rangePrice.start).toString();
        endPriceController.text =
            numberFormat.format(rangePrice.end).toString();
      });
    } catch (error) {
      print('Error fetching collection: $error');
    }
  }

  double convertToDouble(String priceText) {
    String priceCleaned = priceText.replaceAll('.', '').replaceAll('₫', '');
    double price = double.tryParse(priceCleaned) ?? 0.0;
    return price;
  }

  void updateRangeValues() {
    double startPrice = convertToDouble(startPriceController.text);
    double endPrice = convertToDouble(endPriceController.text);
    if (startPrice < minPrice || startPrice >= maxPrice) {
      startPriceController.text = numberFormat.format(minPrice).toString();
      startPrice = minPrice;
    }
    if (endPrice > maxPrice || endPrice <= minPrice) {
      setState(() {
        endPriceController.text = numberFormat.format(maxPrice).toString();
      });
      endPrice = maxPrice;
    }

    setState(() {
      rangePrice = RangeValues(startPrice, endPrice);
    });
  }

  RangeValues rangePrice = RangeValues(0, 0);
  double minPrice = 0;
  double maxPrice = 0;

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
          Text(
            'khoảng giá'.toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
                height: 0.5),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: RangeSlider(
                    values: rangePrice,
                    min: minPrice,
                    max: maxPrice,
                    labels: RangeLabels(rangePrice.start.round().toString(),
                        rangePrice.end.round().toString()),
                    onChanged: (RangeValues newPrice) {
                      setState(() {
                        rangePrice = newPrice;
                        startPriceController.text = numberFormat
                            .format(rangePrice.start.round())
                            .toString();
                        endPriceController.text = numberFormat
                            .format(rangePrice.end.round())
                            .toString();
                      });
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.zero)),
                    controller: startPriceController,
                    keyboardType: TextInputType.number,
                    onTapOutside: (value) {
                      setState(() {
                        updateRangeValues();
                      });
                    }),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('-')),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.zero)),
                controller: endPriceController,
                keyboardType: TextInputType.number,
                onTapOutside: (value) => updateRangeValues(),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF3278f6)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10)),
                    overlayColor: TransparentButton(),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: Color(0xFF3278f6), width: 1),
                    ))),
                onPressed: () {
                  updateRangeValues();
                  addFilterPrice();
                  fetchFiltedCollection();
                },
                child: Text(
                  'Lọc',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                )),
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
