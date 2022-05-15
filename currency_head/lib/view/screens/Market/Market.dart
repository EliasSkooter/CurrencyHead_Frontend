import 'package:currency_head/domain/controllers/currencyController.dart';
import 'package:currency_head/domain/controllers/loginController.dart';
import 'package:currency_head/domain/controllers/marketController.dart';
import 'package:currency_head/domain/models/MarketModel.dart';
import 'package:currency_head/domain/models/handleTableMarket.dart';
import 'package:currency_head/utils/common.dart';
import 'package:currency_head/utils/themes.dart';
import 'package:currency_head/view/widgets/AppBar/appBar.dart';
import 'package:currency_head/view/widgets/CustomButton/CustomButton.dart';
import 'package:currency_head/view/widgets/Popup/Popup.dart';
import 'package:currency_head/view/widgets/Sidebar/SidebarMenu.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  MarketState createState() => MarketState();
}

class MarketState extends State<Market> {
  String filterValue = '';

  List<MarketModel> _filteredData = [];
  List<MarketModel> _data = [];

  //This variable is for the default sortable column to show the arrow on
  int _currentSortColumn = 0;

  //This variable is for the sort order
  bool _isAscending = true;

  bool purchaseComplete = false;

  // user buying variables...
  RxDouble userCurrToBuyAmount = 0.0.obs;
  RxString userCurrToBuyName = "".obs;

  RxDouble userCurrToSellAmount = 0.0.obs;
  RxString userCurrToSellName = "".obs;

  RxDouble userCurrWalletAmount = 0.0.obs;
  RxBool doesUserHaveCurrency = true.obs;

  // form variables
  bool isNewLsting = false;

  String newCurrName = "";
  bool currNameControl = true;

  int newCurrAmount = 0;
  bool currAmountControl = true;

  List<String> acceptedCurrencies = [];
  bool acceptedCurrenciesControl = true;

  // init controllers...
  CurrencyController currencyController =
      Get.put(CurrencyController()..fetchCurrencies());

  LoginController loginController = Get.put(LoginController());

  MarketController marketController = Get.put(MarketController());

  HandleTableMarket dataObject = HandleTableMarket(
    data: [],
    callback: () {},
    buyActionCallback: () {},
  );

  bool validateInput() {
    bool valid = true;

    if (newCurrName == '') {
      setState(() {
        currNameControl = false;
      });
      valid = false;
    }

    if (newCurrAmount == 0) {
      setState(() {
        currAmountControl = false;
      });
      valid = false;
    }
    return valid;
  }

  void addNewListing() {
    print("adding new listing...");

    List<Map<String, String>> acceptedCurrenciesMap = [];

    for (String currency in acceptedCurrencies) {
      acceptedCurrenciesMap.add({"name": currency});
    }

    marketController
        .postNewListing(
      email: loginController.userInfo['username'],
      currencyName: newCurrName,
      amount: newCurrAmount,
      acceptedCurrencies: acceptedCurrenciesMap,
    )
        .then((value) {
      print("success!");
      setState(() {
        isNewLsting = false;
        newCurrAmount = 0;
        newCurrName = "";
        acceptedCurrencies = [];
      });
      fetchData();
    });
  }

  List<String> getNameOnlyFromCurrencies() {
    List<String> currencyNames = [];

    for (Map currency in currencyController.currencies) {
      currencyNames.add(currency['name']);
    }

    return currencyNames;
  }

  List<MultiSelectItem<String>> getNameOnlyFromCurrenciesMulti() {
    List<MultiSelectItem<String>> currencyNames = [];

    for (Map currency in currencyController.currencies) {
      currencyNames.add(MultiSelectItem(currency['name'], currency['name']));
    }

    return currencyNames;
  }

  void calculateCost({
    required listedCurrencyName,
    required listedCurrencyAmount,
    required currencyToSellName,
  }) {
    double rateBuy = 0;
    double rateSell = 0;
    String idSell = "";

    for (dynamic item in currencyController.currencies) {
      if (item['name'] == listedCurrencyName) {
        rateBuy = item['value'];
      }
      if (item['name'] == currencyToSellName) {
        rateSell = item['value'];
        idSell = item['_id'];
      }
    }

    for (Map walletItem in loginController.userInfo['currencyWallet']) {
      print("wallet item?? $walletItem");
      print("id selll ===> $idSell");
      if (walletItem.containsValue(idSell)) {
        print("found??");
        setState(() {
          userCurrWalletAmount.value = walletItem["amount"];
        });
      }
    }

    if (userCurrWalletAmount.value == 0) {
      setState(() {
        doesUserHaveCurrency.value = false;
      });
    } else {
      setState(() {
        doesUserHaveCurrency.value = true;
      });
    }

    setState(() {
      userCurrToSellAmount.value = listedCurrencyAmount * (rateSell / rateBuy);
    });
  }

  void confirmPurchase(String sellerEmail, String sellerCurrencyName,
      double sellerCurrencyAmount, String buyerEmail, buyerCurrencyName) {
    print("innn confirming purchase...");
    marketController
        .postBuyCurrency(
      sellerEmail: sellerEmail,
      sellerCurrencyName: sellerCurrencyName,
      sellerCurrencyAmount: sellerCurrencyAmount,
      buyerEmail: buyerEmail,
      buyerCurrencyName: buyerCurrencyName,
    )
        .then((value) {
      if (value == 200) {
        setState(() {
          purchaseComplete = true;
        });
        userCurrToSellName.value = "";
        userCurrWalletAmount.value = 0;
        userCurrToSellAmount.value = 0;
        fetchData();
        Navigator.pop(context);
      } else {
        print("an error occured...");
      }
    });
  }

  void handleBuy(dynamic currName, List exchangeCurrencies, double currAmount,
      String sellerEmail) {
    setState(() {
      userCurrToBuyAmount.value = currAmount;
      userCurrToBuyName.value = currName;
    });
    showGeneralDialog(
      context: context,
      pageBuilder: (buildContext, animation1, animation2) {
        return AlertDialog(
          content: Container(
            width: .5.sw,
            height: .5.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    "Confirm Purchase:",
                    style: presetTextThemes(context).headline4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Please pick one of the available currencies to trade using:",
                    ),
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(
                        left: 50,
                      ),
                      child: DropdownSearch(
                        items: exchangeCurrencies,
                        mode: Mode.MENU,
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Click to choose",
                        ),
                        onChanged: (dynamic value) {
                          setState(() {
                            userCurrToSellName.value = value;
                            userCurrWalletAmount.value = 0;
                            userCurrToSellAmount.value = 0;
                          });
                          calculateCost(
                            listedCurrencyName: currName,
                            listedCurrencyAmount: currAmount,
                            currencyToSellName: value,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => userCurrWalletAmount.value != 0 &&
                          userCurrToSellAmount.value != 0 &&
                          userCurrToBuyAmount.value != 0 &&
                          doesUserHaveCurrency.value
                      ? Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Text(
                                "You have ${userCurrWalletAmount.value} ${userCurrToSellName.value} "
                                "and must give ${userCurrToSellAmount.value.toStringAsFixed(4)} ${userCurrToSellName.value} "
                                "to buy ${userCurrToBuyAmount.value} ${userCurrToBuyName.value}",
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
                Obx(
                  () => userCurrWalletAmount.value != 0 &&
                          userCurrToSellAmount.value != 0 &&
                          userCurrToBuyAmount.value != 0 &&
                          doesUserHaveCurrency.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: CustomButton(
                                title: "Confirm Exchange!",
                                color: PRIMARY_COLOR,
                                onTapCallBack: () {
                                  confirmPurchase(
                                    sellerEmail,
                                    userCurrToBuyName.value,
                                    userCurrToBuyAmount.value,
                                    loginController.userInfo['username'],
                                    userCurrToSellName.value,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
                Obx(
                  () => doesUserHaveCurrency.value
                      ? Container()
                      : Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Text("You do not have this currency!"),
                            ),
                          ],
                        ),
                ),
                //The go back button `Fermer`
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          userCurrToSellName.value = "";
                          userCurrWalletAmount.value = 0;
                          userCurrToSellAmount.value = 0;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: isLargeScreen(context) ? 16 : 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deleteMarketListing() {
    // TODO: IMPLEMENT DELETING USER OFFER
  }

  void handleDelete({
    required BuildContext context,
    required String id,
    text = 'Are you sure you wish to cancel?',
    showBox = false,
  }) {
    print("innnnn canceling...");
    Popup().createState().simpleDialog(
          context: context,
          text: text,
          showBox: showBox,
          cancelAction: () {},
          confirmAction: deleteMarketListing,
        );
  }

  void fetchData() {
    print("innn fetching data");
    marketController.fetchMarketListings().then((value) {
      List<MarketModel> listMarketModel = [];
      for (dynamic item in value) {
        MarketModel tempMarketModel = MarketModel(
          id: item['_id'],
          currName: item['curr_name'],
          currAmount: item['curr_amount'],
          userEmail: item['user_email'],
          acceptedCurr: item['accepted_curr'],
        );
        listMarketModel.add(tempMarketModel);
      }
      setState(() {
        _data = listMarketModel;
        _filteredData = listMarketModel;
      });
      dataObject = HandleTableMarket(
        data: _filteredData,
        callback: fetchData,
        buyActionCallback: handleBuy,
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
            'User',
          ),
        ),
        onSort: (columnIndex, _) {
          setState(
            () {
              _currentSortColumn = columnIndex;
              if (_isAscending == true) {
                _isAscending = false;
                _filteredData.sort((productA, productB) {
                  if (productA.userEmail != null &&
                      productB.userEmail != null) {
                    return productB.userEmail.compareTo(productA.userEmail);
                  }
                  return 0;
                });
              } else {
                _isAscending = true;
                _filteredData.sort((productA, productB) {
                  if (productA.userEmail != null &&
                      productB.userEmail != null) {
                    return productA.userEmail.compareTo(productB.userEmail);
                  }
                  return 0;
                });
              }
              dataObject = HandleTableMarket(
                data: _filteredData,
                callback: fetchData,
                buyActionCallback: handleBuy,
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
            'Currency',
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
                      productB.currName.compareTo(productA.currName),
                );
              } else {
                _isAscending = true;
                _filteredData.sort(
                  (productA, productB) =>
                      productA.currName.compareTo(productB.currName),
                );
              }
              dataObject = HandleTableMarket(
                data: _filteredData,
                callback: fetchData,
                buyActionCallback: handleBuy,
              );
            },
          );
        },
      ),

      //Amount column
      DataColumn(
        label: Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            "Amount",
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
                      productB.currAmount.compareTo(productA.currAmount),
                );
              } else {
                _isAscending = true;
                _filteredData.sort(
                  (productA, productB) =>
                      productA.currAmount.compareTo(productB.currAmount),
                );
              }
              dataObject = HandleTableMarket(
                data: _filteredData,
                callback: fetchData,
                buyActionCallback: handleBuy,
              );
            },
          );
        },
      ),

      //Accepted Currencies column
      DataColumn(
        label: Container(
          width: 150,
          alignment: Alignment.center,
          child: Text(
            "Accepted Exchange",
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
      ),
    ];
    return columns;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideBar(),
          Expanded(
            child: Scaffold(
              appBar: CustomAppBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(50),
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome to our Market!",
                        style: presetTextThemes(context).headline3,
                      ),
                    ),
                    if (purchaseComplete)
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                        ),
                        child: Text(
                          "Congratulations on your purchase!",
                          style: presetTextThemes(context).headline3!.copyWith(
                                color: PRIMARY_COLOR,
                              ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      width: isLargeScreen(context) ? .2.sw : .8.sw,
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
                              return element.currName
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
                          dataObject = HandleTableMarket(
                            data: _filteredData,
                            callback: fetchData,
                            buyActionCallback: handleBuy,
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
                          rowsPerPage: 5,
                          showFirstLastButtons: true,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(50),
                      child: Row(
                        children: [
                          Text(
                            "Add a new currency Exchange: ",
                            style: presetTextThemes(context).headline4,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isNewLsting = true;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isNewLsting)
                      Container(
                        margin: EdgeInsets.all(30),
                        child: Flex(
                          direction: isLargeScreen(context)
                              ? Axis.horizontal
                              : Axis.vertical,
                          mainAxisAlignment: isLargeScreen(context)
                              ? MainAxisAlignment.spaceAround
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: isLargeScreen(context)
                                  ? null
                                  : EdgeInsets.only(
                                      bottom: 20,
                                    ),
                              width: isLargeScreen(context) ? .45.sw : 1.sw,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Currency name: ',
                                      style: presetTextThemes(context)
                                          .headline6
                                          ?.copyWith(
                                              fontSize: 16,
                                              color: Colors.grey.shade800),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: isMobileDevice()
                                        ? 1.sw / 1.7
                                        : 1.sw / 4,
                                    child: DropdownSearch(
                                      items: getNameOnlyFromCurrencies(),
                                      mode: Mode.MENU,
                                      showSearchBox: true,
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: "select a currency",
                                        errorText: !currNameControl
                                            ? "Please choose a currency!"
                                            : null,
                                      ),
                                      onChanged: (value) {
                                        newCurrName = value as String;
                                        setState(() {
                                          currNameControl = true;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: isLargeScreen(context)
                                  ? null
                                  : EdgeInsets.only(
                                      bottom: 20,
                                    ),
                              width: isLargeScreen(context) ? .45.sw : 1.sw,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'amount: ',
                                      style: presetTextThemes(context)
                                          .headline6
                                          ?.copyWith(
                                            fontSize: 16,
                                            color: Colors.grey.shade800,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: isMobileDevice()
                                        ? 1.sw / 1.7
                                        : 1.sw / 4,
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      cursorColor: Colors.black,
                                      cursorWidth: 1,
                                      style: TextStyle(fontSize: 16),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFBEBEBE),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorText: !currAmountControl
                                            ? "This field is required."
                                            : null,
                                        hintText: "amount",
                                        suffixIcon: Icon(
                                          Icons.attach_money,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          newCurrAmount = int.parse(value);
                                        });
                                        if (value == '') {
                                          setState(() {
                                            currAmountControl = false;
                                          });
                                        } else {
                                          setState(() {
                                            currAmountControl = true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isNewLsting)
                      Container(
                        margin: EdgeInsets.all(30),
                        child: Flex(
                          direction: isLargeScreen(context)
                              ? Axis.horizontal
                              : Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: isLargeScreen(context)
                                  ? null
                                  : EdgeInsets.only(
                                      bottom: 20,
                                    ),
                              width: isLargeScreen(context) ? .45.sw : 1.sw,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'Allowed currencies: ',
                                      style: presetTextThemes(context)
                                          .headline6
                                          ?.copyWith(
                                              fontSize: 16,
                                              color: Colors.grey.shade800),
                                    ),
                                  ),
                                  Container(
                                    width: isMobileDevice()
                                        ? 1.sw / 1.7
                                        : 1.sw / 4,
                                    child: MultiSelectDialogField(
                                      initialValue: acceptedCurrencies,
                                      items: getNameOnlyFromCurrenciesMulti(),
                                      searchable: true,
                                      onConfirm: (values) => {
                                        setState(() {
                                          acceptedCurrencies =
                                              values as List<String>;
                                          if (values.isEmpty) {
                                            acceptedCurrenciesControl = false;
                                          } else {
                                            acceptedCurrenciesControl = true;
                                          }
                                        }),
                                      },
                                      decoration: BoxDecoration(
                                        border: !acceptedCurrenciesControl
                                            ? Border.all(
                                                color: Colors.red,
                                              )
                                            : Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ),
                                      dialogHeight: 1.sh / 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isNewLsting)
                      Container(
                        margin: EdgeInsets.all(50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              title: "Submit new listing",
                              onTapCallBack: () {
                                if (validateInput()) {
                                  addNewListing();
                                }
                              },
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
