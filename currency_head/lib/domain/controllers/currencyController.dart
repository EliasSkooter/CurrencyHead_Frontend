import 'dart:convert';

import 'package:currency_head/constants/IP.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CurrencyController extends GetxController {
  RxList currencies = [].obs;

  Future<dynamic> fetchCurrencies() async {
    final url = getIP() + "getCurrencies";
    dynamic response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    try {
      List returnedCurrencies = jsonDecode(response.body);
      setCurrencies(returnedCurrencies);
      return returnedCurrencies;
    } catch (e) {
      print("failed to retrieve currencies... $e");
    }
  }

  void setCurrencies(List newCurrencies) {
    currencies.value = newCurrencies;
  }
}
