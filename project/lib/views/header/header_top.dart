import 'package:project/all_imports.dart';

class HeaderTop extends StatefulWidget {
  const HeaderTop({ super.key });

  @override
  _HeaderTopState createState() => _HeaderTopState();
}

class _HeaderTopState extends State<HeaderTop> {
   String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _sendEmail(String email) async {
    final Uri emaillaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Gửi mail tới $email',
      }),
    );
    await launchUrl(emaillaunchUri);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: const BoxDecoration(
              color: Color(0xFF3278f6),
            ),
            child: SizedBox(
              width: 1600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      right: BorderSide(
                        color: Color(0xFF2860c5),
                        width: 2.0,
                      ),
                    )),
                    child: TextButton.icon(
                      onPressed: () => {
                        setState(() {
                          _makePhoneCall('tel:3459192');
                        }),
                      },
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      label: const Text(
                        '(012) 345.9192',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => {
                      setState(() {
                        _sendEmail('1951060533@e.tlu.edu.vn');
                      }),
                    },
                    icon: const Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    label: const Text(
                      '1951060533@e.tlu.edu.vn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ));
  }
}