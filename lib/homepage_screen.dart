import 'package:flutter/material.dart';
import 'package:login_signup/auth_methods.dart';
import 'package:login_signup/size_config.dart';
import 'package:login_signup/user_model.dart';
// import google fonts

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key, required this.msg});
  final String msg;

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late UserModel? user;
  String name = "";

  Future<void> displayUserData() async {
    user = await AuthMethods().getCurrentUserData();
    name = user?.name ?? "Guest";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FutureBuilder(
        future: displayUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
          }
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                appBar: AppBar(
                    title: const Text('Homepage'),
                    automaticallyImplyLeading: false),
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.msg} $name',
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: (() async {
                          await AuthMethods().logOut();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacementNamed('/');
                          }
                        }),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(getProportionateScreenWidth(130),
                                getProportionateScreenHeight(50))),
                        child:
                            const Text('Log out', textAlign: TextAlign.center))
                  ],
                )),
              ));
        });
  }
}
