import 'package:dinner_assistant_flutter/view/auth_screen.dart';
import 'package:dinner_assistant_flutter/view/bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // elimizde servis olmadığı için inital request atamadım ve manuel bir duration verdim
    Future.delayed(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) =>  AuthScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Lottie.asset(
        'assets/lottie/splash.json',
        fit: BoxFit.contain,
      ),
    );
  }
}
