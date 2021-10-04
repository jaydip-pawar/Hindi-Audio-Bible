import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class RateMyApp extends StatefulWidget {
  @override
  _RateMyAppState createState() => _RateMyAppState();
}

class _RateMyAppState extends State<RateMyApp> {

  var star = [false, false, false, false, false];
  int rating = 0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController suggestionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    void checkStars(int index) {
      for (int i = 0; i <= index; i++) {
        setState(() {
          star[i] = true;
        });
      }
      for (int i = 4; i > index; i--) {
        setState(() {
          star[i] = false;
        });
      }
    }

    void sendSuggestion() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
      FirebaseFirestore.instance
      .collection("RateSuggestions")
      .add({
        "email" : emailController.text,
        "suggestions" : suggestionController.text
      });
      Navigator.pop(context);
    }

    Widget lowRating() {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Do you have any suggestions for how we can improve Hindi Audio Bible?",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle:
                TextStyle(fontSize: 14, color: Colors.grey.shade400),
              ),
              validator: (email) {
                if (email!.isEmpty)
                  return 'Please Enter email ID';
                else if (!EmailValidator.validate(email))
                  return 'Enter valid email address';
                else
                  return null;
              },
              textInputAction: TextInputAction.next,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: suggestionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Suggestion",
                labelStyle:
                TextStyle(fontSize: 14, color: Colors.grey.shade400),
              ),
              validator: (suggestion) {
                if (suggestion!.isEmpty)
                  return 'Please Enter something';
                else
                  return null;
              },
              textInputAction: TextInputAction.done,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    sendSuggestion();
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    Widget fullRating() {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Thank you for your rating. Please share your good experience by giving us the same nice rating in the Google Play Store.",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  LaunchReview.launch().then((value) => Navigator.pop(context));
                },
                child: Text(
                  "GO TO GOOGLE PLAY",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      );
    }


    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: SingleChildScrollView(
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
              elevation: 15,
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                        child: Text(
                          "Please rate our app",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 15.0, right: 10.0, bottom: 15.0),
                        child: Text(
                          "We hope you like using Hindi Audio Bible. To help us improve the app, as well as your experience, please take a second to rate it and let us know what you think.",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                star[0] == true ? Icons.star : Icons.star_border,
                                color: Colors.orange.shade400,
                              ),
                              iconSize: width * 0.120,
                              onPressed: () {
                                setState(() {
                                  rating = 1;
                                });
                                checkStars(0);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                star[1] == true ? Icons.star : Icons.star_border,
                                color: Colors.orange.shade400,
                              ),
                              iconSize: width * 0.120,
                              onPressed: () {
                                setState(() {
                                  rating = 2;
                                });
                                checkStars(1);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                star[2] == true ? Icons.star : Icons.star_border,
                                color: Colors.orange.shade400,
                              ),
                              iconSize: width * 0.120,
                              onPressed: () {
                                setState(() {
                                  rating = 3;
                                });
                                checkStars(2);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                star[3] == true ? Icons.star : Icons.star_border,
                                color: Colors.orange.shade400,
                              ),
                              iconSize: width * 0.120,
                              onPressed: () {
                                setState(() {
                                  rating = 4;
                                });
                                checkStars(3);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                star[4] == true ? Icons.star : Icons.star_border,
                                color: Colors.orange.shade400,
                              ),
                              iconSize: width * 0.120,
                              onPressed: () {
                                setState(() {
                                  rating = 5;
                                });
                                checkStars(4);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (rating == 0)
                        Container(
                          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      if (rating != 0 && rating <= 4) lowRating(),
                      if (rating == 5) fullRating()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}