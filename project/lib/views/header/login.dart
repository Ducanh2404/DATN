import 'package:project/all_imports.dart';
import 'package:project/views/admin/main.dart';

class Login extends StatefulWidget {
  final Function(String) updateLoginStatus;
  final void Function(String) toRegister;
  final void Function(String) toProfile;
  Login(
      {super.key,
      required this.toRegister,
      required this.updateLoginStatus,
      required this.toProfile});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPass;
  bool passwordVisible = true;
  String _errorText = '';
  String? userName;
  void loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      userName = user!.displayName;
      print(user);
      if (user.emailVerified == false) {
        setState(() {
          _errorText = 'Vui lòng xác thực email.';
        });
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get()
          .then((QuerySnapshot query) => {
                query.docs.forEach((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;

                  if (data['status'] == '0') {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Admin(),
                          ));
                    });
                  } else {
                    setState(() {
                      widget.toProfile('profile');
                      widget.updateLoginStatus(userName!);
                    });
                  }
                })
              });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Đăng nhập thành công'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        _errorText = 'Sai tài khoản hoặc mật khẩu.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPass = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 24),
            child: Text('Đăng Nhập',
                style: GoogleFonts.chakraPetch(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ))),
        Text(
          'Email',
          style: GoogleFonts.chakraPetch(
              textStyle: const TextStyle(
                  color: Color(0xFF8d94ac),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ),
        Material(
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.zero),
              errorText: _errorText.isNotEmpty ? _errorText : null,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.zero),
              filled: true,
              fillColor: Colors.white,
              hintText: "Nhập email của bạn",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: const Color(0xFF3278f6),
            ),
            controller: _controllerEmail,
            onSubmitted: (String value) {
              loginUsingEmailPassword(
                email: _controllerEmail.text,
                password: _controllerPass.text,
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'Mật khẩu',
          style: GoogleFonts.chakraPetch(
              textStyle: const TextStyle(
                  color: Color(0xFF8d94ac),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
        ),
        Material(
          child: TextField(
            obscureText: passwordVisible,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.zero,
              ),
              errorText: _errorText.isNotEmpty ? _errorText : null,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.zero),
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: "Nhập mật khẩu của bạn",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: const Color(0xFF3278f6),
            ),
            controller: _controllerPass,
            onSubmitted: (String value) {
              loginUsingEmailPassword(
                email: _controllerEmail.text,
                password: _controllerPass.text,
              );
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(vertical: 20)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF3278f6))),
                  onPressed: () {
                    loginUsingEmailPassword(
                      email: _controllerEmail.text,
                      password: _controllerPass.text,
                    );
                  },
                  child: const Text('Đăng nhập',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Khách hàng mới?',
              style: GoogleFonts.chakraPetch(
                  textStyle: const TextStyle(
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
                    widget.toRegister('register');
                  });
                },
                child: const Text(
                  'Tạo tài khoản',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3278f6)),
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quên mật khẩu?',
              style: GoogleFonts.chakraPetch(
                  textStyle: const TextStyle(
                      color: Color(0xFF8d94ac),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
            ),
            TextButton(
                style: ButtonStyle(overlayColor: TransparentButton()),
                onPressed: () {
                  setState(() {
                    widget.toRegister('forgetPass');
                  });
                },
                child: const Text(
                  'Đặt lại mật khẩu',
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
