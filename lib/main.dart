import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:sleep_mind/auth/screen/google_login_screen.dart';

import 'package:sleep_mind/firebase_options.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255)
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
        )
      ),
      home:  Scaffold(body: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.jpeg'), fit: BoxFit.cover)),),),
    );
  }
}
