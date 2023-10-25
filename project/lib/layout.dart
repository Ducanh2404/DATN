import 'dart:ui';
import 'package:flutter/material.dart';

/// a. creating StatefulWidget
class AppLayout extends StatefulWidget{
  const AppLayout({Key? key}) : super(key: key);
  @override
  State createState() {
    return _AppLayoutState() ;
  }
}
/// b. Creating state for stateful widget
class _AppLayoutState extends State{
  @override
  Widget build(BuildContext context) {
/// returning a container widget
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child:AppBar(
          backgroundColor: const Color(0xFF29324e),
          actions: <Widget>[
            Image(
            image: AssetImage('img/logo.png'),
            width: 160,
            height: 45,
          ),
          SearchBarApp()
          ],
          ),
        ),
    );
  }
}
class SearchBarApp extends StatefulWidget {
  const SearchBarApp({ Key? key }) : super(key: key);

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
          }, 
          suggestionsBuilder: (BuildContext context, SearchController controller) {
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