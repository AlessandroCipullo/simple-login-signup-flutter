import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/homepage_screen.dart';
import 'package:login_signup/size_config.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    // Move it outside of the build fun
    SizeConfig().init(context);

    if (_auth.currentUser != null) {
      return const HomepageScreen(msg: 'Welcome back');
    }
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(getProportionateScreenWidth(320),
                    getProportionateScreenHeight(80))),
            onPressed: (() => Navigator.pushNamed(context, '/login_screen')),
            child: const Text(
              'Login',
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(30)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: Size(getProportionateScreenWidth(320),
                        getProportionateScreenHeight(80))),
                onPressed: (() =>
                    Navigator.pushNamed(context, '/signup_screen')),
                child: const Text(
                  'Signup',
                  textAlign: TextAlign.center,
                )))
      ],
    )));
  }
}
