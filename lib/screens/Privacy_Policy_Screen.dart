import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String id = 'privacy-policy-screen';
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Privacy Policy"),
      ),
      body: Container(),
    );
  }
}
