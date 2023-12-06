import 'package:project/all_imports.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class ApplicationState extends ChangeNotifier {
  List<String> guestBookMessages = [];

  Future<void> fetchGuestBookMessages() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      guestBookMessages.clear();

      for (final document in snapshot.docs) {
        final message = document.data()['name'] as String;
        guestBookMessages.add(message);
      }

      notifyListeners();
    } catch (error) {
      print('Error fetching guestbook messages: $error');
    }
  }
}

class _MenuItemsState extends State<MenuItems> {
  CollectionReference _productCategories =
      FirebaseFirestore.instance.collection('categories');
  late Stream<QuerySnapshot> _streamCategoriesItems;
  void initState() {
    super.initState();
    _streamCategoriesItems = _productCategories.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    _productCategories.get();
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF29324e)),
      alignment: Alignment.center,
      child: SizedBox(
          width: 1600,
          child: Row(
            children: [
              MenuBar(
                style: const MenuStyle(
                  surfaceTintColor:
                      MaterialStatePropertyAll<Color>(Color(0xFF29324e)),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xFF29324e)),
                  shadowColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                ),
                children: <Widget>[
                  Consumer<ApplicationState>(builder: (context, state, child) {
                    return SubmenuButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      menuChildren: state.guestBookMessages.map((message) {
                        return MenuItemButton(
                          onPressed: () {},
                          child: MenuAcceleratorLabel(message),
                        );
                      }).toList(),
                      child: const MenuAcceleratorLabel('Danh mục sản phẩm'),
                    );
                    // Center(
                    //   child: DropdownButton<String>(
                    //     hint: const Text('Select a message'),
                    //     onChanged: (value) {
                    //       // Handle the selection
                    //     },
                    //     items: state.guestBookMessages.map((message) {
                    //       return DropdownMenuItem(
                    //         value: message,
                    //         child: Text(message),
                    //       );
                    //     }).toList(),
                    //   ),
                    // );
                  }),
                  // StreamBuilder<QuerySnapshot>(
                  //     stream: _streamCategoriesItems,
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Text(snapshot.error.toString());
                  //       }
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.active) {
                  //         QuerySnapshot querySnapshot = snapshot.data;
                  //         List<QueryDocumentSnapshot> listCategories =
                  //             querySnapshot.docs;
                  //         return ListView.builder(
                  //             itemCount: listCategories.length,
                  //             itemBuilder: (context, index) {
                  //               QueryDocumentSnapshot data =
                  //                   listCategories[index];
                  //               return Center(
                  //                 child: Text(data['name']),
                  //               );
                  //               // SubmenuButton(
                  //               //   style: TextButton.styleFrom(
                  //               //     foregroundColor: Colors.white,
                  //               //   ),
                  //               //   menuChildren: <Widget>[
                  //               //     MenuItemButton(
                  //               //       onPressed: () {},
                  //               //       child: MenuAcceleratorLabel(data['name']),
                  //               //     ),
                  //               //   ],
                  //               //   child: const MenuAcceleratorLabel(
                  //               //       'Danh mục sản phẩm'),
                  //               // );
                  //             });
                  //       }
                  //       return Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     })

                  // MenuItemButton(
                  //   onPressed: () {},
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: Colors.white,
                  //   ),
                  //   child: const MenuAcceleratorLabel('Khuyến mãi'),
                  // ),
                ],
              ),
            ],
          )),
    );
  }
}
