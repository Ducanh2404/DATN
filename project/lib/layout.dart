import 'package:project/all_imports.dart';

/// a. creating StatefulWidget
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State createState() {
    return _HomeState();
  }
}

/// b. Creating state for stateful widget
class _HomeState extends State {
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
          PruductSlider(
            category: 'Laptop Dell',
          ),
          PruductSlider(
            category: 'Laptop Gaming',
          ),
          PruductSlider(
            category: 'Laptop Acer',
          ),
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
