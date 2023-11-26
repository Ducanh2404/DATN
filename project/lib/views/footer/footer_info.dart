import 'package:project/all_imports.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theo dõi chúng tôi tại',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      style: ButtonStyle(overlayColor: TransparentButton()),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.squareFacebook,
                          size: 24, color: Colors.white)),
                  IconButton(
                      style: ButtonStyle(
                          overlayColor: TransparentButton(),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                            horizontal: 0.0,
                          ))),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.instagram,
                          size: 24, color: Colors.white)),
                  IconButton(
                      style: ButtonStyle(
                          overlayColor: TransparentButton(),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                            horizontal: 0.0,
                          ))),
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.youtube,
                          size: 24, color: Colors.white)),
                ],
              )
            ],
          ),
          Column(
            children: [
              Text(
                'Đăng ký email để nhận tin khuyến mãi',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Subcriber(),
            ],
          ),
        ]),
      ),
    );
  }
}

class Subcriber extends StatefulWidget {
  Subcriber({
    super.key,
  });

  @override
  State<Subcriber> createState() => _SubcriberState();
}

class _SubcriberState extends State<Subcriber> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _controller,
        onSubmitted: (String value) {},
      ),
    );
  }
}
