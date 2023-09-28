import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_signup/homepage_screen.dart';
import 'package:login_signup/login_screen.dart';
import 'package:login_signup/signup_screen.dart';
import 'package:login_signup/welcome_screen.dart';
import 'firebase_options.dart';

final ButtonStyle _buttonStyle = ButtonStyle(
    elevation: const MaterialStatePropertyAll(15),
    shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(45)))),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.blue;
      }
      return Colors.blueAccent;
    }),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.black;
      }
      return Colors.white;
    }));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Log in Sign up',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(style: _buttonStyle)),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/homepage_screen': (context) => const HomepageScreen(msg: 'Welcome'),
        '/login_screen': (context) => const LoginScreen(),
        '/signup_screen': (context) => const SignupScreen()
      },
    );
  }
}
