import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/size_config.dart';
// import google fonts

late User loggedInUser;

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key, required this.msg});
  final String msg;

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Homepage'), automaticallyImplyLeading: false),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.msg} ${loggedInUser.email}',
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: (() async {
                    await _auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(getProportionateScreenWidth(130),
                          getProportionateScreenHeight(50))),
                  child: const Text('Log out', textAlign: TextAlign.center))
            ],
          )),
        ));
  }
}
