import 'dart:convert';
import 'package:currency_head/constants/IP.dart';
import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/domain/entities/LogedUser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

LoginController _loginController = Get.put(LoginController());

Future<bool> login(String email, String password) async {
  print("weeee");
  final url = getIP() + "login";
  print("urll ===> $url");
  final Map loginDetails = {
    "email": email,
    "password": password,
  };
  dynamic response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginDetails));
  try {
    dynamic res = jsonDecode(response.body);
    LogedUser logedUser = LogedUser(
        name: res['first_name'],
        surname: res['last_name'],
        username: res['email'],
        accessToken: res['token'],
        currencies: res['currencies'],
        currencyWallet: res['currencyWallet']);
    print("loged user ===> $logedUser");
    _loginController.setCurrentUserInfo(logedUser);
    return true;
  } catch (e) {
    print("incorrect login details... $e");
    return false;
  }
}

Future<dynamic> register({
  required String firstName,
  required String lastName,
  required String email,
  required String password,
}) async {
  final Map registrationDetails = {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
  };
  final url = getIP() + "register";
  print(registrationDetails);
  dynamic response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registrationDetails));

  try {
    dynamic data = jsonDecode(response.body);
    LogedUser logedUser = LogedUser(
        username: data['email'],
        accessToken: data['token'],
        name: data['first_name'],
        surname: data['last_name'],
        currencies: data['currencies'],
        currencyWallet: data['currencyWallet']);
    _loginController.setCurrentUserInfo(logedUser);
    return true;
  } catch (e) {
    print("Failed to register user. $e");
    return false;
  }
}
