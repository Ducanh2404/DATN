import 'package:project/all_imports.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerPass;
  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerPass = TextEditingController();
  }

  @override
  void dispose() {
    _controllerName.dispose();
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
            margin: EdgeInsets.only(bottom: 24),
            child: Text('Thông Tin Tài Khoản',
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
              hintText: "",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
              focusColor: Color(0xFF3278f6),
            ),
            controller: _controllerPass,
            onSubmitted: (String value) {},
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
                  onPressed: () {},
                  child: Text('Cập nhật',
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
      ],
    );
  }
}
