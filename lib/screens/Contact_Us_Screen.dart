import 'package:bible/constants.dart';
import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  static const String id = 'contact-us-screen';
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ContactUs(
        logoHeight: width(context) * 0.3,
        logoWidth: width(context) * 0.3,
        logo: 'assets/images/logo.png',
        email: 'seedministries1@gmail.com',
        companyName: 'Seed Ministries',
        // phoneNumber: '+91123456789',
        dividerThickness: 2,
        website: 'https://www.seedministry.com',
        // githubUserName: 'AbhishekDoshi26',
        // linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
        tagLine: 'Hindi Audio Bible',
        // twitterHandle: 'AbhishekDoshi26',
        cardColor: Colors.white,
        dividerColor: Colors.grey,
        companyColor: Colors.black,
        textColor: Colors.black,
        taglineColor: Colors.black54,
      ),
    );
  }
}
