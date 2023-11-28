import 'package:project/all_imports.dart';

class Collection extends StatelessWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFf3f3f3),
          ),
          child: const Column(children: [
            Header(),
            BannerCollection(),
            ContentCollection(),
            Footer(),
          ]),
        ),
      ),
    );
  }
}
