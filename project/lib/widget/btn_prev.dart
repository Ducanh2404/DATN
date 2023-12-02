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
      child: IconButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            foregroundColor:
                MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.6)),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF869791).withOpacity(0.6)),
            overlayColor: MaterialStateProperty.resolveWith(
                <Color>(Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.black;
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.transparent;
              }
              return null;
            }),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 0.0)),
            minimumSize: const MaterialStatePropertyAll(Size(0, 0))),
        onPressed: () {
          buttonCarouselController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        icon: const Icon(Icons.chevron_left, size: 30),
      ),
    ));
  }
}
