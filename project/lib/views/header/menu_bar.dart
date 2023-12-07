import 'package:project/all_imports.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  CollectionReference<Map<String, dynamic>> _productCategories =
      FirebaseFirestore.instance.collection('categories');
  late Stream<QuerySnapshot> _streamCategoriesItems;
  void initState() {
    super.initState();
    _streamCategoriesItems = _productCategories.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF29324e)),
      alignment: Alignment.center,
      child: SizedBox(
          width: 1600,
          child: Row(
            children: [
              MenuBar(children: [
                SubmenuButton(
                  menuChildren: [
                    StreamBuilder<QuerySnapshot>(
                        stream: _streamCategoriesItems,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            QuerySnapshot querySnapshot = snapshot.data!;
                            List<QueryDocumentSnapshot> listCategories =
                                querySnapshot.docs;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: listCategories.length,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot data =
                                      listCategories[index];
                                  return Text(data['name']);
                                  //  MenuItemButton(
                                  //     child:
                                  //         MenuAcceleratorLabel(data['name']));
                                });
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ],
                  child:
                      MenuAcceleratorLabel('Danh mục sản phẩm'.toUpperCase()),
                ),
              ]),
            ],
          )),
    );
  }
}
