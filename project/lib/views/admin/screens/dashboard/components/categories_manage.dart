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
          .orderBy('name')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          List<Widget> listSubCate = [];
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Xóa Danh Mục'),
                                    content: Text(
                                        'Bạn có muốn xóa danh mục $mainCate ?'),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            child: Text('Hủy'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Xóa'),
                                            onPressed: () {
                                              deleteCategory(doc.id);
                                              setState(() {
                                                tableCate = [];
                                                fetchCategories();
                                              });
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
                listSubCate.add(Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Xóa Danh Mục'),
                                content:
                                    Text('Bạn có muốn xóa danh mục $subCate ?'),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: Text('Hủy'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Xóa'),
                                        onPressed: () {
                                          deleteSubCategory(doc.id, subdoc.id);
                                          setState(() {
                                            tableCate = [];
                                            fetchCategories();
                                          });
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
                        icon: FaIcon(
                          FontAwesomeIcons.circleMinus,
                          size: 20,
                        )),
                    Text(subCate),
                  ],
                ));
              });
            });
            listSubCate.add(TextButton.icon(
                label: Text('Thêm Danh Mục Con'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text('Thêm Danh Mục Vào $mainCate'),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                                categoryController.clear();
                              },
                            ),
                          ],
                        ),
                        content: TextField(
                          controller: subCateController,
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
                                  categoryController.clear();
                                },
                              ),
                              TextButton(
                                child: Text('Thêm'),
                                onPressed: () {
                                  addSubCategory(doc.id);
                                  setState(() {
                                    tableCate = [];
                                    fetchCategories();
                                  });
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
                icon: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  size: 20,
                )));
          });
        });
      });
    } catch (error) {
      print('$error');
    }
  }

  void deleteCategory(String id) {
    FirebaseFirestore.instance.collection('categories').doc(id).delete();
  }

  void deleteSubCategory(String id, String subId) {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(id)
        .collection('subCate')
        .doc(subId)
        .delete();
  }

  Future<void> addCategory() async {
    try {
      FirebaseFirestore.instance
          .collection('categories')
          .add({
            'name': categoryController.text,
          })
          .then((value) => print("ok"))
          .catchError((error) => print(" $error"));
      categoryController.clear();
    } catch (err) {
      print(err);
    }
  }

  TextEditingController subCateController = TextEditingController();
  Future<void> addSubCategory(String id) async {
    try {
      FirebaseFirestore.instance
          .collection('categories')
          .doc(id)
          .collection('subCate')
          .add({
            'name': subCateController.text,
          })
          .then((value) => print("ok2"))
          .catchError((error) => print(" $error"));
      subCateController.clear();
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
                                  categoryController.clear();
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
                                    categoryController.clear();
                                  },
                                ),
                                TextButton(
                                  child: Text('Thêm'),
                                  onPressed: () {
                                    addCategory();
                                    setState(() {
                                      tableCate = [];
                                      fetchCategories();
                                    });
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