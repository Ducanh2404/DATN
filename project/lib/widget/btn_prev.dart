import 'package:project/all_imports.dart';

class ButtonPrev extends StatelessWidget {
  const ButtonPrev({
    super.key,
    required this.buttonCarouselController,
  });

  final CarouselController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        style: ButtonStyle(overlayColor: TransparentButton()),
        onPressed: () {
          buttonCarouselController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        icon: const Icon(Icons.arrow_back, size: 30),
        label: const Text(""),
      ),
    ));
  }
}
