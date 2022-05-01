import 'dart:convert';
import 'package:currency_head/constants/IP.dart';
import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/domain/entities/LogedUser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

LoginController _loginController = Get.put(LoginController());

void postFavoriteCurrency(String userEmail, String currencyName) {
  String url = getIP() + "addUserCurrency";
  final Map body = {
    "email": userEmail,
    "name": currencyName,
  };

  http
      .post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  )
      .then((response) {
    print("return value for favorite ==> ${jsonDecode(response.body)}");
    _loginController.addFavoriteCurency(jsonDecode(response.body));
  }).catchError((onError) {
    print("Failed to add favorite currency... $onError");
  });
}

void removeFavoriteCurrency(String userEmail, String currencyName) {
  String url = getIP() + "deleteUserCurrency";
  final Map body = {
    "email": userEmail,
    "name": currencyName,
  };

  http
      .post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  )
      .then((response) {
    print("return value for favorite ==> ${jsonDecode(response.body)}");
    _loginController.removeFavoriteCurency(jsonDecode(response.body));
  }).catchError((onError) {
    print("Failed to add favorite currency... $onError");
  });
}
