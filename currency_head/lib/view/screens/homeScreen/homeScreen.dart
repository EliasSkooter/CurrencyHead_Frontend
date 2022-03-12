// ignore_for_file: prefer_const_constructors, file_names

import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/view/widgets/CircularFrame/CircularFrame.dart';
import 'package:currency_head/view/widgets/CurrencyHeadButton/CurrencyHeadButton.dart';
import 'package:currency_head/view/widgets/CustomButton/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic username;
  dynamic password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -.1.sw,
            left: -.2.sw,
            child: Container(
              height: .58.sw,
              width: .58.sw,
              padding: EdgeInsets.all(20),
              child: CircularFrame.imageAsset(
                imageSrc: 'images/login.png',
                size: 8000,
                borderColor: PRIMARY_COLOR,
              ),
            ),
          ),
          Positioned(
              left: 1.sw / 2 - 40,
              top: 1.sh / 6,
              child: Text(
                "Welcome to Currency Head!",
                style: presetTextThemes(context).headline1?.copyWith(
                    color: PRIMARY_COLOR, fontFamily: 'HighTowerText'),
              )),
          Positioned(
            left: 1.sw / 2,
            top: 1.sh / 2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Username: ',
                          style: presetTextThemes(context).headline6?.copyWith(
                              fontSize: 16, color: Colors.grey.shade800),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 1.sw / 4,
                          // height: 1.sh,
                          child: TextFormField(
                            initialValue: username,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFBEBEBE))),
                            ),
                            onChanged: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password: ',
                        style: presetTextThemes(context).headline6?.copyWith(
                            fontSize: 16, color: Colors.grey.shade800),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 1.sw / 4,
                        // height: 1.sh,
                        child: TextFormField(
                          initialValue: password,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFBEBEBE))),
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CustomButton(
                      color: Colors.red,
                      onTapCallBack: () {
                        Get.toNamed('/SignUp');
                      },
                      title: 'Sign in',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CurrencyHeadButton(
                      function: () {
                        print("object");
                      },
                      size: Size(250, 50),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
