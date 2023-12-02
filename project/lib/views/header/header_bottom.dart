import 'package:project/all_imports.dart';

class HeaderBottom extends StatefulWidget {
  const HeaderBottom({super.key});

  @override
  State<HeaderBottom> createState() => _HeaderBottomState();
}

class _HeaderBottomState extends State<HeaderBottom> {
  OverlayEntry? overlayEntry;
  int currentPageIndex = 0;
  void createHighlightOverlay({
    required AlignmentDirectional alignment,
    required Color borderColor,
  }) {
    // Remove the existing OverlayEntry.
    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return SafeArea(
          child: Align(
            alignment: alignment,
            heightFactor: 1.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Tap here for'),
                  Builder(builder: (BuildContext context) {
                    switch (currentPageIndex) {
                      case 0:
                        return const Column(
                          children: <Widget>[
                            Text(
                              'Explore page',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.red,
                            ),
                          ],
                        );
                      case 1:
                        return const Column(
                          children: <Widget>[
                            Text(
                              'Commute page',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                            ),
                          ],
                        );
                      case 2:
                        return const Column(
                          children: <Widget>[
                            Text(
                              'Saved page',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.orange,
                            ),
                          ],
                        );
                      default:
                        return const Text('No page selected.');
                    }
                  }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 80.0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
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
                Stack(
                  children: [
                    Container(
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
                            setState(() {
                              currentPageIndex = 2;
                            });
                            createHighlightOverlay(
                              alignment: AlignmentDirectional.bottomEnd,
                              borderColor: Colors.orange,
                            );
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
                  ],
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
