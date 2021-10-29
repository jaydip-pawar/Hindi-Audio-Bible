import 'dart:io';
import 'dart:typed_data';

import 'package:bible/constants.dart';
import 'package:bible/screens/Book_Screen.dart';
import 'package:bible/widgets/Bottom_Ads.dart';
import 'package:bible/widgets/Rounded_Button.dart';
import 'package:bible/widgets/Side_Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomSheet: BottomAds(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "पवित्र बाइबिल",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: SideDrawer(),
      body: LoadingOverlay(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Banner')
                      .doc("Link")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/background.png",
                                ),
                                fit: BoxFit.cover)),
                      );
                    }

                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 100),
                        child: Container(
                          width: double.infinity,
                          height: height(context) * 0.3,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/background.png",
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          snapshot.data!["address"],
                                        ),
                                        fit: BoxFit.cover)),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: Icon(Icons.share_outlined,
                                        color: Colors.white),
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await name(snapshot).then((value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(height: 80),
                // RoundedButton(
                //   text: "पुराणा नियम",
                //   press: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => BookScreen(state: "Old")));
                //   },
                // ),
                RoundedButton(
                  text: "नया नियम",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BookScreen(state: "New")));
                  },
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Copyright © 2021 Seed Ministries"),
                      SizedBox(height: 65),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        isLoading: _isLoading,
        opacity: 0.5,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> name(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) async {
    var request =
        await HttpClient().getUrl(Uri.parse(snapshot.data!["address"]));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg',
        text:
            "Shared Via *Hindi Audio Bible App*:\nhttps://play.google.com/store/apps/details?id=com.hindiaudio.bible");
  }
}
