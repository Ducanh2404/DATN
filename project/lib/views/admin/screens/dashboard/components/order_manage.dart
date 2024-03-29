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
    getOrders();
    super.initState();
  }

  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  List<DataRow> listOrder = [];
  List<Widget> listItems = [];
  String selectedOrderId = '';

  int i = 1;
  bool showOrder = true;
  bool infoOrder = false;
  //cập nhật trạng thái đơn hàng
  Future<void> updateOrder() async {
    try {
      DocumentReference order =
          FirebaseFirestore.instance.collection('order').doc(selectedOrderId);
      await order.update({
        if (status == 'Đang xử lí') 'status': '0',
        if (status == 'Đang giao') 'status': '1',
      });
      setState(() {
        showOrder = !showOrder;
        infoOrder = !infoOrder;
        listOrder = [];
        getOrders();
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Đơn hàng đã được cập nhật'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  //xóa đơn hàng
  Future<void> deleteOrder() async {
    try {
      await FirebaseFirestore.instance
          .collection('order')
          .doc(selectedOrderId)
          .delete();
      setState(() {
        showOrder = !showOrder;
        infoOrder = !infoOrder;
        listOrder = [];
        getOrders();
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Xóa đơn hàng thành công'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('$error');
    }
  }

  //chọn đơn hàng
  String status = '';
  String city = '';
  String address = '';
  String receiver = '';
  String email = '';
  String phone = '';
  String total = '';
  Future<void> selectedOrder(String id) async {
    if (mounted) {
      try {
        listItems = [];
        showOrder = !showOrder;
        infoOrder = !infoOrder;
        DocumentSnapshot documentSnapshot =
            await FirebaseFirestore.instance.collection('order').doc(id).get();
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        status = data['status'] == '1' ? 'Đang xử lí' : 'Đang giao';
        city = data['city'];
        address = data['address'];
        receiver = data['receiver'];
        email = data['email'];
        phone = data['phone'];
        total = formatAsCurrency(data['total']);
        Map<String, dynamic> items = data['items'];
        items.forEach((key, value) {
          FirebaseFirestore.instance
              .collection('products')
              .doc(key)
              .get()
              .then((DocumentSnapshot prodSnap) {
            Map<String, dynamic> prod = prodSnap.data() as Map<String, dynamic>;
            String image = prod['image'];
            String name = prod['name'];
            double newprice =
                prod['money'] - (prod['money'] * (prod['sale'] / 100));
            String sum = formatAsCurrency(newprice * value);
            setState(() {
              listItems.add(Row(
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
              ));
            });
          });
        });
      } catch (e) {
        print(e);
      }
    }
  }

  //lấy danh sách đơn hàng
  Future<void> getOrders() async {
    i = 1;
    await FirebaseFirestore.instance
        .collection('order')
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot users) => users.docs.forEach((doc) {
              bool select = false;
              Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
              String orderId = doc.id;
              String date = data['date'];
              String name = data['email'];
              String method = data['method'];
              String status =
                  data['status'] == '1' ? "Chờ xử lí" : 'Đang giao hàng';
              String total = formatAsCurrency(data['total']);
              setState(() {
                listOrder.add(DataRow(
                    selected: select,
                    onSelectChanged: (value) {
                      selectedOrder(orderId);
                      setState(() {
                        select = !select;
                        selectedOrderId = orderId;
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
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Visibility(
              visible: infoOrder,
              child: Column(
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
                  Text(
                    "Chi tiết đơn hàng",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(status, style: const TextStyle(color: Colors.orange)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                        border: BorderDirectional(
                            bottom:
                                BorderSide(width: 1, color: Colors.white10))),
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(city),
                        Text(address),
                      ],
                    ),
                  ),
                  Text(
                    'Thông tin liên hệ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tên người nhận'),
                            Text('Email'),
                            Text('SĐT'),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(': $receiver'),
                            Text(': $email'),
                            Text(': $phone'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                updateOrder();
                              },
                              child: Text(
                                status == 'Đang xử lí'
                                    ? 'Tiến hành giao hàng'
                                    : 'Hủy giao hàng',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                deleteOrder();
                              },
                              child: Text(
                                'Xóa đơn hàng',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Visibility(
            visible: showOrder,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đơn hàng",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (Responsive.isDesktop(context))
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      showCheckboxColumn: false,
                      dataRowMaxHeight: double.infinity,
                      columnSpacing: defaultPadding,
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
                            "Email đặt",
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
                if (!Responsive.isDesktop(context))
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showCheckboxColumn: false,
                        dataRowMaxHeight: double.infinity,
                        columnSpacing: defaultPadding,
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
                              "Email đặt",
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
