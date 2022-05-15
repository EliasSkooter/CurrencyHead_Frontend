import 'dart:convert';

import 'package:currency_head/constants/IP.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MarketController extends GetxController {
  RxList marketListings = [].obs;

  Future<dynamic> fetchMarketListings() async {
    final url = getIP() + "getMarketListings";
    dynamic response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    try {
      List returnedMarketListings = jsonDecode(response.body);
      setMarketListings(returnedMarketListings);
      return returnedMarketListings;
    } catch (e) {
      print("failed to retrieve market listings... $e");
    }
  }

  Future<dynamic> postBuyCurrency({
    required String sellerEmail,
    required String sellerCurrencyName,
    required double sellerCurrencyAmount,
    required String buyerEmail,
    required String buyerCurrencyName,
  }) async {
    Map body = {
      "lister_email": sellerEmail,
      "lister_curr_name": sellerCurrencyName,
      "lister_curr_amount": sellerCurrencyAmount,
      "buyer_email": buyerEmail,
      "buyer_curr_name": buyerCurrencyName,
    };

    final url = getIP() + "exchangeCurrencyAmount";
    dynamic response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    print("response ==> ${response.body}");
    if (response.body == "nice") {
      return 200;
    } else {
      return 400;
    }
  }

  Future<dynamic> postNewListing({
    required String email,
    required String currencyName,
    required int amount,
    required List acceptedCurrencies,
  }) async {
    Map body = {
      "user_email": email,
      "curr_name": currencyName,
      "curr_amount": amount,
      "accepted_curr": acceptedCurrencies
    };

    final url = getIP() + "addMarketListing";
    dynamic response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    return response.body;
  }

  void setMarketListings(List marketListing) {
    marketListings.value = marketListing;
  }
}
