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
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Set border radius to zero
              ),
            ),
            foregroundColor:MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.6)),
            backgroundColor:  MaterialStateProperty.all<Color>(Color(0xFF869791).withOpacity(0.6)),
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
            minimumSize: MaterialStatePropertyAll(Size(0, 0))),
        icon: const Icon(Icons.chevron_right, size: 30,),
        onPressed: () {
          buttonCarouselController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        label: const Text(""),
      ),
    ));
  }
}
