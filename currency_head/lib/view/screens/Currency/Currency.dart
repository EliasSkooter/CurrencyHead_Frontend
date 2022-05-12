// ignore_for_file: prefer_const_constructors, file_names
import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:currency_head/view/widgets/Sidebar/SidebarMenu.dart';
import 'package:flutter/material.dart';

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(),
          const Expanded(
            child: Scaffold(
              appBar: CustomAppBar(),
              body: SingleChildScrollView(child: Text("hello")),
            ),
          )
        ],
      ),
    );
  }
}
