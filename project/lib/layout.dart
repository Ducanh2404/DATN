import 'dart:async';
import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project/header/header_top.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
  @override
  Widget build(BuildContext context) {
    /// returning a container widget
    return Scaffold(
      body: Column(children: [
        //Header top
        HeaderTop(),
       
        //header mid
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
                )
              ],
            ),
          ),
        ),
        //Menu bar
        Container(
          decoration: const BoxDecoration(color: Color(0xFF29324e)),
          alignment: Alignment.center,
          child: const SizedBox(
              width: 1600,
              child: Row(
                children: [
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(width: 100.0),
                  Text(
                    'About',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(width: 100.0),
                  Text(
                    'Contact',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )),
        )
      ]),
    );
  }
}

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return StickyHeader(
        header: Container(
          height: 50.0,
          color: Colors.blueGrey[700],
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Text('Header #$index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        content: Container(
          child: Image.network(
            'https://ampet.vn/wp-content/uploads/2022/10/nuoi-cho-Corgi-6-1200x1200.jpg',
            fit: BoxFit.cover,
            width: 200.0, 
            height: 200.0,
          ),
        ),
      );
    });
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
