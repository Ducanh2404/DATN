import 'package:project/all_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Website Technologies',
      theme: ThemeData(
          searchViewTheme: SearchViewThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          searchBarTheme: SearchBarThemeData(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          fontFamily: GoogleFonts.chakraPetch().fontFamily,
          colorSchemeSeed: Color.fromARGB(255, 7, 7, 7),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: .1,
                  color: Color(0xFFcccccc),
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF3278f6)),
              borderRadius: BorderRadius.zero,
            ),
          )),
      home: Scaffold(drawer: DrawerWidget(), body: Home()),
    );
  }
}
