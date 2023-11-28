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
          Header(),
          CarouselBanner(),
          Categories(),
          PruductSlider(),
          PruductSlider(),
          PruductSlider(),
          Sales(),
          News(),
          Brand(),
          Footer(),
        ]),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FooterInfo(),
        FooterMain(),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeaderTop(),
        HeaderBottom(),
        MenuItems(),
      ],
    );
  }
}
