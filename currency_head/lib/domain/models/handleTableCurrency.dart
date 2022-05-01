import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/domain/models/currencyModel.dart';
import 'package:currency_head/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandleTableCurrency extends DataTableSource {
  //This list is for the new users data
  List<CurrencyModel> data = [];
  Function callback;
  Function callBackGraph;

  final LoginController loginController = Get.put(LoginController());

  // CurrencyController controller = Get.put(CurrencyController());

  //HandleTableCurrency class constructor
  HandleTableCurrency({
    required this.data,
    required this.callback,
    required this.callBackGraph,
  });

  // funciton that will be called when the eye icon is clicked
  void handleGraphCurrency(String id) async {
    callBackGraph(id);
  }

  // funciton that will be called when the eye icon is clicked
  // void handlePrint(int id) async {
  //   dynamic selectedCurrency =
  //       data.firstWhere((element) => element['id'] == id);
  //   downloadFile(selectedCurrency['reference']);
  // }

  void setFavorite(String currencyName) async {
    postFavoriteCurrency(loginController.userInfo['username'], currencyName);
  }

  void removeFavorite(String currencyName) async {
    removeFavoriteCurrency(loginController.userInfo['username'], currencyName);
  }

  bool checkIsFavorite(String currency) {
    bool isFavorite = false;
    for (String currencyId in loginController.userInfo['currencies']) {
      if (currencyId == currency) {
        isFavorite = true;
      }
    }
    return isFavorite;
  }

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
              data[index].name ?? "",
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //Value rows
        DataCell(
          Container(
            alignment: Alignment.center,
            width: 150,
            child: Text(
              (data[index].value as num).toStringAsFixed(4),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //Update Date rows
        DataCell(
          Container(
            alignment: Alignment.center,
            width: 150,
            child: Text(
              data[index].updateDate.toString().substring(0, 10) +
                  " " +
                  data[index].updateDate.toString().substring(11, 19),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //actions rows
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () {
                handleGraphCurrency(data[index].id.toString());
              },
              icon: const Icon(Icons.remove_red_eye_outlined),
              color: Colors.grey,
              iconSize: 18,
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  checkIsFavorite(data[index].id)
                      ? removeFavorite(data[index].name)
                      : setFavorite(data[index].name);
                },
                icon: Icon(
                  Icons.favorite,
                  textDirection: TextDirection.rtl,
                ),
                color:
                    checkIsFavorite(data[index].id) ? Colors.red : Colors.grey,
                iconSize: 18,
                padding: EdgeInsets.all(0),
              ),
            ),
            IconButton(
              onPressed: () {
                // handlePrint(data[index]['id']);
              },
              icon: const Icon(Icons.download),
              color: Colors.grey,
              iconSize: 18,
              padding: EdgeInsets.all(0),
            )
          ],
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
