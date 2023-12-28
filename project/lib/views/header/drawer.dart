import 'package:project/all_imports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Widget> listDrawer = [];

  @override
  initState() {
    fetchCollectionData();
    super.initState();
  }

  Future<void> fetchCollectionData() async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .orderBy('name', descending: true)
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
                    listSubCate.add(Row(
                      children: [
                        Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: TransparentButton()),
                                onPressed: () {
                                  Navigator.pop(context);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Collection(
                                              category: subCate['name'])));
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    subCate['name'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                      ],
                    ));
                  });
                });
                setState(() {
                  listDrawer.add(Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.symmetric(
                          horizontal:
                              BorderSide(width: .1, color: Colors.white),
                        )),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextButton(
                                    style: ButtonStyle(
                                        overlayColor: TransparentButton()),
                                    onPressed: () {
                                      Navigator.pop(context);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Collection(
                                                  category: mainCate['name'])));
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        mainCate['name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))),
                            Container(
                              decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      start: BorderSide(
                                          width: 1, color: Colors.white))),
                              child: IconButton(
                                style: ButtonStyle(
                                  overlayColor: TransparentButton(),
                                ),
                                icon: FaIcon(
                                  FontAwesomeIcons.caretDown,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        child: Column(
                          children: listSubCate,
                        ),
                      )
                    ],
                  ));
                });
              }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 3 / 4,
      decoration: const BoxDecoration(color: Color(0xFF29324e)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Danh mục sản phẩm',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Column(
              children: listDrawer,
            )
          ],
        ),
      ),
    );
  }
}
