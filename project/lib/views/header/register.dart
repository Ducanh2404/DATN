import 'package:project/all_imports.dart';

class Register extends StatefulWidget {
  final void Function(String) toLogin;
  const Register({super.key, required this.toLogin});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPass;
  late TextEditingController _controllerName;
  late StreamSubscription _firebaseStreamEvents;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPass = TextEditingController();
    _controllerName = TextEditingController();
    _firebaseStreamEvents =
        FirebaseAuth.instance.authStateChanges().listen((user) {});
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPass.dispose();
    _controllerName.dispose();
    _firebaseStreamEvents.cancel();
    super.dispose();
  }

  void createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPass.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print('Mật khẩu quá yếu');
      } else if (e.code == "email-already-in-use") {
        print('Email đã được sử dụng');
      }
    } catch (e) {
      print(e);
    }
    _firebaseStreamEvents =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        user.updateProfile(displayName: _controllerName.text.trim());
        user.sendEmailVerification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 24),
            child: Text('Tạo tài khoản',
                style: GoogleFonts.chakraPetch(
                  textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ))),
        Text(
          'Họ và tên',
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
              hintText: "Nhập họ và tên của bạn",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerName,
          ),
        ),
        SizedBox(
          height: 12,
        ),
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
              hintText: "Nhập email mà bạn muốn đăng ký",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerEmail,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          'Mật khẩu',
          style: GoogleFonts.chakraPetch(
              textStyle: TextStyle(
                  color: Color(0xFF8d94ac),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ),
        Material(
          child: TextField(
            obscureText: true,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.zero),
              filled: true,
              fillColor: Colors.white,
              hintText: "Nhập mật khẩu của bạn",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerPass,
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
                    createUserWithEmailAndPassword();
                    widget.toLogin('login');
                  },
                  child: Text('Tạo tài khoản',
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
              'Đã có tài khoản?',
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
