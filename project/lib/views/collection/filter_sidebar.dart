import 'package:project/all_imports.dart';

class FilterSideBar extends StatelessWidget {
  const FilterSideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bộ lọc sản phẩm',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 24,
          ),
          FilterItems(
            title: 'hãng sản xuất',
            filterTitle: ['Dell', 'HP'],
          ),
          FilterItems(
            title: 'khoảng giá',
            filterTitle: ['1.000.000 đ - 2.000.000 đ'],
          ),
          FilterItems(
            title: 'CPU',
            filterTitle: ['Intel Core i5', 'Intel Core i7', 'Intel Core i9'],
          ),
        ],
      ),
    );
  }
}

class FilterItems extends StatefulWidget {
  final List<String> filterTitle;
  final String title;
  const FilterItems({
    super.key,
    required this.title,
    required this.filterTitle,
  });

  @override
  State<FilterItems> createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems> {
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
                children: List.generate(widget.filterTitle.length, (index) {
                  return FilterItem(
                    title: widget.filterTitle[index],
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
