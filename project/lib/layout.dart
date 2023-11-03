import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/screen/header/header_bottom.dart';
import 'package:project/screen/header/header_top.dart';
import 'package:project/screen/header/menu_bar.dart';

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
       
        //header Bottom
        HeaderBottom(),
        //Menu bar
        MenuItems(),
      ]),
    );
  }
}

