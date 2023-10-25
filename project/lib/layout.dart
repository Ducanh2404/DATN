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
    return Container(
/// c. Setting a background image for entire layout
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
/// d. Using Backdrop filter to blur the underlying image for the background
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
/// e. Creating the parent row
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
/// f. First Column for Left pane Section
            Container(
              width: 300,
              child: Column(),
              color: Colors.indigo.withOpacity(0.95),
            ),
/// g. Second column for Headers and Main Pane sections
            Expanded(
                child: Column(
                  children: [
/// h. Main Header section
                    Container(
                      height: 120,
                      color: Colors.indigo.withOpacity(0.80),
                      child: Row(),
                    ),
/// filter section
                    Container(
                      height: 120,
                      color: Colors.deepPurple.withOpacity(0.60),
                      child: Row(),
                    ),
/// i. Main Pane section
                    const Expanded(
                        child: Center(
                          child: Text("Hellooooo World"),
                        )
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}