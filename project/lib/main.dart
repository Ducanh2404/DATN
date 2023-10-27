import 'package:flutter/material.dart';
import 'package:project/layout.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Website Technologies',
      theme: ThemeData(
        fontFamily: GoogleFonts.chakraPetch().fontFamily,
        colorSchemeSeed: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: AppLayout()
        ),
    );
  }
}

// // extract ra hàm buildColumn ở đây
// class buildColumn extends StatelessWidget {
//   const buildColumn({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           color: Colors.blueAccent,
//           image: DecorationImage(
//             image: AssetImage('assets/img/logo.png'),
//             fit: BoxFit.cover,
//           )),
//     );
//   }
// }
