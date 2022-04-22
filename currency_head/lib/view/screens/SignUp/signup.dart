import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/loginService.dart';
import '../../../utils/common.dart';
import '../../../utils/themes.dart';
import '../../widgets/CurrencyHeadButton/CurrencyHeadButton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  bool passwordMatches = false;
  bool isPasswordCorrect = true;
  bool isLoading = false;
  bool isPasswordAccepted = true;

  void registerFunc(firstname, lastname, email, password) async {
    register(firstname, lastname, email, password).then((res) {
      if (res) {
        print("Registartion successful... redirecting to dashboard");
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
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      'First name: ',
                      style: presetTextThemes(context)
                          .headline6
                          ?.copyWith(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                      height: isMobileDevice() ? 50 : null,
                      child: TextFormField(
                        initialValue: firstName,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFBEBEBE)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Last name: ',
                      style: presetTextThemes(context)
                          .headline6
                          ?.copyWith(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                      height: isMobileDevice() ? 50 : null,
                      child: TextFormField(
                        initialValue: lastName,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFBEBEBE)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      'Email: ',
                      style: presetTextThemes(context)
                          .headline6
                          ?.copyWith(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                      height: isMobileDevice() ? 50 : null,
                      child: TextFormField(
                        initialValue: email,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFBEBEBE)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Password: ',
                      style: presetTextThemes(context)
                          .headline6
                          ?.copyWith(fontSize: 16, color: Colors.grey.shade800),
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
                              borderSide: BorderSide(color: Color(0xFFBEBEBE)),
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
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Confirm Password: ',
                  style: presetTextThemes(context)
                      .headline6
                      ?.copyWith(fontSize: 16, color: Colors.grey.shade800),
                ),
                Container(
                  alignment: Alignment.center,
                  width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                  height: isMobileDevice() ? 50 : null,
                  child: TextFormField(
                    initialValue: confirmPassword,
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFBEBEBE)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20, left: 70),
                      child: CurrencyHeadButton(
                        text: 'Sign Up',
                        function: () {
                          setState(() {
                            isLoading = true;
                          });
                          // if (isPasswordAccepted) {
                          registerFunc(firstName, lastName, email, password);
                          // }
                        },
                        size: Size(350, 50),
                      ),
                    ),
                    // isLoading
                    if (isLoading)
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF707070)),
                          strokeWidth: 2.5,
                        ),
                      ))
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
