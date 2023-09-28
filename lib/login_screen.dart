import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/size_config.dart';

// Write it once
const InputDecoration _inputDecoration = InputDecoration(
    hintText: 'Enter your email',
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(40))));

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  // Use text controllers maybe
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(28)),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration,
                )),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(28),
                    vertical: getProportionateScreenHeight(20)),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: _inputDecoration.copyWith(
                      hintText: 'Enter your password'),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(28),
                  vertical: getProportionateScreenWidth(32)),
              child: ElevatedButton(
                onPressed: () async {
                  if (email != "" && password != "") {
                    try {
                      showCircularProgress(context);
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        // Destroying the circular progress indicator
                        // if(context.mounted){Navigator pop} ?
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/homepage_screen');
                      }
                    } catch (e) {
                      Navigator.of(context).pop();
                      // Remove firebase auth exception's codes from the string
                      String alert =
                          e.toString().replaceAll(RegExp(r'\[.*?\]'), '');
                      if (alert.contains('An internal error has occurred.')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            createSnackbar(
                                'The email or password is incorrect'));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(createSnackbar(alert));
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        createSnackbar('All fields are required.'));
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(getProportionateScreenWidth(320),
                        getProportionateScreenHeight(80))),
                child: const Text('Log in'),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Write it once
  SnackBar createSnackbar(String msg) {
    return SnackBar(
        content: Text(msg, textAlign: TextAlign.center),
        //backgroundColor: Colors.lightBlue,
        //shape: const StadiumBorder(),
        duration: const Duration(seconds: 3));
  }

  // Write it once
  Future<void> showCircularProgress(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }));
  }
}
