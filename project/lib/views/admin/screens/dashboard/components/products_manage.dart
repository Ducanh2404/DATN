import 'dart:html' as html;
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
            title: const Text('Xóa sản phẩm thành công'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
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

  // thêm ảnh vào database
  String image_url = '';
  Future<void> uploadImage(Uint8List file, SettableMetadata metadata) async {
    try {
      if (kIsWeb) {
        final storage = FirebaseStorage.instance;
        final reference =
            storage.ref().child('product/${metadata.customMetadata!['path']}');
        final uploadTask = reference.putData(file, metadata);
        // chờ ảnh upload lên CSDL
        await uploadTask;
        final imageUrl = await reference.getDownloadURL();
        setState(() {
          image_url = imageUrl;
        });
        print('Image uploaded successfully.');
      }
    } catch (e) {
      print(e);
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
      if (localImage != null && imageAvailable == true) {
        await uploadImage(localImage!, type!);
      }
      await collection.add({
        'name': addNameController.text,
        'sale': double.tryParse(addSaleController.text),
        'money': convertToDouble(addPriceController.text),
        'sell': ((double.tryParse(addSaleController.text)! -
                        (double.tryParse(addSaleController.text)! *
                            (convertToDouble(addPriceController.text) / 100))) /
                    1000)
                .round() *
            1000,
        'short-des': addShortDesController.text,
        'image': image_url,
        'category': selectedOptions,
        'filter': updatefilter,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thêm sản phẩm thành công'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  manageProd = !manageProd;
                  addProd = !addProd;
                  addNameController.clear();
                  addSaleController.clear();
                  addPriceController.clear();
                  addShortDesController.clear();
                  image_url = '';
                  i = 0;
                  updatefilter = {};
                  finalList = [];
                  fetchDocuments();
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

  // cập nhật sản phẩm
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
      if (localImage != null && imageAvailable == true) {
        await uploadImage(localImage!, type!);
      }
      await document.update({
        'name': nameController.text,
        'sale': double.tryParse(saleController.text),
        'money': convertToDouble(priceController.text),
        'sell': ((double.tryParse(addSaleController.text)! -
                        (double.tryParse(addSaleController.text)! *
                            (convertToDouble(addPriceController.text) / 100))) /
                    1000)
                .round() *
            1000,
        'short-des': shortDesController.text,
        'image': image_url,
        'category': selectedOptions,
        'filter': updatefilter,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cập nhật sản phẩm thành công'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
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
    } catch (e) {
      print(e);
    }
  }

  //chọn ảnh
  bool imageAvailable = false;
  SettableMetadata? type;

  Uint8List? localImage;
  Future<void> pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    String? mimeType = mime(Path.basename(mediaData!.fileName!));
    html.File mediaFile =
        html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    var metadata = SettableMetadata(
      contentType: mimeType,
      customMetadata: {'path': mediaData.fileName!},
    );
    // ignore: unnecessary_null_comparison
    if (mediaFile != null) {
      setState(() {
        imageAvailable = true;
        remoteImage = false;
        type = metadata;
        localImage = mediaData.data;
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
  bool remoteImage = true;
  List<Widget> filterWidget = [];
  Set<String> filterList = {};
  List<TextEditingController> keyControllers = [];
  List<TextEditingController> valueControllers = [];
  Future selectedProduct(String id) async {
    remoteImage = true;
    imageAvailable = false;
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
    String image = data['image'];

    List<String> prodCate = (data['category'] as List<dynamic>)
        .map((item) => item.toString())
        .toList();
    Map<String, dynamic> filter = data['filter'];
    int i = 0;
    filter.forEach((key, value) {
      int index = i;
      keyControllers.add(TextEditingController(text: key));
      valueControllers.add(TextEditingController(text: value));
      Widget filter = Wrap(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 0, maxWidth: 200),
            child: DropdownMenu(
              expandedInsets: const EdgeInsets.all(0),
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
          const SizedBox(
            width: 20,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 0, maxWidth: 200),
            child: TextField(
              controller: valueControllers[i],
            ),
          ),
          const SizedBox(
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
              icon: const FaIcon(
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
                    Wrap(
                      children: [
                        Container(
                          constraints:
                              const BoxConstraints(minWidth: 0, maxWidth: 200),
                          child: DropdownMenu(
                            expandedInsets: const EdgeInsets.all(0),
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
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          constraints:
                              const BoxConstraints(minWidth: 0, maxWidth: 200),
                          child: TextField(
                            controller: valueControllers[i],
                          ),
                        ),
                        const SizedBox(
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
                            icon: const FaIcon(
                              FontAwesomeIcons.circleMinus,
                              size: 20,
                              color: Colors.red,
                            )),
                      ],
                    ));
              });
              i++;
            },
            icon: const FaIcon(
              FontAwesomeIcons.circlePlus,
              size: 20,
            ),
            label: const Text('Thêm đặc điểm')),
      ],
    ));
    newprice = data['money'] - (data['money'] * (data['sale'] / 100));

    if (image.isNotEmpty) {
      setState(() {
        image_url = image;
        remoteImage = true;
      });
    } else {
      setState(() {
        remoteImage = false;
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

  //lấy dữ liệu danh sách sản phẩm từ db
  final TextEditingController searchProduct = TextEditingController();
  List<DataRow> finalList = [];
  Future fetchDocuments() async {
    try {
      List<DataRow> listProd = [];
      await FirebaseFirestore.instance
          .collection("products")
          .orderBy('name', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) =>
              querySnapshot.docs.forEach((doc) async {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                String name = data['name'];
                String image = data['image'];
                String? url = '';
                Map<String, dynamic> filter = data['filter'];
                if (image.isNotEmpty) {
                  final storage = FirebaseStorage.instance.ref().child(image);
                  var url_img = await storage.getDownloadURL();
                  url = url_img;
                }
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
                            image.isNotEmpty
                                ? Image(
                                    image: NetworkImage(url!),
                                    width: 50,
                                  )
                                : Container(),
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
                            image.isNotEmpty
                                ? Image(
                                    image: NetworkImage(url!),
                                    width: 50,
                                  )
                                : Container(),
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
          //widget thêm sản phẩm
          Visibility(
            visible: addProd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 16,
                      ),
                      label: const Text('Danh sách sản phẩm'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addNameController,
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
                          labelText: 'Giá gốc',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        controller: addSaleController,
                        decoration: const InputDecoration(
                          labelText: 'Giảm giá',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    Text('Hình ảnh sản phẩm',
                        style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            pickImage();
                          });
                        },
                        child: const Text('Chọn ảnh')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageAvailable
                        ? Image.memory(
                            localImage!,
                            height: 200,
                            width: 200,
                          )
                        : Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/imagepicker.png?alt=media&token=100b1069-b684-450e-ace5-f333628fc9ca',
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
                        decoration: const InputDecoration(
                          labelText:
                              'Mô tả ngắn (Mỗi dòng cách nhau bởi dấu *)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
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
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
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
                            } else {
                              selectedOptions.remove(option);
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
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: filterWidget,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        addProduct();
                      },
                      child: const Text('Thêm sản phẩm')),
                )
              ],
            ),
          ),
          //end thêm sản phẩm
          //widget sửa sản phẩm
          Visibility(
            visible: editProd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 16,
                      ),
                      label: const Text('Danh sách sản phẩm'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
                          labelText: 'Giá gốc',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        controller: saleController,
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
                          labelText: 'Giá sau khi giảm',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    Text('Hình ảnh sản phẩm',
                        style: Theme.of(context).textTheme.titleLarge),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            pickImage();
                          });
                        },
                        child: const Text('Chọn ảnh')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    remoteImage
                        ? Image.network(
                            image_url,
                            height: 200,
                            width: 200,
                          )
                        : imageAvailable
                            ? Image.memory(
                                localImage!,
                                height: 200,
                                width: 200,
                              )
                            : Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/imagepicker.png?alt=media&token=100b1069-b684-450e-ace5-f333628fc9ca',
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
                        decoration: const InputDecoration(
                          labelText:
                              'Mô tả ngắn (Mỗi dòng cách nhau bởi dấu *)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
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
                            } else {
                              selectedOptions.remove(option);
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
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: filterWidget,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Wrap(
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            updateProduct();
                          },
                          child: const Text('Cập nhật sản phẩm')),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Text('Bạn muốn xóa sản phẩm này?'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          child: const Text('Hủy'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Xóa'),
                                          onPressed: () {
                                            deleteProduct();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Xóa sản phẩm')),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
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
                                                Wrap(
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 0,
                                                              maxWidth: 200),
                                                      child: DropdownMenu(
                                                        expandedInsets:
                                                            const EdgeInsets
                                                                .all(0),
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
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 0,
                                                              maxWidth: 200),
                                                      child: TextField(
                                                        controller:
                                                            valueControllers[i],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            filterWidget
                                                                .removeAt(
                                                                    index);
                                                            keyControllers
                                                                .removeAt(
                                                                    index);
                                                            valueControllers
                                                                .removeAt(
                                                                    index);
                                                            i--;
                                                          });
                                                        },
                                                        icon: const FaIcon(
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
                                        icon: const FaIcon(
                                          FontAwesomeIcons.circlePlus,
                                          size: 20,
                                        ),
                                        label: const Text('Thêm đặc điểm')),
                                  ],
                                )
                              ];
                              manageProd = !manageProd;
                              addProd = !addProd;
                            });
                          },
                          child: const Text('Thêm Sản Phẩm'))
                    ],
                  ),
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
                            children: [
                              const Text(
                                "Sản Phẩm",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: Responsive.isMobile(context)
                                    ? 50
                                    : Responsive.isTablet(context)
                                        ? 300
                                        : 500,
                                child: TextField(
                                  controller: searchProduct,
                                  decoration: const InputDecoration(
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
