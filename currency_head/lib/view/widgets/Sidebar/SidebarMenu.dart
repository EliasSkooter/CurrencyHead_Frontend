import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// IMPORTANT NOTE!!!!
///
/// WHEN USING SIDEBAR MAKE SURE TO INCLUDE: handlerForManageContent: (useless) {},
///
/// Otherwise you will get a null error or an argument error!
class SideBar extends StatefulWidget {
  final dynamic controller;
  final Function handlerForManageContent;

  /// IMPORTANT NOTE!!!!
  ///
  /// WHEN USING SIDEBAR MAKE SURE TO INCLUDE: handlerForManageContent: (useless) {},
  ///
  /// Otherwise you will get a null error or an argument error!
  const SideBar({
    Key? key,
    required this.handlerForManageContent,
    this.controller,
  }) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int selectedIndex = 0;
  final LoginController _loginController = Get.put(LoginController());

  _onDestinationSelected(i) {
    setState(() {
      selectedIndex = i;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loginController.userInfo['username'] == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 1.sh),
              child: NavigationRail(
                backgroundColor: Colors.blue.shade800,
                extended: false,
                selectedIconTheme:
                    IconThemeData(color: Colors.grey[500], size: 20),
                groupAlignment:
                    -1, //this property is responsible for vertical aligment of rail items
                leading: Padding(
                  padding: EdgeInsets.only(top: 0.1.sh),
                  child: Text(
                      _loginController.userInfo['name'] +
                          ' ' +
                          _loginController.userInfo['surname'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )),
                ),
                onDestinationSelected: (index) {
                  // updating selected rail item onPress
                  _onDestinationSelected(index);
                },
                destinations: [
                  //Dashboard nav
                  NavigationRailDestination(
                    icon: IconButton(
                      onPressed: () {
                        Get.toNamed('/Login');
                      },
                      icon: const Icon(
                        Icons.dashboard_outlined,
                        color: Colors.white,
                      ),
                    ),
                    label: TextButton(
                      onPressed: () {
                        Get.toNamed('/Login');
                      },
                      child: const Text(
                        'HELLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLO',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  //Dashboard nav
                  NavigationRailDestination(
                    icon: IconButton(
                      onPressed: () {
                        Get.toNamed('/Login');
                      },
                      icon: const Icon(
                        Icons.dashboard_outlined,
                        color: Colors.white,
                      ),
                    ),
                    label: TextButton(
                      onPressed: () {
                        Get.toNamed('/Login');
                      },
                      child: const Text(
                        'desktopMenu.sidebar.dashboard',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
                selectedIndex: selectedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
