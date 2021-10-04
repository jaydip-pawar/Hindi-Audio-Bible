import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String id = 'about-us-screen';
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("About Us"),
      ),
      body: Container(),
    );
  }
}
