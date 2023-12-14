import 'package:project/all_imports.dart';

class HeaderBottom extends StatefulWidget {
  const HeaderBottom({super.key});

  @override
  State<HeaderBottom> createState() => _HeaderBottomState();
}

class _HeaderBottomState extends State<HeaderBottom> {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  });
                },
                child:
                    const Image(image: AssetImage('img/logo.png'), width: 160)),
            const Expanded(child: SearchBarApp()),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
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

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      }),
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
