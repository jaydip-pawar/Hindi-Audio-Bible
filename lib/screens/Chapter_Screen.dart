import 'package:bible/constants.dart';
import 'package:bible/providers/AudioProvider.dart';
import 'package:bible/widgets/Book_Info.dart';
import 'package:bible/widgets/Bottom_Ads.dart';
import 'package:bible/widgets/Player.dart';
import 'package:bible/widgets/Side_Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    Key? key,
    required this.name,
    required this.state,
    required this.index,
    required this.longDescription,
    required this.description,
  }) : super(key: key);

  final String name;
  final String state;
  final int index;
  final String longDescription;
  final String description;

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late Stream<QuerySnapshot> chapterStream;
  late InterstitialAd _interstitialAd;

  @override
  void didChangeDependencies() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));

    super.didChangeDependencies();
  }

  void _showInterstitialAd() {

    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();

      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
    );
    _interstitialAd.show();
  }

  playAudio(int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    final _audioProvider = Provider.of<AudioProvider>(context, listen: false);
    _audioProvider.snapshot = snapshot;
    if(index == _audioProvider.playingIndex) {
      if (_audioProvider.isPaused) {
        _audioProvider.setPause(false);
        _audioProvider.playAudio();
      } else {
        _audioProvider.setPause(true);
        _audioProvider.pauseAudio();
      }
    } else {
      _audioProvider.songName = snapshot.data!.docs[index].get("Name");
      _audioProvider.stopAudio();
      _audioProvider.isPlaying = true;
      _audioProvider.playingIndex = index;
      _audioProvider.isPaused = false;
      _audioProvider.setUrl(snapshot.data!.docs[index].get("SongLink"));
      _audioProvider.playAudio();
      _showInterstitialAd();
    }
  }

  @override
  void initState() {
    chapterStream = FirebaseFirestore.instance
        .collection(widget.state)
        .doc('Book${widget.index + 1}')
        .collection("Chapters")
        .orderBy('index', descending: false)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _audioProvider = Provider.of<AudioProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomSheet: _audioProvider.isPlaying
          ? Player()
          : Container(
        height: 0,
        width: 0,
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomAds(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: height(context) * .12,
                  left: width(context) * .1,
                  right: width(context) * .02),
              height: height(context) * .35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: BookInfo(
                size: size(context),
                name: widget.name,
                maxLines: 5,
                enableButton: false,
                description: widget.description,
                longDescription: widget.longDescription,
              )),
          Padding(
            padding: EdgeInsets.only(top: height(context) * .35, bottom: 40),
            child: StreamBuilder<QuerySnapshot>(
              stream: chapterStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print("Error found");
                  return CircularProgressIndicator();
                }

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  print("waiting");
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.size,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            onTap: () {
                              playAudio(index, snapshot);
                            },
                            child: Container(
                              height: 70,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              margin: EdgeInsets.only(
                                  bottom: 16, left: 20, right: 20),
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                            "${snapshot.data!.docs[index].get("Name")} \n",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: snapshot.data!.docs[index]
                                                .get("Description"),
                                            style: TextStyle(
                                                color: kLightBlackColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      _audioProvider.playingIndex == index
                                          ? _audioProvider.isPaused
                                          ? Icons.play_circle_outline_sharp
                                          : Icons.pause_circle_outline
                                          : Icons.play_circle_outline_sharp,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      playAudio(index, snapshot);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                    ),
                  );
                }

                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}
