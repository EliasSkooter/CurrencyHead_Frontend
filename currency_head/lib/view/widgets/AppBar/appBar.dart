// ignore_for_file: file_names

import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/view/widgets/CurrencyHeadButton/CurrencyHeadLogo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _loginController.userInfo['username'] != null
          ? Icon(Icons.account_circle_rounded)
          : null,
      leadingWidth: 100,
      title: CurrencyHeadTitle(
        showText: true,
        height: 50,
      ),
      centerTitle: true,
    );
  }
}
