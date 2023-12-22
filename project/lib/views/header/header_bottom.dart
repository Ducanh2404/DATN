import 'package:project/all_imports.dart';
import 'package:project/views/admin/main.dart';

class HeaderBottom extends StatefulWidget {
  const HeaderBottom({super.key});

  @override
  State<HeaderBottom> createState() => _HeaderBottomState();
}

class _HeaderBottomState extends State<HeaderBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: const BoxDecoration(
        color: Color(0xFF29324e),
      ),
      child: SizedBox(
        width: 1600,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Admin()));
                  });
                },
                child:
                    const Image(image: AssetImage('img/logo.png'), width: 160)),
            Expanded(child: SearchBarApp()),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ))),
                  child: Account(),
                ),
                IconButton(
                  style: ButtonStyle(
                    overlayColor: TransparentButton(),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF3E4B75)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cart(),
                            ));
                      } else if (user == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Vui lòng đăng nhập để xem giỏ hàng'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      ;
                    });
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 20.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? username = user.displayName;
      updateLoginState(username!);
      form = UserProfile(
        updateLoginStatus: updateLoginState,
        toLogin: toPage,
      );
    } else if (user == null) {
      updateLoginState('');
    }
  }

  late Widget form = Login(
    toRegister: toPage,
    updateLoginStatus: updateLoginState,
    toProfile: toPage,
  );
  final layerLink = LayerLink();
  late String userName = '';
  void updateLoginState(String name) {
    setState(() {
      userName = name;
    });
  }

  toPage(String text) {
    if (text == "profile") {
      setState(() {
        form = UserProfile(
          updateLoginStatus: updateLoginState,
          toLogin: toPage,
        );
        hideOverlay();
        showOverlay();
      });
    }
    if (text == "register") {
      setState(() {
        form = Register(
          toLogin: toPage,
        );
        hideOverlay();
        showOverlay();
      });
    }
    if (text == "login") {
      setState(() {
        form = Login(
          toRegister: toPage,
          toProfile: toPage,
          updateLoginStatus: updateLoginState,
        );
        hideOverlay();
        showOverlay();
      });
    }
    if (text == "forgetPass") {
      setState(() {
        form = ForgetPass(toLogin: toPage);
        hideOverlay();
        showOverlay();
      });
    }
  }

  Widget buildOverlay() => Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  style: ButtonStyle(
                    overlayColor: TransparentButton(),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(0.0)),
                  ),
                  onPressed: () {
                    setState(() {
                      hideOverlay();
                    });
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.xmark,
                    size: 20,
                  )),
            ),
            form,
          ],
        ),
      );
  OverlayEntry? entry;
  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: 340,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(-size.width, size.height * 2),
            child: buildOverlay(),
          )),
    );
    overlay.insert(entry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextButton.icon(
          style: ButtonStyle(overlayColor: TransparentButton()),
          onPressed: () {
            setState(() {
              if (entry == null) {
                showOverlay();
              }
            });
          },
          icon: const Icon(
            Icons.person_outline,
            color: Colors.white,
            size: 20.0,
          ),
          label: Text(userName.isNotEmpty ? userName : "Tài Khoản",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }
}
