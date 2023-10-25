import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Website Technologies',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home : Container(
          child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.pink,
      title: Text('Cua nàng Flutter'),
    ),
    body: buildColumn(),
  )));
  }
}
// extract ra hàm buildColumn ở đây
class buildColumn extends StatelessWidget {
const buildColumn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        image: DecorationImage(
          image: AssetImage('assets/img/logo.png'),
          fit:BoxFit.cover,
          )
      ),
    );
  }
}
