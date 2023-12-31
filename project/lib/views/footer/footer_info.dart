import 'package:project/all_imports.dart';

class FooterInfo extends StatelessWidget {
  const FooterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      margin: const EdgeInsets.symmetric(vertical: 32),
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
              const Text(
                'Theo dõi chúng tôi tại',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      style: ButtonStyle(overlayColor: TransparentButton()),
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.squareFacebook,
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
                      icon: const FaIcon(FontAwesomeIcons.instagram,
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
                      icon: const FaIcon(FontAwesomeIcons.youtube,
                          size: 24, color: Colors.white)),
                ],
              )
            ],
          ),
          if (!Responsive.isMobile(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đăng ký email để nhận tin khuyến mãi',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                const SizedBox(
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
  String text = "";
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 350,
          height: 40,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Nhập email của bạn",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controller,
            onSubmitted: (String value) {
              setState(() {
                text = _controller.text;
              });
            },
          ),
        ),
        SizedBox(
          height: 40,
          child: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF3278f6)),
                overlayColor: TransparentButton(),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 16)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text("Đăng ký",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700))),
        )
      ],
    );
  }
}
