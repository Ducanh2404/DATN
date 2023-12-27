import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:project/views/admin/responsive.dart';
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
    getListCategories();
    super.initState();
  }

  //xóa sản phẩm
  Future<void> deleteProduct() async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(selectedProductId)
          .delete();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Xóa sản phẩm thành công'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  manageProd = !manageProd;
                  editProd = !editProd;
                  finalList = [];
                  fetchDocuments();
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

  //Thêm sản phẩm
  int i = 0;
  Future<void> addProduct() async {
    try {
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('products');
      Map<String, dynamic> updatefilter = {};
      for (int i = 0; i < keyControllers.length; i++) {
        updatefilter[keyControllers[i].text] = valueControllers[i].text;
      }
      await collection.add({
        'name': addNameController.text,
        'sale': double.tryParse(addSaleController.text),
        'money': convertToDouble(addPriceController.text),
        'short-des': addShortDesController.text,
        'image': webImage,
        'category': selectedOptions,
        'filter': updatefilter,
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thêm sản phẩm thành công'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  manageProd = !manageProd;
                  addProd = !addProd;
                  finalList = [];
                  fetchDocuments();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print('thêm thành công');
    } catch (e) {
      print(e);
    }
  }

  //
  double convertToDouble(String priceText) {
    String priceCleaned = priceText.replaceAll('.', '').replaceAll('₫', '');
    double price = double.tryParse(priceCleaned) ?? 0.0;
    return price;
  }

  String selectedProductId = '';
  Future<void> updateProduct() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('products');
      DocumentReference document = collection.doc(selectedProductId);
      Map<String, dynamic> updatefilter = {};
      for (int i = 0; i < keyControllers.length; i++) {
        updatefilter[keyControllers[i].text] = valueControllers[i].text;
      }
      print(updatefilter);
      await document.update({
        'name': nameController.text,
        'sale': double.tryParse(saleController.text),
        'money': convertToDouble(priceController.text),
        'short-des': shortDesController.text,
        'image': webImage,
        'category': selectedOptions,
        'filter': updatefilter,
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cập nhật sản phẩm thành công'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  manageProd = !manageProd;
                  editProd = !editProd;
                  finalList = [];
                  fetchDocuments();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print('Sửa thành công');
    } catch (e) {
      print(e);
    }
  }

  //chọn ảnh
  bool imageAvailable = false;
  String webImage = '';

  Future<void> pickImage() async {
    final image = await ImagePickerWeb.getImageAsFile();
    if (image != null) {
      String fileName = image.name;
      setState(() {
        imageAvailable = true;
        webImage = fileName;
      });
    }
  }

  //format giá
  String formatAsCurrency(double value) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final roundedValue = (value / 1000).round() * 1000;
    return numberFormat.format(roundedValue);
  }

  //sau khi chọn sản phẩm
  List<Widget> filterWidget = [];
  Set<String> filterList = {};
  List<TextEditingController> keyControllers = [];
  List<TextEditingController> valueControllers = [];
  Future selectedProduct(String id) async {
    filterWidget = [];
    keyControllers = [];
    valueControllers = [];
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('products').doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    double newprice;
    String name = data['name'];
    String price = formatAsCurrency(data['money']).toString();
    String sale = data['sale'].toString();
    String shortDes = data['short-des'];
    String img_url = data['image'];
    List<String> prodCate = (data['category'] as List<dynamic>)
        .map((item) => item.toString())
        .toList();
    Map<String, dynamic> filter = data['filter'];
    int i = 0;
    filter.forEach((key, value) {
      int index = i;
      keyControllers.add(TextEditingController(text: key));
      valueControllers.add(TextEditingController(text: value));
      Widget filter = Row(
        children: [
          Container(
            constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
            child: DropdownMenu(
              expandedInsets: EdgeInsets.all(0),
              controller: keyControllers[i],
              requestFocusOnTap: true,
              onSelected: (String? filter) {},
              dropdownMenuEntries: filterList.map((filter) {
                return DropdownMenuEntry<String>(
                  value: '',
                  label: filter,
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            constraints: BoxConstraints(minWidth: 0, maxWidth: 200),
            child: TextField(
              controller: valueControllers[i],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  filterWidget.removeAt(index);
                  keyControllers.removeAt(index);
                  valueControllers.removeAt(index);
                  index--;
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.circleMinus,
                size: 20,
                color: Colors.red,
              )),
        ],
      );
      filterWidget.add(filter);
      i++;
    });
    filterWidget.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
            onPressed: () {
              keyControllers.add(TextEditingController());
              valueControllers.add(TextEditingController());
              setState(() {
                int index = i;
                filterWidget.insert(
                    i,
                    Row(
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 0, maxWidth: 200),
                          child: DropdownMenu(
                            expandedInsets: EdgeInsets.all(0),
                            controller: keyControllers[i],
                            requestFocusOnTap: true,
                            onSelected: (String? filter) {},
                            dropdownMenuEntries: filterList.map((filter) {
                              return DropdownMenuEntry<String>(
                                value: '',
                                label: filter,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 0, maxWidth: 200),
                          child: TextField(
                            controller: valueControllers[i],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                filterWidget.removeAt(index);
                                keyControllers.removeAt(index);
                                valueControllers.removeAt(index);
                                i--;
                              });
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.circleMinus,
                              size: 20,
                              color: Colors.red,
                            )),
                      ],
                    ));
              });
              i++;
            },
            icon: FaIcon(
              FontAwesomeIcons.circlePlus,
              size: 20,
            ),
            label: Text('Thêm đặc điểm')),
      ],
    ));
    newprice = data['money'] - (data['money'] * (data['sale'] / 100));
    if (img_url.isNotEmpty) {
      setState(() {
        imageAvailable = true;
        webImage = img_url;
      });
    }
    setState(() {
      selectedProductId = id;
      selectedOptions = prodCate;
      nameController.text = name;
      saleController.text = sale;
      priceController.text = price;
      salePriceController.text = formatAsCurrency(newprice).toString();
      shortDesController.text = shortDes;
    });
  }

  //lấy dữ liệu sản phẩm
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
                Map<String, dynamic> filter = data['filter'];
                for (var key in filter.keys) {
                  filterList.add(key);
                }
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

  //lấy dữ liệu danh mục sản phẩm
  Future<void> getListCategories() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot categories) => categories.docs.forEach((doc) {
              Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
              String mainCate = data['name'];
              setState(() {
                categoriesOptions.add(mainCate);
              });
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
                    categoriesOptions.add(subCate);
                  });
                });
              });
            }));
  }

  List<String> categoriesOptions = [];
  List<String> selectedOptions = [];

  bool manageProd = true;
  bool editProd = false;
  bool addProd = false;
  //controller editproduct
  TextEditingController nameController = TextEditingController();
  TextEditingController saleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController shortDesController = TextEditingController();
  //controller add product
  TextEditingController addNameController = TextEditingController();
  TextEditingController addSaleController = TextEditingController();
  TextEditingController addPriceController = TextEditingController();
  TextEditingController addShortDesController = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          //widget thêm sản phẩm
          Visibility(
            visible: addProd,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          manageProd = !manageProd;
                          addProd = !addProd;
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 16,
                      ),
                      label: Text('Danh sách sản phẩm'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addNameController,
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        controller: addPriceController,
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        controller: addSaleController,
                        decoration: InputDecoration(
                          labelText: 'Giảm giá',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hình ảnh sản phẩm',
                        style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            pickImage();
                          });
                        },
                        child: Text('Chọn ảnh')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageAvailable
                        ? Image.asset(
                            'img/product/$webImage',
                            height: 200,
                            width: 200,
                          )
                        : Image.asset(
                            'img/imagepicker.png',
                            height: 200,
                            width: 200,
                          ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        controller: addShortDesController,
                        decoration: InputDecoration(
                          labelText:
                              'Mô tả ngắn (Mỗi dòng cách nhau bởi dấu *)',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Danh mục sản phẩm',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                Wrap(
                  children: categoriesOptions.map((String option) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(option),
                        selected: selectedOptions.contains(option),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedOptions.add(option);
                              print(selectedOptions);
                            } else {
                              selectedOptions.remove(option);
                              print(selectedOptions);
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Đặc điểm',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: filterWidget,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        addProduct();
                      },
                      child: Text('Thêm sản phẩm')),
                )
              ],
            ),
          ),
          //end thêm sản phẩm
          //widget sửa sản phẩm
          Visibility(
            visible: editProd,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          manageProd = !manageProd;
                          editProd = !editProd;
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 16,
                      ),
                      label: Text('Danh sách sản phẩm'),
                    ),
                  ],
                ),
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
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
                        readOnly: true,
                        controller: salePriceController,
                        decoration: InputDecoration(
                          labelText: 'Giá sau khi giảm',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hình ảnh sản phẩm',
                        style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            pickImage();
                          });
                        },
                        child: Text('Chọn ảnh')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageAvailable
                        ? Image.asset(
                            'img/product/$webImage',
                            height: 200,
                            width: 200,
                          )
                        : Image.asset(
                            'img/imagepicker.png',
                            height: 200,
                            width: 200,
                          ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        controller: shortDesController,
                        decoration: InputDecoration(
                          labelText:
                              'Mô tả ngắn (Mỗi dòng cách nhau bởi dấu *)',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Danh mục sản phẩm',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                Wrap(
                  children: categoriesOptions.map((String option) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(option),
                        selected: selectedOptions.contains(option),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedOptions.add(option);
                              print(selectedOptions);
                            } else {
                              selectedOptions.remove(option);
                              print(selectedOptions);
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Đặc điểm',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: filterWidget,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            updateProduct();
                          },
                          child: Text('Cập nhật sản phẩm')),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            deleteProduct();
                          },
                          child: Text('Xóa sản phẩm')),
                    ],
                  ),
                )
              ],
            ),
          ),
          //end sửa sản phẩm
          //widget danh sách sản phẩm
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
                        onPressed: () {
                          setState(() {
                            keyControllers = [];
                            valueControllers = [];
                            imageAvailable = false;
                            selectedOptions = [];
                            filterWidget = [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton.icon(
                                      onPressed: () {
                                        keyControllers
                                            .add(TextEditingController());
                                        valueControllers
                                            .add(TextEditingController());
                                        setState(() {
                                          int index = i;
                                          filterWidget.insert(
                                              i,
                                              Row(
                                                children: [
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        minWidth: 0,
                                                        maxWidth: 200),
                                                    child: DropdownMenu(
                                                      expandedInsets:
                                                          EdgeInsets.all(0),
                                                      controller:
                                                          keyControllers[i],
                                                      requestFocusOnTap: true,
                                                      onSelected:
                                                          (String? filter) {},
                                                      dropdownMenuEntries:
                                                          filterList
                                                              .map((filter) {
                                                        return DropdownMenuEntry<
                                                            String>(
                                                          value: '',
                                                          label: filter,
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        minWidth: 0,
                                                        maxWidth: 200),
                                                    child: TextField(
                                                      controller:
                                                          valueControllers[i],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          filterWidget
                                                              .removeAt(index);
                                                          keyControllers
                                                              .removeAt(index);
                                                          valueControllers
                                                              .removeAt(index);
                                                          i--;
                                                        });
                                                      },
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .circleMinus,
                                                        size: 20,
                                                        color: Colors.red,
                                                      )),
                                                ],
                                              ));
                                          i++;
                                        });
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.circlePlus,
                                        size: 20,
                                      ),
                                      label: Text('Thêm đặc điểm')),
                                ],
                              )
                            ];
                            manageProd = !manageProd;
                            addProd = !addProd;
                          });
                        },
                        child: Text('Thêm Sản Phẩm'))
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
                                width: Responsive.isMobile(context) ? 100 : 400,
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
          //end danh sách sản phẩm
        ],
      ),
    );
  }
}
