import 'package:project/all_imports.dart';

class ForgetPass extends StatefulWidget {
  final void Function(String) toLogin;
  ForgetPass({super.key, required this.toLogin});

  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  late TextEditingController _controllerEmail;
  String email = "";

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _resetPassword() async {
    String email = _controllerEmail.text.trim();
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email đặt lại mật khẩu'),
            content: Text('Một email đặt lại mật khẩu đã được gửi đến $email.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Lỗi'),
            content: Text('Email bạn nhập không tồn tại.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Password reset error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 24),
            child: Text('Đặt lại mật khẩu',
                style: GoogleFonts.chakraPetch(
                  textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ))),
        Text(
          'Email',
          style: GoogleFonts.chakraPetch(
              textStyle: TextStyle(
                  color: Color(0xFF8d94ac),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ),
        Material(
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.zero),
              filled: true,
              fillColor: Colors.white,
              hintText: "Nhập email mà bạn đã đăng ký",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerEmail,
            onSubmitted: (String value) {
              _resetPassword();
            },
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 20)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF3278f6))),
                  onPressed: () {
                    _resetPassword();
                  },
                  child: Text('Lấy lại mật khẩu',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nhớ mật khẩu?',
              style: GoogleFonts.chakraPetch(
                  textStyle: TextStyle(
                      color: Color(0xFF8d94ac),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
            ),
            TextButton(
                style: ButtonStyle(
                  overlayColor: TransparentButton(),
                ),
                onPressed: () {
                  setState(() {
                    widget.toLogin('login');
                  });
                },
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3278f6)),
                ))
          ],
        ),
      ],
    );
  }
}
