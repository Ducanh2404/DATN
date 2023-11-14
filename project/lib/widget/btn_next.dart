import 'package:project/all_imports.dart';
class ButtonNext extends StatelessWidget {
  const ButtonNext({
    super.key,
    required this.buttonCarouselController,
  });

  final CarouselController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        style: ButtonStyle(overlayColor: TransparentButton()),
        icon: Icon(Icons.arrow_forward, size: 30),
        onPressed: () {
          buttonCarouselController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        label: Text(""),
      ),
    ));
  }
}