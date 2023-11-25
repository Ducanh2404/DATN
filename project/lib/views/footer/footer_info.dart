import 'package:project/all_imports.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterInfo extends StatelessWidget {
  const FooterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF29324e),
      ),
      child: SizedBox(
        width: 1600,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              Text(
                'Theo dõi chúng tôi tại',
                style: TextStyle(
                  height: 1,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
                
              ),
              SizedBox(height: 20,),
              IconButton(onPressed: (), icon: null,
              label: ico)
            ],
          ),
          Container(),
        ]),
      ),
    );
  }
}
