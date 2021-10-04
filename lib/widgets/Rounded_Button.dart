import 'package:bible/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final String text;
  final VoidCallback? press;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;

  RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.verticalPadding = 16,
    this.horizontalPadding = 30,
    this.fontSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        margin: EdgeInsets.only(bottom: 16, left: 30, right: 30),
        width: width(context) - 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 33,
              color: Color(0x6CBDBDBD).withOpacity(.84),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.red[500],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}