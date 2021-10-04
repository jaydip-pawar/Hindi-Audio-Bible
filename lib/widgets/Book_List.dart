import 'package:bible/constants.dart';
import 'package:bible/screens/Chapter_Screen.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  const BookList({
    Key? key,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.index,
    required this.state,
  }) : super(key: key);

  final String name;
  final String description;
  final String longDescription;
  final String state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Container(
          width: width(context),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    child: Image(
                      image: AssetImage("assets/images/book2.png"),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextButton(
                  onPressed: () {
                    print("index = $index");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChapterScreen(
                          name: name,
                          state: state,
                          index: index,
                          longDescription: longDescription,
                          description: description,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Open",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
