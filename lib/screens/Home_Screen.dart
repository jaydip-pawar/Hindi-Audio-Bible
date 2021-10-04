import 'package:bible/screens/Book_Screen.dart';
import 'package:bible/widgets/Rounded_Button.dart';
import 'package:bible/widgets/Side_Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd myBanner;
  bool isBannerLoaded = false;

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                text: "Old Testament",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BookScreen(state: "Old")));
                },
              ),
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
    );
  }
}
