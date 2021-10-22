import 'package:bible/constants.dart';
import 'package:bible/screens/Chapter_Screen.dart';
import 'package:bible/widgets/Book_Info.dart';
import 'package:bible/widgets/Chapter_Card.dart';
import 'package:bible/widgets/Side_Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final String state;

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomSheet: isBannerLoaded ? Container(
        color: Colors.transparent,
        height: myBanner.size.height.toDouble(),
        child: AdWidget(
          ad: myBanner,
        ),
      ) : SizedBox(),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: height(context) * .12,
                        left: width(context) * .1,
                        right: width(context) * .02),
                    height: height(context) * .48,
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('BookDetails')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {

                        if (snapshot.hasData) {
                          return BookInfo(
                            size: size(context),
                            name: "Bible",
                            description: snapshot.data!.docs[widget.state == "New" ? 1 : 0].get("Description"),
                            maxLines: 10,
                            enableButton: false,
                            longDescription: snapshot.data!.docs[widget.state == "New" ? 1 : 0].get("LongDescription"),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),),
                Padding(
                  padding: EdgeInsets.only(top: height(context) * .32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('${widget.state}Books')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error found");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.size,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) => ChapterCard(
                                index: index,
                                state: widget.state,
                                longDescription: snapshot.data!.docs[index].get("LongDescription"),
                                imageRequired: true,
                                size: 15,
                                name: snapshot.data!.docs[index].get("Name"),
                                description: snapshot.data!.docs[index].get("Description"),
                                icon: Icons.arrow_forward_ios,
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChapterScreen(
                                          name: snapshot.data!.docs[index].get("Name"),
                                          index: index,
                                          state: widget.state,
                                          longDescription: snapshot.data!.docs[index].get("LongDescription"),
                                          description: snapshot.data!.docs[index].get("Description"),),
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          return CircularProgressIndicator();
                        },
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
