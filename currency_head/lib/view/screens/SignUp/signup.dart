import 'package:currency_head/utils/validation.dart';
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
  bool isLoading = false;

  bool firstNameBool = true;
  bool lastNameBool = true;
  bool emailValid = true;
  bool passwordBool = true;
  bool doPasswordsMatch = true;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  bool validateAllFields() {
    bool valid = true;

    if (firstName == '') {
      valid = false;
      setState(() {
        firstNameBool = false;
      });
    }

    if (lastName == '') {
      valid = false;
      setState(() {
        lastNameBool = false;
      });
    }

    if (!isEmailValid(email)) {
      valid = false;
      setState(() {
        emailValid = false;
      });
    }

    if (!isPasswordValid(password)) {
      valid = false;
      setState(() {
        passwordBool = false;
      });
    }

    if (password != confirmPassword) {
      valid = false;
      setState(() {
        doPasswordsMatch = false;
      });
    }

    return valid;
  }

  void registerFunc(firstname, lastname, email, password) async {
    register(
            firstName: firstname,
            lastName: lastname,
            email: email,
            password: password)
        .then((res) {
      if (res) {
        print("Registartion successful... redirecting to dashboard");
        Get.toNamed('/Dashboard');
      } else {
        print("login failed.");
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      print("failed to register... $onError");
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              width: 1.sw,
              alignment: Alignment.center,
              child: Text(
                "Register!",
                style: presetTextThemes(context)
                    .headline1!
                    .copyWith(color: PRIMARY_COLOR),
              ),
            ),
            Container(
              margin: isLargeScreen(context)
                  ? EdgeInsets.all(
                      50,
                    )
                  : EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
              width: isLargeScreen(context) ? 1.sw - 100 : 1.sw,
              child: Flex(
                direction:
                    isLargeScreen(context) ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: isLargeScreen(context)
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    margin: isLargeScreen(context)
                        ? null
                        : EdgeInsets.only(
                            bottom: 20,
                          ),
                    width: isLargeScreen(context) ? .45.sw : 1.sw,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'First name: ',
                            style: presetTextThemes(context)
                                .headline6
                                ?.copyWith(
                                    fontSize: 16, color: Colors.grey.shade800),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                          child: TextFormField(
                            initialValue: firstName,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBEBEBE),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText: !firstNameBool
                                  ? "This field is required."
                                  : null,
                              hintText: "First name",
                              suffixIcon: Icon(
                                Icons.person_add_alt,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                firstName = value;
                              });
                              if (value == '') {
                                setState(() {
                                  firstNameBool = false;
                                });
                              } else {
                                setState(() {
                                  firstNameBool = true;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: isLargeScreen(context)
                        ? null
                        : EdgeInsets.only(
                            bottom: 20,
                          ),
                    width: isLargeScreen(context) ? .45.sw : 1.sw,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Last name: ',
                            style:
                                presetTextThemes(context).headline6?.copyWith(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                    ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                          child: TextFormField(
                            initialValue: lastName,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBEBEBE),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText: !lastNameBool
                                  ? "This field is required."
                                  : null,
                              hintText: "Last name",
                              suffixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                lastName = value;
                              });
                              if (value == '') {
                                setState(() {
                                  lastNameBool = false;
                                });
                              } else {
                                setState(() {
                                  lastNameBool = true;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: isLargeScreen(context)
                  ? EdgeInsets.all(
                      50,
                    )
                  : EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
              width: isLargeScreen(context) ? 1.sw - 100 : 1.sw,
              child: Flex(
                direction:
                    isLargeScreen(context) ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: isLargeScreen(context)
                        ? null
                        : EdgeInsets.only(
                            bottom: 20,
                          ),
                    width: isLargeScreen(context) ? .45.sw : 1.sw,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Email: ',
                            style: presetTextThemes(context)
                                .headline6
                                ?.copyWith(
                                    fontSize: 16, color: Colors.grey.shade800),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                          child: TextFormField(
                            initialValue: email,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBEBEBE),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText: !emailValid ? "Invalid email!" : null,
                              hintText: "Email",
                              suffixIcon: Icon(Icons.email),
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                              if (!isEmailValid(value)) {
                                setState(() {
                                  emailValid = false;
                                });
                              } else {
                                setState(() {
                                  emailValid = true;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: isLargeScreen(context)
                        ? null
                        : EdgeInsets.only(
                            bottom: 20,
                          ),
                    width: isLargeScreen(context) ? .45.sw : 1.sw,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Password: ',
                            style:
                                presetTextThemes(context).headline6?.copyWith(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                    ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                          child: TextFormField(
                            obscureText: isPasswordHidden,
                            initialValue: password,
                            cursorColor: Colors.black,
                            cursorWidth: 1,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFBEBEBE),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorText: !passwordBool
                                  ? "password must contain at least 8 characters, 1 special character, 1 number, 1 lower case letter!"
                                  : null,
                              errorStyle: TextStyle(
                                overflow: TextOverflow.visible,
                              ),
                              hintText: "Password",
                              suffixIcon: IconButton(
                                icon: isPasswordHidden
                                    ? Icon(
                                        Icons.remove_red_eye,
                                      )
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                      ),
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
                              if (!isPasswordValid(value)) {
                                setState(() {
                                  passwordBool = false;
                                });
                              } else {
                                setState(() {
                                  passwordBool = true;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: isLargeScreen(context)
                  ? EdgeInsets.all(
                      50,
                    )
                  : EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 30,
                    ),
              width: isLargeScreen(context) ? 1.sw - 100 : 1.sw,
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Confirm Password: ',
                      style: presetTextThemes(context)
                          .headline6
                          ?.copyWith(fontSize: 16, color: Colors.grey.shade800),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                    child: TextFormField(
                      obscureText: isConfirmPasswordHidden,
                      initialValue: confirmPassword,
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFBEBEBE),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorText: !doPasswordsMatch
                            ? "passwords do not match!"
                            : null,
                        hintText: "confirm password",
                        suffixIcon: IconButton(
                          icon: isConfirmPasswordHidden
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordHidden =
                                  !isConfirmPasswordHidden;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                        if (password != confirmPassword) {
                          setState(() {
                            doPasswordsMatch = false;
                          });
                        } else {
                          doPasswordsMatch = true;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1.sw,
              alignment: Alignment.center,
              child: Flex(
                direction:
                    isLargeScreen(context) ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CurrencyHeadButton(
                    text: 'Sign Up',
                    function: () {
                      setState(() {
                        isLoading = true;
                      });
                      if (validateAllFields()) {
                        registerFunc(firstName, lastName, email, password);
                      } else {
                        isLoading = false;
                      }
                    },
                    size: Size(350, 50),
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
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
