import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// a. creating StatefulWidget
class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);
  @override
  State createState() {
    return _AppLayoutState();
  }
}

/// b. Creating state for stateful widget
class _AppLayoutState extends State {
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
        'subject': 'Gửi mail tới ${email}',
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
    /// returning a container widget
    return Scaffold(
      body: Column(children: [
        Container(
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
            )),
        Container(
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
                    onTap: () {},
                    child: const Image(
                        image: AssetImage('img/logo.png'), width: 160)),
                const SearchBarApp(),
                Container(
                    child: Row(
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
                    TextButton.icon(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF3E4B75),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
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
                          decoration: BoxDecoration(color: Color(0xFFfb4e4e)),
                          child: const Text('1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ],
                )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

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
