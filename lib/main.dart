import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sleep_mind/config/di.dart';
import 'package:sleep_mind/config/firebase_options.dart';
import 'package:sleep_mind/features/authentication/presentation/screens/welcome_pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDI(); // 👈 MUY IMPORTANTE

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: Scaffold(body: WelcomePage()),
    );
  }
}
