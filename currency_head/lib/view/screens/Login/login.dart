// ignore_for_file: prefer_const_constructors, file_names

import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/view/widgets/CircularFrame/CircularFrame.dart';
import 'package:currency_head/view/widgets/CurrencyHeadButton/CurrencyHeadButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                imageSrc: isMobileDevice()
                    ? 'assets/images/login.png'
                    : 'images/login.png',
                size: 8000,
                borderColor: PRIMARY_COLOR,
              ),
            ),
          ),
          Positioned(
              left: isMobileDevice() ? 20 : 1.sw / 2 - 40,
              top: 1.sh / 4,
              child: Text(
                "Login",
                style: presetTextThemes(context).headline1?.copyWith(
                    color: PRIMARY_COLOR,
                    fontFamily: 'HighTowerText',
                    fontSize: isMobileDevice() ? 26 : null),
              )),
          Positioned(
            left: isMobileDevice() ? null : 1.sw / 2,
            top: isMobileDevice() ? 1.sh / 2.5 : 1.sh / 2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: isMobileDevice() ? 1.sw : null,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: isMobileDevice()
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Username: ',
                          style: presetTextThemes(context).headline6?.copyWith(
                              fontSize: 16, color: Colors.grey.shade800),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                          height: isMobileDevice() ? 50 : null,
                          child: TextFormField(
                            initialValue: username,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFBEBEBE)),
                                  borderRadius: BorderRadius.circular(10)),
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
                    mainAxisAlignment: isMobileDevice()
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Password: ',
                        style: presetTextThemes(context).headline6?.copyWith(
                            fontSize: 16, color: Colors.grey.shade800),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                        height: isMobileDevice() ? 50 : null,
                        child: TextFormField(
                          initialValue: password,
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFBEBEBE)),
                                borderRadius: BorderRadius.circular(10)),
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
                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: CustomButton(
                  //     color: Colors.red,
                  //     onTapCallBack: () {
                  //       Get.toNamed('/SignUp');
                  //     },
                  //     title: 'Sign in',
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CurrencyHeadButton(
                      text: 'Login',
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
