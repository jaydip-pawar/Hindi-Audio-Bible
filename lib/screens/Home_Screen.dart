import 'dart:io';
import 'dart:typed_data';

import 'package:bible/constants.dart';
import 'package:bible/screens/Book_Screen.dart';
import 'package:bible/widgets/Rounded_Button.dart';
import 'package:bible/widgets/Side_Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd myBanner;
  bool isBannerLoaded = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
        print("Error: $error");
        ad.dispose();
      }, onAdLoaded: (ad) {
        setState(() {
          isBannerLoaded = true;
        });
        print("Banner Loaded");
      },
      ),
    );
    myBanner.load();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomSheet: isBannerLoaded ? Container(
        color: Colors.transparent,
        height: myBanner.size.height.toDouble(),
        child: AdWidget(
          ad: myBanner,
        ),
      ) : SizedBox(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 100),
                        child: Container(
                          width: double.infinity,
                          height: height(context) * 0.3,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!["address"],
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(Icons.share_outlined, color: Colors.white),
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
                        ),
                      );
                    }

                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(height: 40),
                // RoundedButton(
                //   text: "Old Testament",
                //   press: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => BookScreen(state: "Old")));
                //   },
                // ),
                RoundedButton(
                  text: "New Testament",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BookScreen(state: "New")));
                  },
                ),
              ],
            ),
          ),
        ),
        isLoading: _isLoading,
        opacity: 0.5,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }

  Future<void> name(AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) async {
    var request = await HttpClient().getUrl(Uri.parse(snapshot.data!["address"]));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg', text: "Shared Via *Hindi Audio Bible App*:\nhttps://play.google.com/store/apps/details?id=com.hindiaudio.bible");
  }
}
