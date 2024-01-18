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

  // lấy dữ liệu tài khoản
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

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  // thêm thông tin tài khoản vào csdl
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    return users
        .add({
          'name': '',
          'email': _controllerEmail.text,
          'status': '1',
        })
        .then((value) => print("Thêm user thành công"))
        .catchError((error) => print("$error"));
  }

  //hàm hiển thị lỗi
  void showError(String err) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi'),
          content: Text(err),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // tạo tài khoản trên firebase
  void createUserWithEmailAndPassword() async {
    if (_controllerEmail.text.isEmpty) {
      showError('Vui lòng nhập Email');
    }
    if (_controllerPass.text.isEmpty) {
      showError('Vui lòng nhập mật khẩu.');
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPass.text.trim());
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          addUser();
          user.sendEmailVerification();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Đăng ký tài khoản thành công'),
                content: const Text("Vui lòng xác thực email đã đăng ký"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        if (e.code == "weak-password") {
          showError('Mật khẩu phải chứa ít nhất 6 kí tự');
        }
        if (e.code == "invalid-email") {
          showError('Vui lòng nhập đúng định dạng email');
        }
        if (e.code == "email-already-in-use") {
          showError('Email đã được sử dụng');
        }
      }
    }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tài khoản",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thêm tài khoản Admin'),
                          content: Wrap(
                            children: [
                              TextField(
                                decoration: InputDecoration(labelText: 'Email'),
                                controller: _controllerEmail,
                              ),
                              TextField(
                                decoration:
                                    InputDecoration(labelText: 'Mật khẩu'),
                                controller: _controllerPass,
                              )
                            ],
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('Hủy'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Thêm'),
                                  onPressed: () {
                                    createUserWithEmailAndPassword();
                                  },
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Thêm Admin'))
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                columnSpacing: defaultPadding,
                columns: const [
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
