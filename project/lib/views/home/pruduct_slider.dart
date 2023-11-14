import 'package:project/all_imports.dart';

class PruductSlider extends StatefulWidget {
  const PruductSlider({ Key? key }) : super(key: key);

  @override
  _PruductSliderState createState() => _PruductSliderState();
}

class _PruductSliderState extends State<PruductSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.amber[600],
      width: 1600, 
      height: 200,
      child: Column(children: [
        Container(),
        Container(),
      ]),
    );
  }
}