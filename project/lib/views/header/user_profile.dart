import 'package:project/all_imports.dart';

class UserProfile extends StatefulWidget {
  final Function(String) updateLoginStatus;
  final Function(String) toLogin;

  const UserProfile(
      {super.key, required this.updateLoginStatus, required this.toLogin});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerEmail;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    _controllerName = TextEditingController();
    _controllerEmail = TextEditingController();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  Future<void> updateUserInformation(String newName) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(newName);
        await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: user.email)
            .get()
            .then(
          (QuerySnapshot query) {
            query.docs.forEach((doc) {
              doc.reference.update({
                'name': newName,
              });
            });
          },
        );

        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Cập nhật thông tin thành công'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          widget.updateLoginStatus(newName);
        });
      }
    } catch (e) {
      print(' $e');
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.reload();
        user = auth.currentUser;
        setState(() {
          _controllerName.text = user!.displayName ?? '';
          _controllerEmail.text = user.email ?? '';
        });
      }
    } catch (e) {
      print(' $e');
    }
  }

  Future<void> signOut() async {
    try {
      auth.signOut();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          ));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Đăng xuất thành công'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      widget.updateLoginStatus('');
      widget.toLogin('login');
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 24),
            child: Text('Thông Tin Tài Khoản',
                style: GoogleFonts.chakraPetch(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ))),
        Text(
          'Họ và tên',
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
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.zero),
              filled: true,
              fillColor: Colors.white,
              hintText: "",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerName,
            onSubmitted: (String value) {},
          ),
        ),
        const SizedBox(
          height: 12,
        ),
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
            readOnly: true,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.zero),
              filled: true,
              fillColor: Colors.white,
              hintText: "",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerEmail,
            onSubmitted: (String value) {},
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
                    updateUserInformation(_controllerName.text);
                  },
                  child: const Text('Cập nhật',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
            ),
          ],
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomerOrder()));
                  },
                  child: const Text('Đơn hàng',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))),
            )
          ],
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                  onPressed: () {
                    signOut();
                  },
                  child: const Text('Đăng Xuất',
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
      ],
    );
  }
}
