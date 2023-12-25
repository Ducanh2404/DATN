import 'package:image_picker_web/image_picker_web.dart';
import '../../../constants.dart';
import 'package:project/all_imports.dart';

class ProductsManage extends StatefulWidget {
  const ProductsManage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsManage> createState() => _ProductsManageState();
}

class _ProductsManageState extends State<ProductsManage> {
  @override
  void initState() {
    fetchDocuments();
    super.initState();
  }

  bool imageAvailable = false;
  String webImage = '';

  Future<void> pickImage() async {
    final image = await ImagePickerWeb.getImageAsFile();
    String fileName = image!.name;
    setState(() {
      imageAvailable = true;
      webImage = fileName;
    });
  }

  Future selectedProduct(String id) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('products').doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    setState(() {
      nameController.text = data['name'];
    });
  }

  final TextEditingController searchProduct = TextEditingController();
  List<DataRow> finalList = [];
  Future fetchDocuments() async {
    try {
      List<DataRow> listProd = [];
      await FirebaseFirestore.instance.collection("products").get().then(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                String name = data['name'];
                String image = data['image'];
                if (searchProduct.text.isEmpty) {
                  setState(() {
                    listProd.add(DataRow(cells: [
                      DataCell(Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('img/product/$image'),
                              width: 50,
                            ),
                            Flexible(
                              child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: TransparentButton()),
                                child: Text(
                                  name,
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedProduct(doc.id);
                                    manageProd = !manageProd;
                                    editProd = !editProd;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                    ]));
                  });
                } else if (name
                        .toLowerCase()
                        .contains(searchProduct.text.toLowerCase()) &&
                    searchProduct.text.isNotEmpty) {
                  setState(() {
                    listProd.add(DataRow(cells: [
                      DataCell(Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('img/product/$image'),
                              width: 50,
                            ),
                            Flexible(
                              child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: TransparentButton()),
                                child: Text(
                                  name,
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedProduct(doc.id);
                                    manageProd = !manageProd;
                                    editProd = !editProd;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                    ]));
                  });
                }
              }));
      setState(() {
        finalList = listProd;
      });
      ;
    } catch (err) {
      print(err);
    }
  }

  bool manageProd = true;
  bool editProd = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController saleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Visibility(
            visible: editProd,
            child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Tên sản phẩm',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: 'Giá gốc',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextField(
                            controller: saleController,
                            decoration: InputDecoration(
                              labelText: 'Giảm giá',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: salePriceController,
                            decoration: InputDecoration(
                              labelText: 'Giá sau khi giảm',
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            pickImage();
                          });
                        },
                        child: Text('pickme')),
                    imageAvailable
                        ? Image.asset('img/product/$webImage')
                        : Image.asset('img/imagepicker.png')
                  ],
                )),
          ),
          Visibility(
            visible: manageProd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Danh Sách Sản Phẩm",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Thêm Sản Phẩm',
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 5,
                  child: SingleChildScrollView(
                    child: DataTable(
                      dataRowMaxHeight: double.infinity,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 20,
                            children: [
                              Text(
                                "Sản Phẩm",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 500,
                                child: TextField(
                                  controller: searchProduct,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      hintText: 'Tìm kiếm sản phẩm',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.white10))),
                                  onChanged: (value) {
                                    fetchDocuments();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      rows: finalList,
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
