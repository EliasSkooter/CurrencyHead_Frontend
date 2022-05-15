import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/domain/models/MarketModel.dart';
import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/themes.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandleTableMarket extends DataTableSource {
  //This list is for the new users data
  List<MarketModel> data = [];
  Function callback;
  Function buyActionCallback;

  final LoginController loginController = Get.put(LoginController());

  // CurrencyController controller = Get.put(CurrencyController());

  //HandleTableMarket class constructor
  HandleTableMarket({
    required this.data,
    required this.callback,
    required this.buyActionCallback,
  });

  List<dynamic> getValue(List currencies) {
    List<dynamic> currencyValues = [];

    for (dynamic item in currencies) {
      currencyValues.add(item['name']);
    }
    return currencyValues;
  }

  // funciton that will be called when the eye icon is clicked
  // void handlePrint(int id) async {
  //   dynamic selectedCurrency =
  //       data.firstWhere((element) => element['id'] == id);
  //   downloadFile(selectedCurrency['reference']);
  // }

  // bool checkIsFavorite(String currency) {
  //   bool isFavorite = false;
  //   for (String currencyId in loginController.userInfo['currencies']) {
  //     if (currencyId == currency) {
  //       isFavorite = true;
  //     }
  //   }
  //   return isFavorite;
  // }

  @override
  //This function is responsible of filling the rows of the Data table
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        //Name rows
        DataCell(
          Container(
            alignment: Alignment.center,
            width: 150,
            child: Text(
              data[index].userEmail ?? "",
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //curr name rows
        DataCell(
          Container(
            alignment: Alignment.center,
            width: 150,
            child: Text(
              data[index].currName ?? "",
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //amount rows
        DataCell(
          Container(
            alignment: Alignment.center,
            width: 150,
            child: Text(
              showNumberWithCommas(data[index].currAmount),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //Accepted Currencies rows
        DataCell(
          Container(
            alignment: Alignment.center,
            width: 150,
            child: DropdownSearch(
              items: getValue(data[index].acceptedCurr),
              mode: Mode.MENU,
              dropdownSearchDecoration: InputDecoration(
                hintText: "click to show",
              ),
            ),
          ),
        ),

        //actions rows
        DataCell(Container(
          margin: EdgeInsets.only(
            left: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  buyActionCallback(
                    data[index].currName.toString(),
                    getValue(data[index].acceptedCurr),
                    data[index].currAmount,
                    data[index].userEmail,
                  );
                },
                icon: const Icon(Icons.attach_money),
                color: PRIMARY_COLOR,
                iconSize: 18,
              ),
              IconButton(
                onPressed: () {
                  // checkIsFavorite(data[index].id)
                  //     ? removeFavorite(data[index].name)
                  //     : setFavorite(data[index].name);
                },
                icon: Icon(
                  Icons.favorite,
                  textDirection: TextDirection.rtl,
                ),
                // color:
                //     checkIsFavorite(data[index].id) ? Colors.red : Colors.grey,
                iconSize: 18,
                padding: EdgeInsets.all(0),
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
