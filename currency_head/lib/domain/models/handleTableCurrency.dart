import 'package:currency_head/domain/models/currencyModel.dart';
import 'package:flutter/material.dart';

class HandleTableCurrency extends DataTableSource {
  //This list is for the new users data
  List<CurrencyModel> data = [];
  Function callback;
  Function callBackGraph;

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

  // void handleDelete(int id) async {
  //   genericDelete('Currency', id).then((value) {
  //     print("successfully deleted Currency... $value");
  //     callback();
  //   }).catchError((onError) {
  //     print("failed to delete Currency... $onError");
  //   });
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
            IconButton(
              onPressed: () {
                // handleDelete(data[index]['id']);
              },
              icon: const Icon(
                Icons.delete_forever,
                textDirection: TextDirection.rtl,
              ),
              color: Colors.grey,
              iconSize: 18,
              padding: EdgeInsets.all(0),
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
