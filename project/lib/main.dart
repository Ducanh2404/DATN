import 'package:project/all_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechShop',
      theme: ThemeData(
          searchViewTheme: const SearchViewThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          searchBarTheme: SearchBarThemeData(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          fontFamily: GoogleFonts.chakraPetch().fontFamily,
          colorSchemeSeed: const Color.fromARGB(255, 7, 7, 7),
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
      home: const Scaffold(drawer: DrawerWidget(), body: Home()),
    );
  }
}
