import 'package:project/all_imports.dart';

class HeaderBottom extends StatefulWidget {
  const HeaderBottom({super.key});

  @override
  State<HeaderBottom> createState() => _HeaderBottomState();
}

class _HeaderBottomState extends State<HeaderBottom> {
  final layerLink = LayerLink();
  Widget buildOverlay() =>
      Container(height: 200, width: 200, color: Colors.red);
  OverlayEntry? entry;
  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  void showOverlay() {
    final overlay = Overlay.of(context)!;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 8),
            child: buildOverlay(),
          )),
    );
    overlay.insert(entry!);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => showOverlay());
  }

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
            const SearchBarApp(),
            Row(
              children: [
                CompositedTransformTarget(
                  link: layerLink,
                  child: Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ))),
                    child: TextButton.icon(
                        style: ButtonStyle(overlayColor: TransparentButton()),
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        label: const Text('Tài khoản',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                TextButton.icon(
                    style: ButtonStyle(
                      overlayColor: TransparentButton(),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF3E4B75)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.zero, // Set border radius to zero
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    label: Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Color(0xFFfb4e4e)),
                      child: const Text('1',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
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
