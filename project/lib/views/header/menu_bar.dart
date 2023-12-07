import 'package:project/all_imports.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  late List<String> categories = [];
  // CollectionReference<Map<String, dynamic>> _productCategories =
  //     FirebaseFirestore.instance.collection('categories');
  // late Stream<QuerySnapshot> _streamCategoriesItems;
  void initState() {
    super.initState();
    // _streamCategoriesItems = _productCategories.snapshots();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('categories');
      QuerySnapshot querySnapshot = await collectionRef.get();
      querySnapshot.docs.forEach((doc) {
        Object? data = doc.data();
        print(doc);
      });

      QuerySnapshot cate =
          await FirebaseFirestore.instance.collection('categories').get();
      DocumentReference doc1 = FirebaseFirestore.instance
          .collection('categories')
          .doc('categories1');
      QuerySnapshot subCate1 = await doc1.collection('sub-categories1').get();
      List<String> items =
          cate.docs.map((doc) => doc['name'] as String).toList();
      List<String> subCateItem1 =
          subCate1.docs.map((doc) => doc['name'] as String).toList();
      print(querySnapshot);
      setState(() {
        categories = items;
      });
    } catch (e) {
      print('Error fetching dropdown data: $e');
    }
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
              MenuBar(
                  style: MenuStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        BeveledRectangleBorder(
                            borderRadius: BorderRadius.zero)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0)),
                    surfaceTintColor:
                        MaterialStatePropertyAll<Color>(Colors.transparent),
                    shadowColor:
                        MaterialStatePropertyAll<Color>(Colors.transparent),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.transparent),
                  ),
                  children: [
                    SubmenuButton(
                      style: ButtonStyle(overlayColor: TransparentButton()),
                      menuStyle: MenuStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                      ),
                      menuChildren: categories.map((cat) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Color(0xff3e4b75),
                              border: BorderDirectional(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid))),
                          width: 300,
                          height: 50,
                          child: MenuItemButton(
                            onPressed: () {},
                            child: Text(
                              cat,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.bars,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('danh mục sản phẩm'.toUpperCase(),
                              style: GoogleFonts.chakraPetch(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronDown,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ])
            ],
          )),
    );
  }
}
//  StreamBuilder<QuerySnapshot>(
//                       stream: _streamCategoriesItems,
//                       builder:
//                           (BuildContext context, AsyncSnapshot snapshot) {
//                         if (snapshot.hasError) {
//                           return Text(snapshot.error.toString());
//                         }
//                         if (snapshot.connectionState ==
//                             ConnectionState.active) {
//                           QuerySnapshot querySnapshot = snapshot.data!;
//                           List<QueryDocumentSnapshot> listCategories =
//                               querySnapshot.docs;
//                           return SizedBox(
//                             height: MediaQuery.of(context).size.height,
//                             child: ListView.builder(
//                                 itemCount: listCategories.length,
//                                 itemBuilder: (context, index) {
//                                   QueryDocumentSnapshot data =
//                                       listCategories[index];
//                                   return ListTile(
//                                     title: Text(data['name']),
//                                   );
//                                 }),
//                           );
//                         }
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }),
