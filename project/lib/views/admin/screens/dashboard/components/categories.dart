import '../../../constants.dart';
import 'package:project/all_imports.dart';

class CategoriesProduct extends StatefulWidget {
  const CategoriesProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesProduct> createState() => _CategoriesProductState();
}

class _CategoriesProductState extends State<CategoriesProduct> {
  List<DataRow> tableCate = [];
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  Future fetchCategories() async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          List<Widget> listSubCate = [
            TextButton.icon(
                // style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0))),
                label: Text('Thêm Danh Mục Con'),
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  size: 20,
                ))
          ];
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
          String mainCate = data['name'];
          tableCate.add(
            DataRow(cells: [
              DataCell(Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.circleMinus,
                              size: 20,
                            )),
                        Text(mainCate),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: listSubCate),
                    )
                  ],
                ),
              )),
            ]),
          );
          FirebaseFirestore.instance
              .collection('categories')
              .doc(doc.id)
              .collection('subCate')
              .get()
              .then((QuerySnapshot querySnapshot1) {
            querySnapshot1.docs.forEach((subdoc) {
              Map<String, dynamic>? subData =
                  subdoc.data() as Map<String, dynamic>;
              String subCate = subData['name'];
              setState(() {
                listSubCate.insert(
                    0,
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.circleMinus,
                              size: 20,
                            )),
                        Text(subCate),
                      ],
                    ));
              });
            });
          });
        });
      });
    } catch (error) {
      print('$error');
    }
  }

  Future<void> addCategory() async {
    try {
      FirebaseFirestore.instance
          .collection('categories')
          .add({
            'name': categoryController.text,
          })
          .then((value) => print("ok"))
          .catchError((error) => print("Đã xảy ra lỗi $error"));
    } catch (err) {
      print(err);
    }
  }

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
                "Danh Mục Sản Phẩm",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text('Thêm Danh Mục Sản Phẩm'),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                          content: TextField(
                            controller: categoryController,
                            decoration: InputDecoration(
                              hintText: 'Tên Danh Mục',
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Thêm'),
                                  onPressed: () {
                                    // Perform OK button action here
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Thêm Danh Mục'))
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text(
                    "Tên Danh Mục",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
              rows: tableCate,
            ),
          ),
        ],
      ),
    );
  }
}
