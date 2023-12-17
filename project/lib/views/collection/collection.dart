import 'package:project/all_imports.dart';

class Collection extends StatefulWidget {
  final String category;
  const Collection({Key? key, required this.category}) : super(key: key);

  @override
  State<Collection> createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFf3f3f3),
          ),
          child: Column(children: [
            Header(),
            BannerCollection(),
            ContentCollection(
              category: widget.category,
            ),
            Footer(),
          ]),
        ),
      ),
    );
  }
}
