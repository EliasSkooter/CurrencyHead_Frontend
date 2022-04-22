import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:currency_head/view/widgets/Sidebar/SidebarMenu.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(handlerForManageContent: () {}),
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
