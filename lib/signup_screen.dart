import 'package:flutter/material.dart';
import 'package:login_signup/auth_methods.dart';
import 'package:login_signup/size_config.dart';

const InputDecoration _inputDecoration = InputDecoration(
    hintText: 'Enter your email',
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(40))));

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Use text controllers maybe
  String email = "";
  String password = "";
  String name = "";
  String surname = "";

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
                    name = value;
                  },
                  decoration:
                      _inputDecoration.copyWith(hintText: 'Enter your name'),
                )),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(28),
                    vertical: getProportionateScreenHeight(20)),
                child: TextField(
                  onChanged: (value) {
                    surname = value;
                  },
                  decoration:
                      _inputDecoration.copyWith(hintText: 'Enter your surname'),
                )),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(28)),
                child: TextField(
                  onChanged: ((value) {
                    email = value;
                  }),
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
                  vertical: getProportionateScreenWidth(5)),
              child: ElevatedButton(
                onPressed: () async {
                  showCircularProgress(context);
                  String result = await AuthMethods().signUp(
                      email: email,
                      password: password,
                      name: name,
                      surname: surname);
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
                child: const Text('Register'),
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
