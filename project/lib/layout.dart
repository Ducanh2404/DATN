import 'dart:ui';
import 'package:flutter/material.dart';

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
    return Container(
      child: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: const BoxDecoration(
            color: Color(0xFF3278f6),
          ),
          child: Container(
            constraints: BoxConstraints.tightForFinite(height: 20,),
            child: Row(crossAxisAlignment:CrossAxisAlignment.end,children: [
              Container(
              width: 1600,
              child:Icon(
                Icons.call,
                size: 20.0,
                color: Colors.white,
              ),
              ),
            ],
          ),)
        ),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFF29324e),
          ),
          child: Row(
            children: [
              Image(image: AssetImage('img/logo.png'), width: 160),
            ],
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
