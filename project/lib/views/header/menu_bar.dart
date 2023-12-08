import 'package:project/all_imports.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  Future<List<QueryDocumentSnapshot>> fetchCollectionData() async {
    QuerySnapshot collectionSnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    return collectionSnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> fetchSubcollectionData(
      String documentId) async {
    QuerySnapshot subcollectionSnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc(documentId)
        .collection('subCate')
        .get();
    return subcollectionSnapshot.docs;
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
                    FutureBuilder<List<QueryDocumentSnapshot>>(
                      future: fetchCollectionData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<QueryDocumentSnapshot>>
                              collectionSnapshot) {
                        if (collectionSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (collectionSnapshot.hasError) {
                          return Text('Error: ${collectionSnapshot.error}');
                        } else {
                          List<QueryDocumentSnapshot> collectionDocuments =
                              collectionSnapshot.data!;
                          List<Widget> documentWidgets = [];
                          for (var document in collectionDocuments) {
                            documentWidgets.add(
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
                                  alignmentOffset: Offset(0, 8),
                                  menuStyle: MenuStyle(
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                        BeveledRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                  ),
                                  style: ButtonStyle(
                                      iconColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white)),
                                  menuChildren: [
                                    FutureBuilder<List<QueryDocumentSnapshot>>(
                                      future:
                                          fetchSubcollectionData(document.id),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                                  List<QueryDocumentSnapshot>>
                                              subcollectionSnapshot) {
                                        if (subcollectionSnapshot
                                                .connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (subcollectionSnapshot
                                            .hasError) {
                                          return Text(
                                              'Error: ${subcollectionSnapshot.error}');
                                        } else {
                                          List<QueryDocumentSnapshot>
                                              subcollectionDocuments =
                                              subcollectionSnapshot.data!;
                                          List<Widget> subdocumentWidgets = [];

                                          for (var subDoc
                                              in subcollectionDocuments) {
                                            subdocumentWidgets.add(Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 78, 80, 87),
                                                  border: BorderDirectional(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey,
                                                          style: BorderStyle
                                                              .solid))),
                                              width: 300,
                                              height: 50,
                                              child: MenuItemButton(
                                                style: ButtonStyle(
                                                    overlayColor:
                                                        TransparentButton()),
                                                onPressed: () {},
                                                child: Text(
                                                  subDoc['name'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ));
                                          }

                                          return Column(
                                            children: subdocumentWidgets,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                  child: Text(
                                    document['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          return SubmenuButton(
                            style:
                                ButtonStyle(overlayColor: TransparentButton()),
                            menuStyle: MenuStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  BeveledRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                            ),
                            menuChildren: documentWidgets,
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
                          );
                        }
                      },
                    ),
                  ])
            ],
          )),
    );
  }
}
