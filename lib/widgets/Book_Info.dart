import 'package:bible/constants.dart';
import 'package:bible/providers/AudioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookInfo extends StatelessWidget {

  const BookInfo({
    Key? key,
    required this.size,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.maxLines,
    required this.enableButton,
  }) : super(key: key);

  final Size size;
  final String name, description, longDescription;
  final int maxLines;
  final bool enableButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: this.size.height * .005),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: this.size.width * .4,
                            padding: EdgeInsets.only(top: this.size.height * .02),
                            child: Text(
                              longDescription,
                              maxLines: maxLines,
                              style: TextStyle(
                                fontSize: 10,
                                color: kLightBlackColor,
                              ),
                            ),
                          ),
                          enableButton ? Container(
                            margin: EdgeInsets.only(top: height(context) * .015),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () {
                                final audioProvider = Provider.of<AudioProvider>(context);
                                audioProvider.totalDuration = Duration(hours: 0, minutes: 2, seconds: 23);
                                audioProvider.position = Duration(hours: 0, minutes: 1, seconds: 12);
                              },
                              child: Text("Play", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[200], fontSize: 17),),
                            ),
                          ) : Container(),
                        ],
                      ),
                    ],
                  )
                ],
              )
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Image(
                  image: AssetImage("assets/images/book1.png"),
                  height: double.infinity,
                  alignment: Alignment.topRight,
                  fit: BoxFit.fitWidth,
                ),
              ),),
        ],
      ),
    );
  }
}