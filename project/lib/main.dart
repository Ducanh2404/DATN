import 'package:project/all_imports.dart';

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
        fontFamily: GoogleFonts.chakraPetch().fontFamily,
        colorSchemeSeed: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: WebLayout()
        ),
    );
  }
}