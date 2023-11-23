import 'package:project/all_imports.dart';

/// a. creating StatefulWidget
class WebLayout extends StatefulWidget {
  const WebLayout({super.key});
  @override
  State createState() {
    return _WebLayoutState();
  }
}

/// b. Creating state for stateful widget
class _WebLayoutState extends State {
  @override
  Widget build(BuildContext context) {
    /// returning a container widget
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf3f3f3),
        ),
        child: const Column(children: [
          //Header top
          HeaderTop(),
          //header Bottom
          HeaderBottom(),
          //Menu bar
          MenuItems(),
          //Banner
          CarouselBanner(),
          //Categories
          Categories(),
          PruductSlider(),
          PruductSlider(),
          PruductSlider(),
        ]),
      ),
    );
  }
}
