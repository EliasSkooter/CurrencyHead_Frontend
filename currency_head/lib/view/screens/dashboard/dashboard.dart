import 'package:currency_head/domain/controllers/currencyController.dart';
import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/domain/models/currencyHistoryModel.dart';
import 'package:currency_head/domain/models/currencyModel.dart';
import 'package:currency_head/domain/models/handleTableCurrency.dart';
import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:currency_head/view/widgets/Sidebar/SidebarMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<CurrencyModel> _filteredData = [];

  List<CurrencyHistoryModel> graphData = [];
  String graphCurrencyName = "";

  DateFormat dateFormat = DateFormat();

  String filterValue = "";

  List<CurrencyModel> _data = [];

  //This variable is for the default sortable column to show the arrow on
  int _currentSortColumn = 0;

  //This variable is for the sort order
  bool _isAscending = true;

  //This variable is an instance of the HandleTableNewUsers class
  HandleTableCurrency dataObject =
      HandleTableCurrency(data: [], callback: () {}, callBackGraph: () {});

  CurrencyController currencyController =
      Get.put(CurrencyController()..fetchCurrencies());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void changeGraphCurrency(id) {
    CurrencyModel currencyModel =
        _data.firstWhere((element) => element.id.toString() == id.toString());

    List<CurrencyHistoryModel> tempData = currencyModel.history;
    tempData.add(CurrencyHistoryModel(
        id: id, value: currencyModel.value, date: currencyModel.updateDate));
    setState(() {
      graphData = tempData;
      graphCurrencyName = currencyModel.name;
    });
  }

  bool checkIsFavorite(String id) {
    bool isFavorite = false;
    for (String currencyId in loginController.userInfo['currencies']) {
      if (currencyId == id) {
        isFavorite = true;
      }
    }
    return isFavorite;
  }

  void fetchData() {
    print("innn fetching data");
    currencyController.fetchCurrencies().then((value) {
      List<CurrencyModel> listCurrencyModel = [];
      for (dynamic item in value) {
        List<CurrencyHistoryModel> tempListCurrencyHistoryModel = [];
        for (dynamic historyItem in item['history']) {
          CurrencyHistoryModel tempCurrencyHistoryModel = CurrencyHistoryModel(
            id: historyItem['_id'],
            value: historyItem['value'],
            date: historyItem['date'],
          );
          tempListCurrencyHistoryModel.add(tempCurrencyHistoryModel);
        }

        CurrencyModel tempCurrencyModel = CurrencyModel(
          id: item['_id'],
          name: item['name'],
          value: item['value'],
          updateDate: item['updateDate'],
          fluctuation: item['fluctuation'],
          history: tempListCurrencyHistoryModel,
        );
        listCurrencyModel.add(tempCurrencyModel);
      }
      setState(() {
        _data = listCurrencyModel;
        _filteredData = listCurrencyModel;
      });
      dataObject = HandleTableCurrency(
        data: _filteredData,
        callback: fetchData,
        callBackGraph: changeGraphCurrency,
      );
    });
  }

  // list of columns for the table
  List<DataColumn> getColumns() {
    List<DataColumn> columns = [
      //Name column
      DataColumn(
        label: Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            'Name',
          ),
        ),
        onSort: (columnIndex, _) {
          setState(
            () {
              _currentSortColumn = columnIndex;
              if (_isAscending == true) {
                _isAscending = false;
                _filteredData.sort((productA, productB) {
                  if (productA.name != null && productB.name != null) {
                    return productB.name.compareTo(productA.name);
                  }
                  return 0;
                });
              } else {
                _isAscending = true;
                _filteredData.sort((productA, productB) {
                  if (productA.name != null && productB.name != null) {
                    return productA.name.compareTo(productB.name);
                  }
                  return 0;
                });
              }
              dataObject = HandleTableCurrency(
                data: _filteredData,
                callback: fetchData,
                callBackGraph: changeGraphCurrency,
              );
            },
          );
        },
      ),

      //Value column
      DataColumn(
        label: Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            'value',
          ),
        ),
        onSort: (columnIndex, _) {
          setState(
            () {
              _currentSortColumn = columnIndex;
              if (_isAscending == true) {
                _isAscending = false;
                _filteredData.sort(
                  (productA, productB) =>
                      productB.value.compareTo(productA.value),
                );
              } else {
                _isAscending = true;
                _filteredData.sort(
                  (productA, productB) =>
                      productA.value.compareTo(productB.value),
                );
              }
              dataObject = HandleTableCurrency(
                data: _filteredData,
                callback: fetchData,
                callBackGraph: changeGraphCurrency,
              );
            },
          );
        },
      ),

      //Last Update date column
      DataColumn(
        label: Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            "Last Update Date",
          ),
        ),
      ),

      //Actions column
      DataColumn(
        label: Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            'Actions',
          ),
        ),
        onSort: (columnIndex, _) {
          setState(
            () {
              _currentSortColumn = columnIndex;
              if (_isAscending == true) {
                _isAscending = false;
                _filteredData.sort((productA, productB) {
                  bool favoriteAbool = checkIsFavorite(productA.id);
                  bool favoriteBbool = checkIsFavorite(productB.id);

                  if (favoriteAbool && !favoriteBbool) {
                    return -1;
                  }
                  return 0;
                });
              }
              dataObject = HandleTableCurrency(
                data: _filteredData,
                callback: fetchData,
                callBackGraph: changeGraphCurrency,
              );
            },
          );
        },
      ),
    ];
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(handlerForManageContent: () {}),
          Expanded(
            child: Scaffold(
              appBar: CustomAppBar(),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      width: .2.sw,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "filter table here...",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFBEBEBE),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            filterValue = value;
                          });
                          setState(() {
                            _filteredData = _data.where((element) {
                              return element.name
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                            }).toList();
                          });
                          if (value.isEmpty) {
                            setState(() {
                              _filteredData = _data;
                            });
                          }
                          dataObject = HandleTableCurrency(
                            data: _filteredData,
                            callback: fetchData,
                            callBackGraph: changeGraphCurrency,
                          );
                        },
                      ),
                    ),
                    //Table listing the request contact
                    Theme(
                      data: Theme.of(context).copyWith(
                        cardColor: Colors.grey.shade200,
                      ),
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                        ),
                        child: PaginatedDataTable(
                          source: dataObject,
                          columns: getColumns(),
                          sortColumnIndex: _currentSortColumn,
                          sortAscending: _isAscending,
                          columnSpacing: 0,
                          showCheckboxColumn: true,
                          rowsPerPage: 7,
                          showFirstLastButtons: true,
                        ),
                      ),
                    ),
                    if (graphData.isNotEmpty)
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'Currency Fluctuation History'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<CurrencyHistoryModel, dynamic>>[
                          SplineSeries<CurrencyHistoryModel, String>(
                            yAxisName: "rate",
                            xAxisName: "time",
                            dataSource: graphData,
                            xValueMapper: (CurrencyHistoryModel graphData, _) =>
                                dateFormat
                                    .format(DateTime.parse(graphData.date)),
                            yValueMapper: (CurrencyHistoryModel graphData, _) =>
                                graphData.value,
                            name: graphCurrencyName,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
