import 'package:bible/dialog_box/rate_my_app.dart';
import 'package:bible/screens/About_Us_Screen.dart';
import 'package:bible/screens/Contact_Us_Screen.dart';
import 'package:bible/screens/Home_Screen.dart';
import 'package:bible/screens/Privacy_Policy_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String appLink = "https://play.google.com/store/apps/details?id=com.hindiaudio.bible";

    void rateUs(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => RateMyApp(),
      );
    }

    Future<void> share() async {
      await FlutterShare.share(
          title: 'Hindi Audio Bible',
          text: 'Hey,\n\nHindi Audio Bible is a fast and simple application to listen Bible in Hindi.\n\nGet it for free at $appLink',
          chooserTitle: 'Hindi Audio Bible');
    }

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/menu_bg.jpg"),
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Center(child: Text("HB")),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 180,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Hindi Audio Bible",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Text(
                        "www.seedministry.com",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 23, color: Colors.black54,),
            title: Text("Home", style: TextStyle(fontSize: 18),),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.star, size: 23, color: Colors.black54,),
            title: Text("Rate Us", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pop(context);
              rateUs(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.people_alt, size: 23, color: Colors.black54,),
            title: Text("About Us", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushNamed(context, AboutUs.id);
              },
          ),
          ListTile(
            leading: Icon(Icons.security, size: 23, color: Colors.black54,),
            title: Text("Privacy Policy", style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.pushNamed(context, PrivacyPolicy.id);
              },
          ),
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Communicate", style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black54,
            ),),
          ),
          ListTile(
            leading: Icon(Icons.share, size: 23, color: Colors.black54,),
            title: Text("Share App", style: TextStyle(fontSize: 16),),
            onTap: () => share(),
          ),
          ListTile(
            leading: Icon(Icons.quick_contacts_dialer, size: 23, color: Colors.black54,),
            title: Text("Contact Us", style: TextStyle(fontSize: 16),),
            onTap: () => Navigator.pushNamed(context, ContactUsScreen.id),
          ),
        ],
      ),
    );
  }
}
