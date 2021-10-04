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
        logo: AssetImage('assets/images/book2.png'),
        email: 'adoshi26.ad@gmail.com',
        companyName: 'Abhishek Doshi',
        phoneNumber: '+91123456789',
        dividerThickness: 2,
        website: 'https://abhishekdoshi.godaddysites.com',
        githubUserName: 'AbhishekDoshi26',
        linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
        tagLine: 'Flutter Developer',
        twitterHandle: 'AbhishekDoshi26',
        cardColor: Colors.white,
        dividerColor: Colors.grey,
        companyColor: Colors.black,
        textColor: Colors.black,
        taglineColor: Colors.black54,
      ),
    );
  }
}
