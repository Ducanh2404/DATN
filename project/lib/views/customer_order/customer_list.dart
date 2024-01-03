import 'package:intl/intl.dart';
import 'package:project/all_imports.dart';

class CustomerOrderList extends StatefulWidget {
  const CustomerOrderList({Key? key}) : super(key: key);

  @override
  _CustomerOrderListState createState() => _CustomerOrderListState();
}

class _CustomerOrderListState extends State<CustomerOrderList> {
  @override
  void initState() {
    getOrders();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  List<Widget> detailsOrder = [];
  List<DataRow> listOrder = [];

  int i = 1;
  bool showOrder = true;
  bool infoOrder = false;
  Future<void> selectedOrder(String id) async {
    try {
      List<Widget> listItems = [];
      detailsOrder = [];
      showOrder = !showOrder;
      infoOrder = !infoOrder;
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('order').doc(id).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      String status = data['status'] == '1' ? 'Chưa giao' : 'Đang giao';
      String city = data['city'];
      String address = data['address'];
      String receiver = data['receiver'];
      String email = data['email'];
      String phone = data['phone'];
      String total = formatAsCurrency(data['total']);
      Map<String, dynamic> items = data['items'];
      items.forEach((key, value) async {
        try {
          DocumentSnapshot prodSnap = await FirebaseFirestore.instance
              .collection('products')
              .doc(key)
              .get();
          Map<String, dynamic> prod = prodSnap.data() as Map<String, dynamic>;
          String image = prod['image'];
          String name = prod['name'];
          double newprice =
              prod['money'] - (prod['money'] * (prod['sale'] / 100));
          String sum = formatAsCurrency(newprice * value);
          Widget item = Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image(
                    image: NetworkImage(image),
                    width: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(name),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(formatAsCurrency(newprice)),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('x'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value.toString()),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sum),
                  ),
                ),
              ),
            ],
          );
          setState(() {
            listItems.add(item);
          });
        } catch (e) {
          print(e);
        }
      });
      detailsOrder.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                showOrder = !showOrder;
                infoOrder = !infoOrder;
              });
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeftLong,
              size: 16,
            ),
            label: const Text('Danh sách đơn hàng'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(status,
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                border: BorderDirectional(
                    bottom: BorderSide(width: 1, color: Colors.white10))),
          ),
          Column(
            children: listItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Tổng cộng'),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(total),
                    ),
                  ))
            ],
          ),
          Text(
            'Địa chỉ giao hàng',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
                Text(
                  address,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Text(
            'Thông tin liên hệ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên khách hàng',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'SĐT',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ': $receiver',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      ': $email',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      ': $phone',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOrders() async {
    try {
      i = 1;
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('order')
          .where('email', isEqualTo: user!.email)
          .orderBy('date', descending: true)
          .get()
          .then((QuerySnapshot users) => users.docs.forEach((doc) {
                bool select = false;
                Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
                String orderId = doc.id;
                String date = data['date'];
                String method = data['method'];
                String status =
                    data['status'] == '1' ? "Đang xử lí" : 'Đang vận chuyển';
                String total = formatAsCurrency(data['total']);
                setState(() {
                  listOrder.add(DataRow(
                      selected: select,
                      onSelectChanged: (value) {
                        setState(() {
                          select = !select;
                          selectedOrder(orderId);
                        });
                      },
                      cells: [
                        DataCell(Text(i.toString())),
                        DataCell(Text(date)),
                        DataCell(Text(method)),
                        DataCell(Text(status)),
                        DataCell(Text(total)),
                      ]));
                  i++;
                });
              }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: 'Đơn hàng đã đặt',
      morebtn: false,
      content: Column(
        children: [
          Visibility(
            visible: infoOrder,
            child: Column(
              children: detailsOrder,
            ),
          ),
          Visibility(
            visible: showOrder,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    showCheckboxColumn: false,
                    dataRowMaxHeight: double.infinity,
                    columnSpacing: 10,
                    columns: const [
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
                          "Hình thức TT",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Trạng thái",
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
          ),
        ],
      ),
      category: '',
    );
  }
}
