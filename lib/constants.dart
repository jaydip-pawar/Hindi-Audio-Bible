import 'package:bible/screens/About_Us_Screen.dart';
import 'package:bible/screens/Contact_Us_Screen.dart';
import 'package:bible/screens/Home_Screen.dart';
import 'package:bible/screens/Privacy_Policy_Screen.dart';
import 'package:bible/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';

const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);

final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Size size(BuildContext context) {
  return MediaQuery.of(context).size;
}

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.id : (context) => SplashScreen(),
  HomeScreen.id : (context) => HomeScreen(),
  AboutUs.id : (context) => AboutUs(),
  PrivacyPolicy.id : (context) => PrivacyPolicy(),
  ContactUsScreen.id : (context) => ContactUsScreen(),
};