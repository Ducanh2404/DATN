import 'package:intl/intl.dart';

import '../../../constants.dart';
import 'package:project/all_imports.dart';

class OrderManage extends StatefulWidget {
  const OrderManage({Key? key}) : super(key: key);

  @override
  _OrderManageState createState() => _OrderManageState();
}

class _OrderManageState extends State<OrderManage> {
  @override
  void initState() {
    getAccounts();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  List<DataRow> listOrder = [];
  int i = 1;

  Future<void> getAccounts() async {
    i = 1;
    await FirebaseFirestore.instance
        .collection('order')
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot users) => users.docs.forEach((doc) {
              bool select = false;
              Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
              String date = data['date'];
              String name = data['receiver'];
              String method = data['method'];
              String status =
                  data['status'] == '1' ? "Chưa vận chuyển" : 'Đang vận chuyển';
              String total = formatAsCurrency(data['total']);
              setState(() {
                listOrder.add(DataRow(
                    selected: select,
                    onSelectChanged: (value) {
                      setState(() {
                        select = !select;
                      });
                    },
                    // mouseCursor: MaterialStateMouseCursor.clickable,
                    cells: [
                      DataCell(Text(i.toString())),
                      DataCell(Text(date)),
                      DataCell(Text(name)),
                      DataCell(Text(method)),
                      DataCell(Text(status)),
                      DataCell(Text(total)),
                    ]));
                i++;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Đơn hàng",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              showCheckboxColumn: false,
              dataRowMaxHeight: double.infinity,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text(
                    "STT",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Ngày đặt",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Khách hàng",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Hình thức TT",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Giao Hàng",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Tổng tiền",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
              rows: listOrder,
            ),
          ),
        ],
      ),
    );
  }
}
