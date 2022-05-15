// ignore_for_file: prefer_const_constructors, file_names

import 'package:currency_head/services/loginService.dart';
import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/utils/validation.dart';
import 'package:currency_head/view/widgets/CircularFrame/CircularFrame.dart';
import 'package:currency_head/view/widgets/CurrencyHeadButton/CurrencyHeadButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "";
  String password = "";
  bool isPasswordCorrect = true;
  bool isLoading = false;
  bool isPasswordAccepted = true;
  bool isPasswordHidden = true;

  void loginFunct(username, password) async {
    print("hehe");
    login(username, password).then((res) {
      if (res) {
        print("login successful... redirecting to dashboard");
        Get.toNamed('/Dashboard');
      } else {
        print("login failed.");
        setState(() {
          isPasswordCorrect = false;
          isLoading = false;
        });
      }
    });
  }

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
              top: .1.sh,
              right: .1.sw,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              )),
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
              left: isMobileDevice() ? 1.sw / 2 : 1.sw / 2 - 40,
              top: 1.sh / 4,
              child: Text(
                "Login",
                style: presetTextThemes(context).headline1?.copyWith(
                    color: PRIMARY_COLOR,
                    fontFamily: 'HighTowerText',
                    fontSize: isMobileDevice() ? 26 : null),
              )),
          Positioned(
            left: isMobileDevice() ? -20 : 1.sw / 2,
            top: isMobileDevice() ? 1.sh / 2.5 : 1.sh / 2.5,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // invalid password control
                  if (!isPasswordCorrect)
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Incorrect email or password!",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    ),
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
                              hintText: "username",
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: isMobileDevice()
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password: ',
                            style: presetTextThemes(context)
                                .headline6
                                ?.copyWith(
                                    fontSize: 16, color: Colors.grey.shade800),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                            height: isMobileDevice() ? 50 : null,
                            child: TextFormField(
                              obscureText: isPasswordHidden,
                              initialValue: password,
                              cursorColor: Colors.black,
                              cursorWidth: 1,
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "password",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: isPasswordAccepted
                                        ? Color(0xFFBEBEBE)
                                        : Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  icon: isPasswordHidden
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.visibility_off_outlined),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                                if (isPasswordValid(value)) {
                                  setState(() {
                                    isPasswordAccepted = true;
                                  });
                                } else {
                                  setState(() {
                                    isPasswordAccepted = false;
                                  });
                                }
                              },
                              onFieldSubmitted: (val) {
                                setState(() {
                                  isLoading = true;
                                });
                                loginFunct(username, password);
                              },
                            ),
                          ),
                        ],
                      ),
                      // if (!isPasswordAccepted)
                      //   Container(
                      //     width: 350,
                      //     margin: EdgeInsets.only(bottom: 10, left: 100),
                      //     child: Text(
                      //       "Password must contain at least 8 characterd, 1 capital, 1 number, 1 special",
                      //       softWrap: true,
                      //       style: TextStyle(color: Colors.red, fontSize: 15),
                      //     ),
                      //   ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20, left: 70),
                        child: CurrencyHeadButton(
                          text: 'Login',
                          function: () {
                            setState(() {
                              isLoading = true;
                            });
                            // if (isPasswordAccepted) {
                            loginFunct(username, password);
                            // }
                          },
                          size: Size(350, 50),
                        ),
                      ),
                      //isLoading
                      if (isLoading)
                        Center(
                            child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF707070)),
                            strokeWidth: 2.5,
                          ),
                        ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextButton(
                      child: Text("Not a member yet? Register here!"),
                      onPressed: () {
                        Get.toNamed('/SignUp');
                      },
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
