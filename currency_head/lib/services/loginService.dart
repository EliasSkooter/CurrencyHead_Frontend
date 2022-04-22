// ignore_for_file: avoid_print, file_names

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
  print("ZABRE $loginDetails");
  dynamic response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginDetails));
  print("response =====> ${response.body}");
  try {
    dynamic res = jsonDecode(response.body);
    LogedUser logedUser = LogedUser(
        name: res['first_name'],
        surname: res['last_name'],
        username: res['email'],
        accessToken: res['token'],
        currencies: res['currencies']);
    _loginController.setCurrentUserInfo(logedUser);
    return true;
  } catch (e) {
    print("incorrect login details... $e");
    return false;
  }
}

Future<dynamic> register(
    String firstName, String lastName, String email, String password) async {
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

  print("response =====> ${response.body}");

  try {
    dynamic data = jsonDecode(response.body);
    LogedUser logedUser = LogedUser(
        username: data['email'],
        accessToken: data['token'],
        name: data['first_name'],
        surname: data['last_name'],
        currencies: data['currencies']);
    _loginController.setCurrentUserInfo(logedUser);
    return true;
  } catch (e) {
    print("Failed to register user. $e");
    return false;
  }
}
