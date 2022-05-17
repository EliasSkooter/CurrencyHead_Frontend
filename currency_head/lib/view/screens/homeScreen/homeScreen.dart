// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace

import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:currency_head/view/widgets/CurrencyHeadButton/CurrencyHeadButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                "Welcome to CurrencyHead!",
                textAlign: TextAlign.center,
                style: presetTextThemes(context)
                    .headline1
                    ?.copyWith(color: PRIMARY_COLOR),
              ),
              Container(
                margin: EdgeInsets.only(top: .1.sh, bottom: .1.sh),
                height: isMobileDevice() ? .2.sh : .5.sh,
                width: .8.sw,
                child: Flex(
                  direction: isMobileDevice() ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: isMobileDevice() ? 1.sw : 1.sw / 3,
                      child: Text(
                        "Register or Login to benefit from all our features for free!",
                        textAlign: TextAlign.center,
                        style: presetTextThemes(context).headline2,
                      ),
                    ),
                    CurrencyHeadButton(
                      function: () => Get.toNamed('/Login'),
                      text: 'Login/Register',
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: isLargeScreen(context) ? .5.sw : null,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "What do we offer?",
                          style: presetTextThemes(context)
                              .headline3
                              ?.copyWith(color: PRIMARY_COLOR),
                        ),
                      ),
                      Container(
                        width: isLargeScreen(context) ? .5.sw : null,
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "Our app offers a currency exchange platform, focused on highlighting trends over time "
                          "and allowing users to trade currencies following their best judgements and our provided analysis of the market",
                          style: isLargeScreen(context)
                              ? presetTextThemes(context).headline6!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  )
                              : presetTextThemes(context).headline6?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: isLargeScreen(context) ? .5.sw : null,
                            margin: EdgeInsets.only(
                              top: 30,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Acknowledgments",
                              style: presetTextThemes(context)
                                  .headline3
                                  ?.copyWith(color: PRIMARY_COLOR),
                            ),
                          ),
                          Container(
                            width: isLargeScreen(context) ? .5.sw : null,
                            margin: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              "Thank you to both exchangerateapi.io and lirarate.org for providing updated currency rates! "
                              "This project would not have been possible without them.",
                              style: isLargeScreen(context)
                                  ? presetTextThemes(context)
                                      .headline6!
                                      .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      )
                                  : presetTextThemes(context)
                                      .headline6
                                      ?.copyWith(
                                        fontSize: 16,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
