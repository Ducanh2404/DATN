import '../../../constants.dart';
import 'package:project/all_imports.dart';

class AccountManage extends StatefulWidget {
  const AccountManage({Key? key}) : super(key: key);

  @override
  _AccountManageState createState() => _AccountManageState();
}

class _AccountManageState extends State<AccountManage> {
  @override
  void initState() {
    getAccounts();
    super.initState();
  }

  List<DataRow> listAcc = [];

  Future<void> getAccounts() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot users) => users.docs.forEach((doc) {
              Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
              String name = data['name'];
              String email = data['email'];
              String status = data['status'] == '1' ? 'Khách Hàng' : 'Admin';
              setState(() {
                listAcc.add(DataRow(cells: [
                  DataCell(Text(name)),
                  DataCell(Text(email)),
                  DataCell(Text(status)),
                ]));
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
                "Tài khoản",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: Text(
                      "Họ và tên",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Email",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Status",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
                rows: listAcc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
