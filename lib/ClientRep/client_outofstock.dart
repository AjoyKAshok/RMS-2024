import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/ClientNetworkModel/OOSModel.dart' as oos;
import 'package:rms/ClientRep/client_api_service.dart';
import 'package:rms/ClientRep/client_home.dart';
import 'package:rms/ClientRep/client_oos.dart';
import 'package:rms/ClientRep/client_oos_page.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/NetworkModelfm/Merchandiser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientOutOfStockDetails extends StatefulWidget {
  const ClientOutOfStockDetails({super.key});

  @override
  State<ClientOutOfStockDetails> createState() =>
      _ClientOutOfStockDetailsState();
}

class _ClientOutOfStockDetailsState extends State<ClientOutOfStockDetails> {
  Timer? _timer;
  int i = 0;
  Data? data;
  int lengthlist = 0;
  int storeLengthList = 0;
  int listLength = 0;
  var myList = [];
  var myStoreList = [];
  var visitedList = [];
  var date = DateTime.now();

  String emp = "";
  String user = "";
  MerchandiserModel? _data;
  // _TimeSheetPageState(Data? data);
  // vm.VisitedModel? _visitData;

  int storeCount = 0;
  int visitedCount = 0;
  List<Map<String, dynamic>> itemNameList = [];
  List<Map<String, dynamic>> uniqueItemNameList = [];
  Map<String, dynamic>? currentStore;
  Map<String, dynamic>? uniqueStoreList;
  String currentStoreName = '';
  Map<String, List<String>> groupedProducts = {};
  oos.OOSModel? _datao;
  String? datePassed;
  var storesList = [];
  String theStore = '';

  Map<String, List<String>> groupProductsByStore(
      List<Map<String, dynamic>> inputList) {
    for (var item in inputList) {
      String storeName = item['store_name'].trim();
      String productName = item['product_name'];

      if (!groupedProducts.containsKey(storeName)) {
        groupedProducts[storeName] = [];
      }

      groupedProducts[storeName]!.add(productName);
    }

    return groupedProducts;
  }

  _gettodayplannedStores(String empId, String datePassedIn) async {
    setState(() {
      storeLengthList = 0;
      myStoreList = [];
      itemNameList = [];
      storesList = [];
      groupedProducts = {};
      visitedList = [];
    });
    print("The EmpId in fetching planned : $empId");
    await ClientApiService.clientservice
        .clientoos(context, empId, datePassedIn)
        .then((value) => {
              // print("Value : ${value.data![0].storeName}"),
              setState(() {
                _datao = value;
                value.status == 200
                    ? myStoreList.addAll(_datao!.data!)
                    : myStoreList = [];
                storeLengthList = myStoreList.length;
              }),
            });
    print("Store Length List is : $storeLengthList");
    // print("My List : ${_data!.data!.length}");
    for (var i = 0; i < storeLengthList; i++) {
      visitedList.add(_datao!.data![i].storeName);

      currentStore = {
        'store_name': _datao!.data![i].storeName.toString(),
        "store_code": _datao!.data![i].storeCode.toString(),
        "product_name": _datao!.data![i].pName.toString(),
        "brand_name": _datao!.data![i].bName.toString(),
        "category_name": _datao!.data![i].cName.toString(),
        "brand_id": _datao!.data![i].bId.toString(),
      };

      itemNameList.add(currentStore!);
    }
    print("Visited Length : ${visitedList.length}");
    Map<String, List<String>> result = groupProductsByStore(itemNameList);

    result.forEach((storeName, products) {
      print('Store: $storeName');
      for (var product in products) {
        print('  - $product');
      }
      print('');
    });
    print("The item name list : $itemNameList");
    for (var j = 0; j < visitedList.length; j++) {
      print("OOS List -$j : ${visitedList[j]}");
      theStore != visitedList[j] ? storesList.add(visitedList[j]) : null;
      theStore = visitedList[j];
    }
    storeCount = storesList.length;
    visitedCount = visitedList.length;
    log("The Current Store Map : $itemNameList");
    // log("The Unique Store Map : $uniqueItemNameList");
    print("The Current Store Map Length : ${itemNameList.length}");
    print("The Unique Store Map Length : $storeCount");
    print("Length of Store List is : ${storesList.length}");
  }

  showOOSDetails(String emp, String datePassedIn) async {
    await _gettodayplannedStores(emp, datePassedIn);
    print("Check : $storeLengthList, ${storesList.length}");
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade100,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                    return Container(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "OOS Details",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            storeLengthList > 0
                                ? SizedBox(
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      itemCount: storesList.length,
                                      itemBuilder: (context, index) {
                                        String storeName = groupedProducts.keys
                                            .elementAt(index);
                                        List<String> products =
                                            groupedProducts[storeName]!;
                                        return ExpansionTile(
                                          title: Text(
                                            storeName,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.orange),
                                          ),
                                          children: products
                                              .map((product) => ListTile(
                                                      title: Text(
                                                    product,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  )))
                                              .toList(),
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10.00,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }));
  }

  void _startPeriodicUpdates() {
    // Fetch updates every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    // Fetch the latest data from the backend
    // await _gettodayplannedrefresh();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ClientOutOfStockDetails()),
    );
  }

  _gettodayplanned() async {
    setState(() {
      storeLengthList = 0;
      myStoreList = [];
      itemNameList = [];
      storesList = [];
      groupedProducts = {};
      visitedList = [];
    });

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    // emp=prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    context.loaderOverlay.show();
    ClientApiService.clientservice
        .cocamerchandiser(
          context,
        )
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
                dateToUse =
                    DateFormat('yyyy-MM-dd').format(selectedDate).toString();
                todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
              })
            });
    // _gettodayplannedStores();
  }

  _gettodayplannedrefresh() async {
    setState(() {
      storeLengthList = 0;
      myStoreList = [];
      itemNameList = [];
      storesList = [];
      groupedProducts = {};
      visitedList = [];
      myList = [];
    });
    print("Refresh Function Called");
    print("The selected date is : $dateToUse");
    print("Todays Date : $todayDate");
    todayDate == dateToUse
        ? _startPeriodicUpdates() // print("Same Date")
        : _timer!.cancel();
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    // emp=prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    // context.loaderOverlay.show();
    ClientApiService.clientservice
        .cocamerchandiser(
          context,
        )
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
                dateToUse =
                    DateFormat('yyyy-MM-dd').format(selectedDate).toString();
              })
            });
   
    setState(() {});

     for (var i = 0; i < lengthlist; i++) {
      ClientOOS(_data!.data![i].employeeId!, dateToUse!);
    }
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    // SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 3));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  DateTime selectedDate = DateTime.now();
  String? dateToUse;
  String? todayDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2300),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateToUse = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
        todayDate = DateFormat('yyyy-MM-dd').format(date).toString();
        print("The selected date is : $dateToUse");
        print("Todays Date : $todayDate");
        myList = [];
        lengthlist = 0;
        todayDate == dateToUse
            ? _startPeriodicUpdates() // print("Same Date")
            : _timer!.cancel();
      });
      await _gettodayplannedrefresh();
      // Here you can call a method to refresh data based on the new date
      // For example: _refreshDataForDate(selectedDate);
    }
  }

  @override
  initState() {
    super.initState();
    _gettodayplanned();
    loader();
    _startPeriodicUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color(0xfff5e1d5),
        foregroundColor: const Color(0XFFE84201),
        leading: IconButton(
          onPressed: () {
            setState(() {
              _timer!.cancel();
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClientHome()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0XFF909090),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Out Of Stock"),
            Text(
              "$user($emp) - v ${AppVersion.version}",
              style: TextStyle(
                  color: Colors.black.withOpacity(.6),
                  fontSize: 8,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Pattern.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   height: 60,
                //   width: MediaQuery.of(context).size.width * .94,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50.0),
                //     color: const Color(0xfff5e1d5),
                //   ),
                //   padding: const EdgeInsets.all(8),
                //   child: const TextField(
                //     decoration: InputDecoration(
                //       hintText: 'Search by Merchandiser Name',
                //       hintStyle: TextStyle(
                //         color: Color(0XFFE84201),
                //       ),
                //       border: InputBorder.none,
                //       prefixIcon: Icon(
                //         Icons.search,
                //         color: Color(0XFFE84201),
                //         size: 30,
                //       ),
                //       suffixIcon: Icon(
                //         Icons.clear,
                //         color: Color(0XFFE84201),
                //         size: 25,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Selected Date: $dateToUse',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFE84201),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectDate(context);
                          print("Todays Date : $todayDate");
                          print("Selected Date : $dateToUse");
                          // if (todayDate!.compareTo(dateToUse!) != 0) {
                          //   _timer!.cancel();
                          // }
                          // todayDate != dateToUse ? _timer!.cancel() : null;
                          todayDate == dateToUse
                              ? print("Same Date")
                              : _timer!.cancel();
                          setState(() {});
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lengthlist,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // _gettodayvisited(
                      //     _data!.data![index].employeeId.toString());
                      print(
                          "THe EmpId val : ${_data!.data![index].employeeId.toString()}");

                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), //<-- SEE HERE
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _data!.data![index].firstName
                                            .toString(),
                                        style: TextStyle(
                                            color: const Color(0XFFE84201)
                                                .withOpacity(.8),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Emp ID : ${_data!.data![index].employeeId}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                      //Text(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // showOOSDetails(
                                      //     _data!.data![index].employeeId!,
                                      //     dateToUse!)
                                      _timer!.cancel();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ClientOOSPage(
                                                _data!.data![index].employeeId!,
                                                dateToUse!,
                                                index)),
                                      );
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: ClientOOS(
                                          _data!.data![index].employeeId!,
                                          dateToUse!,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
