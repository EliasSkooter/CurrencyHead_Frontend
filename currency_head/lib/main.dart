import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/view/screens/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'navigation/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Currency Head',
        theme: defaultTheme(context),
        home: Stack(children: [HomeScreen()]),
        getPages: Navigation().getNavigationList(),
      ),
    );
  }
}