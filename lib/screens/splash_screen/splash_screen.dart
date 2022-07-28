import 'dart:async';

import 'package:bukit_vista_flutter_assesment/screens/user/dashboard.dart';
import 'package:bukit_vista_flutter_assesment/screens/user/homeUser.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashFuturePage extends StatefulWidget {
  const SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  Future<Widget> futureCall() async {
    await Future.delayed(Duration(seconds: 3), () {
      print(" This line is execute after 3 seconds");
    });
    return HomeUser();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/images/logo.png',
      ),
      logoSize: 90,
      backgroundColor: Colors.white,
      showLoader: true,
      loaderColor: const Color(0xff3B9DF6),
      futureNavigator: futureCall(),
    );
  }
}
