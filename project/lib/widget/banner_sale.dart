import 'package:project/all_imports.dart';

class BannerSale extends StatefulWidget {
  final String image_url;

  BannerSale({
    required this.image_url,
  });

  @override
  State<BannerSale> createState() => _BannerSaleState();
}

class _BannerSaleState extends State<BannerSale> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AnimatedScale(
          scale: scale,
          duration: Duration(milliseconds: 400),
          child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                  horizontal: 0.0,
                )),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (Set<MaterialState> states) {
                    return BorderSide(
                        color: Colors.grey,
                        width: 1.0); // Set border color and width
                  },
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Set border radius to zero
                  ),
                ),
              ),
              onHover: (hovered) {
                setState(() {
                  if (hovered) {
                    scale = 1.03;
                  } else {
                    scale = 1;
                  }
                });
              },
              onPressed: () {},
              child: Image(
                image: AssetImage('img/sales/sale1.jpg'),
                fit: BoxFit.contain,
              )),
        ));
  }
}
