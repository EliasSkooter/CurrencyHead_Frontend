// ignore_for_file: prefer_const_constructors

import 'package:currency_head/view/screens/Currency/Currency.dart';
import 'package:currency_head/view/screens/Login/login.dart';
import 'package:currency_head/view/screens/Market/Market.dart';
import 'package:currency_head/view/screens/Settings/Settings.dart';
import 'package:currency_head/view/screens/SignUp/signup.dart';
import 'package:currency_head/view/screens/dashboard/dashboard.dart';
import 'package:currency_head/view/screens/homeScreen/homeScreen.dart';
import 'package:get/get.dart';

class Navigation {
  List<GetPage<dynamic>> routes = [
    GetPage(name: '/Home', page: () => HomeScreen()),
    GetPage(name: '/SignUp', page: () => SignUp()),
    GetPage(name: '/Login', page: () => LoginScreen()),
    GetPage(name: '/Dashboard', page: () => Dashboard()),
    GetPage(name: '/Currency', page: () => Currency()),
    GetPage(name: '/Market', page: () => Market()),
    GetPage(name: '/Settings', page: () => Settings()),
  ];
  List<GetPage<dynamic>> getNavigationList() {
    return routes;
  }
}
