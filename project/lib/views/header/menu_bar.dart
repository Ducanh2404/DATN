import 'package:project/all_imports.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  List<Widget> listCate = [];
  @override
  initState() {
    fetchCollectionData();
    super.initState();
  }

  Future<void> fetchCollectionData() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot query1) => query1.docs.forEach((cate) async {
              List<Widget> listSubCate = [];
              Map<String, dynamic> mainCate =
                  cate.data() as Map<String, dynamic>;
              await FirebaseFirestore.instance
                  .collection('categories')
                  .doc(cate.id)
                  .collection('subCate')
                  .get()
                  .then((QuerySnapshot query2) {
                query2.docs.forEach((sub) {
                  Map<String, dynamic> subCate =
                      sub.data() as Map<String, dynamic>;
                  listSubCate.add(Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 80, 87),
                        border: BorderDirectional(
                            bottom: BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid))),
                    width: 300,
                    height: 50,
                    child: MenuItemButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Collection(category: subCate['name'])));
                      },
                      child: TextButton(
                        style: ButtonStyle(overlayColor: TransparentButton()),
                        child: Text(
                          subCate['name'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ));
                });
              });
              setState(() {
                listCate.add(
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 80, 87),
                        border: BorderDirectional(
                            bottom: BorderSide(
                                width: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid))),
                    width: 300,
                    height: 50,
                    child: SubmenuButton(
                        menuStyle: MenuStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              BeveledRectangleBorder(
                                  borderRadius: BorderRadius.zero)),
                        ),
                        style: ButtonStyle(
                            iconColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                        menuChildren: listSubCate,
                        child: TextButton(
                          style: ButtonStyle(overlayColor: TransparentButton()),
                          onPressed: () {},
                          child: Text(
                            mainCate['name'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                );
              });
            }));
  }

  void openDrawer() {
    Scaffold.of(context).openDrawer();
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
              IconButton(
                  onPressed: openDrawer,
                  icon: FaIcon(FontAwesomeIcons.accessibleIcon)),
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
                      menuStyle: MenuStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                      ),
                      menuChildren: listCate,
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
              // MenuBar(
              //     style: MenuStyle(
              //       shape: MaterialStateProperty.all<OutlinedBorder>(
              //           BeveledRectangleBorder(
              //               borderRadius: BorderRadius.zero)),
              //       padding: MaterialStateProperty.all<EdgeInsets>(
              //           EdgeInsets.all(0)),
              //       surfaceTintColor:
              //           MaterialStatePropertyAll<Color>(Colors.transparent),
              //       shadowColor:
              //           MaterialStatePropertyAll<Color>(Colors.transparent),
              //       backgroundColor:
              //           MaterialStatePropertyAll<Color>(Colors.transparent),
              //     ),
              //     children: [
              //       SubmenuButton(
              //         child:  Row(
              //               children: [
              //                 FaIcon(
              //                   FontAwesomeIcons.bars,
              //                   size: 16,
              //                   color: Colors.white,
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text('danh mục sản phẩm'.toUpperCase(),
              //                     style: GoogleFonts.chakraPetch(
              //                       textStyle: TextStyle(
              //                         fontWeight: FontWeight.w700,
              //                         color: Colors.white,
              //                       ),
              //                     )),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 FaIcon(
              //                   FontAwesomeIcons.chevronDown,
              //                   size: 14,
              //                   color: Colors.white,
              //                 ),
              //               ],
              //             ),
              //         menuChildren: [Container(
              //           decoration: BoxDecoration(
              //               color: Color.fromARGB(255, 78, 80, 87),
              //               border: BorderDirectional(
              //                   bottom: BorderSide(
              //                       width: 1,
              //                       color: Colors.grey,
              //                       style: BorderStyle.solid))),
              //           width: 300,
              //           height: 50,
              //           child: SubmenuButton(
              //             menuStyle: MenuStyle(
              //               shape: MaterialStateProperty.all<OutlinedBorder>(
              //                   BeveledRectangleBorder(
              //                       borderRadius: BorderRadius.zero)),
              //             ),
              //             style: ButtonStyle(
              //                 iconColor:
              //                     MaterialStateProperty.all<Color>(Colors.white)),
              //             menuChildren: [
              //               SubmenuButton(
              //                 style:
              //                     ButtonStyle(overlayColor: TransparentButton()),
              //                 menuStyle: MenuStyle(
              //                   padding: MaterialStateProperty.all<EdgeInsets>(
              //                       EdgeInsets.all(0)),
              //                   shape: MaterialStateProperty.all<OutlinedBorder>(
              //                       BeveledRectangleBorder(
              //                           borderRadius: BorderRadius.zero)),
              //                 ),
              //                 menuChildren: [
              //                   Container(
              //                     decoration: BoxDecoration(
              //                         color: Color.fromARGB(255, 78, 80, 87),
              //                         border: BorderDirectional(
              //                             bottom: BorderSide(
              //                                 width: 1,
              //                                 color: Colors.grey,
              //                                 style: BorderStyle.solid))),
              //                     width: 300,
              //                     height: 50,
              //                     child: MenuItemButton(
              //                       style: ButtonStyle(
              //                           overlayColor: TransparentButton()),
              //                       onPressed: () {},
              //                       child: TextButton(
              //                         style: ButtonStyle(
              //                             overlayColor: TransparentButton()),
              //                         child: Text(
              //                           'subDoc[name]',
              //                           style: TextStyle(color: Colors.white),
              //                         ),
              //                         onPressed: () {
              //                           Navigator.push(
              //                               context,
              //                               MaterialPageRoute(
              //                                   builder: (context) => Collection(
              //                                       category: 'subDoc[name]')));
              //                         },
              //                       ),
              //                     ),
              //                   )
              //                 ], //'documentWidgets',
              //                 child: TextButton(
              //                   style: ButtonStyle(
              //                       overlayColor: TransparentButton()),
              //                   child: Text(
              //                     'document[name]',
              //                     style: TextStyle(
              //                       fontSize: 16,
              //                       color: Colors.white,
              //                     ),
              //                   ),
              //                   onPressed: () {
              //                     // Navigator.push(
              //                     //     context,
              //                     //     MaterialPageRoute(
              //                     //         builder: (context) => Collection(
              //                     //             category: document['name'])));
              //                   },
              //                 ),
              //               )
              //             ],

              //           ),
              //         ),]
              //       ),
              //     ])
            ],
          )),
    );
  }
}
