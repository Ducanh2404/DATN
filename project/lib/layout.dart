import 'package:project/all_imports.dart';


/// a. creating StatefulWidget
class WebLayout extends StatefulWidget {
  const WebLayout({Key? key}) : super(key: key);
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
    return Scaffold(
      body: Column(children: [
        //Header top
        HeaderTop(),
       
        //header Bottom
        HeaderBottom(),
        //Menu bar
        MenuItems(),
        CarouselDemo(),
      ]),
    );
  }
}

