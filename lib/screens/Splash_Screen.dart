import 'dart:async';

import 'package:bible/constants.dart';
import 'package:bible/screens/Home_Screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  timer() {
    Timer(Duration(seconds: 5),
            () => Navigator.pushReplacementNamed(context, HomeScreen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height(context) * .25),
                  Container(
                    width: width(context) * 0.3,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: height(context) * .25),
                  Text(
                    "Seed Developers",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Copyright © 2021 Seed Ministries",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}