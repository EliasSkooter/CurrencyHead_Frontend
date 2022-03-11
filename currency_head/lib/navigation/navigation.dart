import 'package:currency_head/view/screens/SignUp/signup.dart';
import 'package:currency_head/view/screens/homeScreen/homeScreen.dart';
import 'package:get/get.dart';

class Navigation {
  List<GetPage<dynamic>> routes = [
    GetPage(name: '/Home', page: () => HomeScreen()),
    GetPage(name: '/SignUp', page: () => SignUp())
  ];
  List<GetPage<dynamic>> getNavigationList() {
    return routes;
  }
}
