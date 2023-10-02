import 'package:flutter/material.dart';
import 'package:login_signup/auth_methods.dart';
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
                  showCircularProgress(context);
                  String result = await AuthMethods()
                      .signIn(email: email, password: password);
                  if (result == 'Ok') {
                    if (context.mounted) {
                      // Destroying the circular progress indicator
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/homepage_screen');
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(createSnackbar(result));
                    }
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
