import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomAds extends StatefulWidget {
  const BottomAds({Key? key}) : super(key: key);

  @override
  _BottomAdsState createState() => _BottomAdsState();
}

class _BottomAdsState extends State<BottomAds> {

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
    return isBannerLoaded ? Container(
      color: Colors.transparent,
      height: myBanner.size.height.toDouble(),
      child: AdWidget(
        ad: myBanner,
      ),
    ) : SizedBox();
  }
}
