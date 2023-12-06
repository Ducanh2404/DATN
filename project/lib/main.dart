import 'package:project/all_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, child) => const MyApp(),
    ),
  );
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
          fontFamily: GoogleFonts.chakraPetch().fontFamily,
          colorSchemeSeed: Color(0xff3278f6),
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
      home: Scaffold(body: Home()),
    );
  }
}
