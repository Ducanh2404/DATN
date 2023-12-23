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

  final List<DataRow> listProd = [];

  Future fetchDocuments() async {
    try {
      await FirebaseFirestore.instance.collection("products").get().then(
          (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                String name = data['name'];
                String image = data['image'];
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
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )),
                  ]));
                });
              }));
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
                "Danh Sách Sản Phẩm",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Thêm Sản Phẩm',
                    maxLines: 4,
                    overflow: TextOverflow.clip,
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
                    label: Row(
                      children: [
                        Text(
                          "Sản Phẩm",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter text',
                              hintText: 'Type something...',
                            ),
                            onChanged: (value) {
                              print('Input: $value');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                rows: listProd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
