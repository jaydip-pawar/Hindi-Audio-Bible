import 'package:bible/constants.dart';
import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  final String name;
  final double size;
  final String description;
  final VoidCallback? press;
  final IconData icon;
  final bool imageRequired;

  const ChapterCard({
    Key? key,
    required this.name,
    required this.size,
    required this.description,
    required this.press,
    required this.icon,
    required this.imageRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      margin: EdgeInsets.only(bottom: 16, left: 20, right: 20),
      width: width(context) - 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          imageRequired ? Container(
            width: 45,
            height: 45,
            child: Image(
              image: AssetImage("assets/images/book2.png"),
            ),
          ) : Container(),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$name \n",
                    style: TextStyle(
                      fontSize: 16,
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: TextStyle(color: kLightBlackColor),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              icon,
              size: size,
            ),
            onPressed: press
          )
        ],
      ),
    );
  }
}