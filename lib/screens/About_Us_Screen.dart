import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String id = 'about-us-screen';
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "About Us",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Text(
                "The seed ministry has been carrying out various programs to nurture this generation and future generations in the knowledge of God's Word. We publish many applications in many languages, including Bible Quizzes, Audio Bibles, and Daily Devotion. We are publishing the English Audio Bible as a part of it. If you are blessed with this audio Bible, please share it with others."
                "\n\nPlease Contact Us\n\n"
                "seedministries1@gmail.com",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w800),
              ),
            )
          ],
        ),
      ),
    );
  }
}
