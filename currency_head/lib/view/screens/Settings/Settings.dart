import 'package:currency_head/domain/controllers/currencyController.dart';
import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/services/apiService.dart';
import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:currency_head/view/widgets/CustomButton/CustomButton.dart';
import 'package:currency_head/view/widgets/Sidebar/SidebarMenu.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  String newCurrName = "";
  bool currNameControl = true;

  int newCurrAmount = 0;
  bool currAmountControl = true;

  bool success = false;

  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  CurrencyController currencyController =
      Get.put(CurrencyController()..fetchCurrencies());

  List<String> getNameOnlyFromCurrencies() {
    List<String> currencyNames = [];

    for (Map currency in currencyController.currencies) {
      currencyNames.add(currency['name']);
    }

    return currencyNames;
  }

  void addCurrency() {
    addNewCurrencyWallet(
      loginController.userInfo['username'],
      newCurrName,
      newCurrAmount,
    ).then((value) {
      setState(() {
        success = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(),
          Expanded(
            child: Scaffold(
              appBar: CustomAppBar(),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: isLargeScreen(context) ? .6.sw : null,
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 50,
                        ),
                        child: Text(
                          "Join the beta today by adding currencies here!",
                          style: presetTextThemes(context).headline2,
                          softWrap: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 50,
                        ),
                        child: Flex(
                          direction: isLargeScreen(context)
                              ? Axis.horizontal
                              : Axis.vertical,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                "Pick a currency: ",
                                style: presetTextThemes(context)
                                    .headline6
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.grey.shade800,
                                    ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: isMobileDevice() ? 1.sw / 1.7 : 1.sw / 4,
                              child: Obx(
                                () => DropdownSearch(
                                  items: getNameOnlyFromCurrencies(),
                                  mode: Mode.MENU,
                                  showSearchBox: true,
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: "select a currency",
                                    errorText: !currNameControl
                                        ? "Please choose a currency!"
                                        : null,
                                  ),
                                  onChanged: (value) {
                                    newCurrName = value as String;
                                    setState(() {
                                      currNameControl = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flex(
                        direction: isLargeScreen(context)
                            ? Axis.horizontal
                            : Axis.vertical,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "Pick an amount: ",
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                                errorText: !currAmountControl
                                    ? "This field is required."
                                    : null,
                                hintText: "amount",
                                suffixIcon: Icon(
                                  Icons.attach_money,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  newCurrAmount = int.parse(value);
                                });
                                if (value == '') {
                                  setState(() {
                                    currAmountControl = false;
                                  });
                                } else {
                                  setState(() {
                                    currAmountControl = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(50),
                        child: CustomButton(
                          onTapCallBack: () {
                            addCurrency();
                          },
                          title: "Confirm",
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      if (success)
                        Text(
                          "Successfully added currency!",
                          style: presetTextThemes(context).headline3!.copyWith(
                                color: PRIMARY_COLOR,
                              ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
