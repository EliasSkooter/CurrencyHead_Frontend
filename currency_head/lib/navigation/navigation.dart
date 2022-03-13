// ignore_for_file: prefer_const_constructors

import 'package:currency_head/view/screens/Login/login.dart';
import 'package:currency_head/view/screens/SignUp/signup.dart';
import 'package:currency_head/view/screens/homeScreen/homeScreen.dart';
import 'package:get/get.dart';

class Navigation {
  List<GetPage<dynamic>> routes = [
    GetPage(name: '/Home', page: () => HomeScreen()),
    GetPage(name: '/SignUp', page: () => SignUp()),
    GetPage(name: '/Login', page: () => LoginScreen())
  ];
  List<GetPage<dynamic>> getNavigationList() {
    return routes;
  }
}
