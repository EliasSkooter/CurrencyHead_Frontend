// ignore_for_file: prefer_const_constructors, file_names

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
  dynamic tempVar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: 1.sw,
        height: 1.sh,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 1.sw / 4,
                // height: 1.sh,
                child: TextFormField(
                  initialValue: tempVar,
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBEBEBE))),
                  ),
                  onChanged: (value) {
                    setState(() {
                      tempVar = value;
                    });
                  },
                ),
              ),
              CustomButton(
                onTapCallBack: () {
                  Get.toNamed('/SignUp');
                },
                title: 'navigate to sign up',
              )
            ]),
      ),
    );
  }
}
