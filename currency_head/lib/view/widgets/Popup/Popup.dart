import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/validation.dart';
import 'package:currency_head/view/widgets/CustomButton/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// confirm action and cancel action will always pop the popup + whatever your function does (can be () => {} for nothing)
class Popup extends StatefulWidget {
  /// confirm action and cancel action will always pop the popup + whatever your function does (can be () => {} for nothing)
  const Popup({Key? key}) : super(key: key);

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  String data = "";
  final myController = TextEditingController();

  _PopupState();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void submit(context, bool showBox, VoidCallback confirmAction) async {
    if (showBox) {
      if (isEmailValid(myController.text)) {
        Get.back();
        confirmAction();
        // print("Valid email!!! " + myController.text);
      } else {
        // print("please input a valid email!!");
      }
    } else {
      Get.back();
      confirmAction();
    }
  }

  void cancel(VoidCallback cancelAction) {
    Get.back();
    cancelAction();
  }

  /// confirm action and cancel action will always pop the popup + whatever your function does (can be () => {} for nothing)
  void simpleDialog({
    required BuildContext context,
    required String text,
    required bool showBox,
    required VoidCallback confirmAction,
    required VoidCallback cancelAction,
    confirmText = "confirm",
    cancelText = "noThanks",
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: const Color(0xFF7401B8), width: 4),
              borderRadius: BorderRadius.circular(10)),
          content: Container(
              padding: EdgeInsets.fromLTRB(
                isLargeScreen(context) ? 0.1.sw : 0,
                10,
                isLargeScreen(context) ? 0.1.sw : 0,
                0,
              ),
              alignment: Alignment.center,
              height: .3.sh,
              width: 0.4.sw,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (18 / 720 * MediaQuery.of(context).size.height),
                    ),
                  ),
                  if (showBox)
                    TextFormField(
                      onFieldSubmitted: (value) {
                        submit(context, showBox, confirmAction);
                      },
                      onChanged: (val) => {
                        data = val,
                        // changeVal(val),
                        // print("typing??? $val" + "\nbool?? " + data)
                      },
                      controller: myController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFBEBEBE),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFBEBEBE),
                          ),
                        ),
                        hintText: 'example@mail.com',
                      ),
                    )
                ],
              )),
          actions: <Widget>[
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0.03.sh),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: CustomButton(
                      onTapCallBack: () => {
                        submit(
                          context,
                          showBox,
                          confirmAction,
                        )
                      },
                      color:
                          // data.length != 0
                          //     ?
                          Color(0xFFE4472D),
                      // : Color(0xFFBEBEBE),
                      // size: Size(0.19.sw, 40),
                      title: confirmText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0.03.sh),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      onTapCallBack: () => {cancel(cancelAction)},
                      color: Color(0xFFE4472D),
                      // size: Size(0.19.sw, 40),
                      title: cancelText,
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
