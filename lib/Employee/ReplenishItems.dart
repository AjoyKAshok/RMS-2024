import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/ActivitiesPage.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/NetworkModel/Stock_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ReplenishItems extends StatefulWidget {
  String name = "";
  String address = "";
  String timesheetid = '';
  String idNav = "";
  String addressNav = "";
  String nameNav = "";
  String latNav = "";
  String longNav = "";
  String radiusNav = "";
  String iNav = "";
  String kmNav = "";
  String outletId = "";
  ReplenishItems(
      this.timesheetid,
      this.name,
      this.address,
      this.idNav,
      this.addressNav,
      this.nameNav,
      this.latNav,
      this.longNav,
      this.radiusNav,
      this.iNav,
      this.kmNav,
      this.outletId,
      {super.key});
  Data? data;
  @override
  State<ReplenishItems> createState() => _ReplenishItemsState(
        data,
        timesheetid,
        name,
        outletId,
      );
}

class DataItem {
  String category;
  String name;
  String id;
  String date;
  String udm;
  String quantity;

  DataItem({
    required this.category,
    required this.name,
    required this.id,
    required this.date,
    required this.udm,
    required this.quantity,
  });
}

class _ReplenishItemsState extends State<ReplenishItems>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AppLifecycleState _appState = AppLifecycleState.inactive;

  Data? data;
  StockModel? _data;
  int lengthlist = 0;
  final TextEditingController _sea = TextEditingController();
  final TextEditingController _qua = TextEditingController();
  var myList = [];
  String emp = "";
  String user = "";
  String outid = "";
  String km = "";
  String? idNav;
  String? addressNav;
  String? nameNav;
  double? radNav;
  String? latNav;
  String? longNav;
  String? kmNav;
  String? checkinNav;
  String? outletId;
  List<DataItem> dataList = [];
  TextEditingController dateInput = TextEditingController();
  late TabController controller;
  _ReplenishItemsState(this.data, this.outid, this.km, this.outletId);
  int i = 0;
  int j = -1;
  int k = 0;
  String? _selectedCategory;
  final List<String> _categories = ['Warm', 'Cold', 'Water', 'Promotion'];
  String defaultValue = "";
  bool searchStarted = false;
  bool queryStarted = false;
  var filteredList = [];
  List<String> searchList = [];
  List<String> searchListNew = [];
  var newFilteredList = [];
  var waterList = [];
  List item = [];
  List<Map<String, dynamic>> customList = [];
  List<Map<String, dynamic>> filteredCustomList = [];
  Map<String, dynamic>? currentItem;
  String hintTextVal = "Search Product by Name";
  _gettodayplanned() async {
    await ApiService.service
        .stock(
          context,
        )
        .then((value) => {
              setState(() {
                _data = value;
                myList.addAll(_data!.data!);
                lengthlist = myList.length;
                for (int i = 0; i < lengthlist; i++) {
                  filteredList.add(_data!.data![i].productName.toString());
                  currentItem = {
                    'product_name': _data!.data![i].productName.toString(),
                    'type': _data!.data![i].type,
                    'barcode': _data!.data![i].barcode,
                    'sku': _data!.data![i].sku,
                    'zrep_code': _data!.data![i].zrepCode,
                    'brand_id': _data!.data![i].brandId,
                    'category_name': _data!.data![i].categoryName,
                  };
                  customList.add(currentItem!);
                }
              })
            });
    print("Data Values : $customList");
    print("Filtered Items Value : $filteredList");
  }

  loadValues() async {
    await loader1();
  }

  Future<void> loader1() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp = prefs1.get("id").toString();
    user = prefs1.get("user").toString();
  }

  String _lastPage = '';
  void _getLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getString('page') ?? 'Replenish';
    });
  }

  void _saveLastPage(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('page', page);
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    context.loaderOverlay.show();
    setState(() {
      nameNav = prefs1.getString('name')!;
      idNav = prefs1.getString('ids')!;
      // checkinNav = widget.checkinNav;
      // ouid = prefs1.getString('ouid')!;
      // place = prefs1.getString('place')!;
      addressNav = prefs1.getString('desi')!;
      radNav = double.parse(prefs1.getString('radius')!);
      // contact = prefs1.getString('number')!;
      latNav = prefs1.getString('lat')!;
      longNav = prefs1.getString('long')!;
      kmNav = prefs1.getString('km') ?? widget.kmNav;
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    print(
        "The passed values : Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radNav, Lat - $latNav, Long - $longNav, Km - $kmNav");
    await Future.delayed(const Duration(seconds: 2));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  // Initialize connectivity status
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  // Update the UI based on the connectivity status
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectionStatus = result;
    });
    if (result == ConnectivityResult.none) {
      _showNoConnectionDialog();
    }
  }

  void openAppSettings() async {
    const url = 'app-settings:';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open app settings';
    }
  }

  void _showNoConnectionDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('You have lost your internet connection.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // AppSettings.openAppSettings(type: AppSettingsType.wifi);
                Platform.isIOS
                    ? openAppSettings()
                    : AppSettings.openAppSettingsPanel(
                        AppSettingsPanelType.internetConnectivity);
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  checkNetwork() async {
    await _initConnectivity();
  }

  fetchNetwork() async {
    print("Network Check from Availability Page");
    await checkNetwork();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // reason.clear();
    outletId = widget.outletId;
    print("Outlet Id Recieved : $outletId");
    loader();
    loadValues();
    _saveLastPage("Replenish");
    _gettodayplanned();
    // filterSearchResults("");
    fetchNetwork();
    // Preference.setPage("JourneyPlan");

    dateInput.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now()); //set the initial value of text field
    controller = TabController(vsync: this, length: 2);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    idNav = widget.idNav;
    addressNav = widget.addressNav;
    nameNav = widget.nameNav;
    latNav = widget.latNav;
    longNav = widget.longNav;
    radNav = double.parse(widget.radiusNav);
    kmNav = widget.kmNav;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _appState = state;
    _getLastPage();
    print("App State is : $_appState");
    if (state == AppLifecycleState.resumed) {
      // myList.clear();
      print("Calling Life Cycle Change Events");
      if (_lastPage == "Stock") {
        print("Calling Functions for Stock Page");
        await Future.delayed(const Duration(seconds: 4));
        setState(() {
          fetchNetwork();
          idNav = widget.idNav;
          addressNav = widget.addressNav;
          nameNav = widget.nameNav;
          latNav = widget.latNav;
          longNav = widget.longNav;
          radNav = double.parse(widget.radiusNav);
          kmNav = widget.kmNav;
          outletId = widget.outletId;
          // checkinNav = widget.checkinNav;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  double _calculateFontSize(String text) {
    if (text.length <= 10) {
      return 16.0;
    } else if (text.length <= 20) {
      return 16.0;
    } else if (text.length <= 30) {
      return 14.0;
    } else {
      return 10.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 1,
              foregroundColor: Colors.black.withOpacity(.6),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Activity(
                              idNav!, addressNav!, nameNav!,
                              latNav!, longNav!, radNav!, 1, kmNav!, outletId!,
                              // checkinNav!
                            )),
                  );
                },
                icon: const Icon(Icons.arrow_back),
                color: const Color(0XFF909090),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Replenish Items",
                        style: TextStyle(
                            color: Color(0XFFE84201),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "$user - $emp - v ${AppVersion.version}",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Pattern.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            color: Colors.white,
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: TabBar(
                              controller: controller,
                              indicatorColor: const Color(0XFFE84201),
                              labelColor: const Color(0XFFE84201),
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontWeight: FontWeight.w500,
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabAlignment: TabAlignment.fill,
                              isScrollable: false,
                              tabs: const [
                                Tab(
                                  text: "Add Data",
                                ),
                                Tab(
                                  text: "Saved Data",
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .703,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(controller: controller, children: [
                            Container(
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          color: Colors.white,
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: _selectedCategory,
                                                hint: const Text(
                                                  'Select Category',
                                                  style: TextStyle(
                                                    color: Color(0XFF909090),
                                                  ),
                                                ),
                                                items: _categories
                                                    .map((String category) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: category,
                                                    child: Text(
                                                      category,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0XFFE84201),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    _sea.clear();
                                                    _selectedCategory =
                                                        newValue;
                                                    _selectedCategory == "Water"
                                                        ? waterList = customList
                                                            .where(
                                                              (item) =>
                                                                  item['product_name']
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          "Arwa"
                                                                              .toLowerCase()) ||
                                                                  item['barcode']
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          "Arwa"
                                                                              .toLowerCase()),
                                                            )
                                                            .toList()
                                                        : waterList = [];
                                                  });
                                                  print(
                                                      "Testing Water List : $waterList");
                                                  print(
                                                      "Water List Count : ${waterList.length}");
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 0,
                                            child: SizedBox(
                                              // height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 8),
                                                child: TextField(
                                                  cursorColor:
                                                      const Color(0XFFE84201),
                                                  controller: _sea,
                                                  style: TextStyle(
                                                      fontSize:
                                                          _calculateFontSize(
                                                              _sea.text)),
                                                  onChanged: (query) {
                                                    setState(() {
                                                      queryStarted = true;
                                                      _selectedCategory ==
                                                              "Water"
                                                          ? newFilteredList =
                                                              waterList
                                                                  .where(
                                                                    (item) =>
                                                                        item['product_name']
                                                                            .toLowerCase()
                                                                            .contains(query
                                                                                .toLowerCase()) ||
                                                                        item['barcode']
                                                                            .toLowerCase()
                                                                            .contains(query.toLowerCase()),
                                                                  )
                                                                  .toList()
                                                          : newFilteredList =
                                                              customList
                                                                  .where(
                                                                    (item) =>
                                                                        item['product_name']
                                                                            .toLowerCase()
                                                                            .contains(query
                                                                                .toLowerCase()) ||
                                                                        item['barcode']
                                                                            .toLowerCase()
                                                                            .contains(query.toLowerCase()),
                                                                  )
                                                                  .toList();
                                                      print(
                                                          "Value of New Filtered List : $newFilteredList");
                                                    });
                                                  },
                                                  onTap: () {
                                                    setState(() {
                                                      // _gettodayplanned();
                                                      searchStarted = true;
                                                      hintTextVal = "";
                                                    });
                                                    print(
                                                        "The List of products displayed : $_selectedCategory - $newFilteredList");
                                                  },
                                                  decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          searchStarted = false;
                                                          queryStarted = false;
                                                          // filteredList.clear();
                                                          _sea.clear();
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          hintTextVal =
                                                              "Search Product by Name";
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.clear,
                                                        color:
                                                            Color(0XFFE84201),
                                                      ),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    labelText: hintTextVal,
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0XFFE84201)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchStarted
                                            ? queryStarted
                                                ? _selectedCategory == "Water"
                                                    ? SizedBox(
                                                        height: 400,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              newFilteredList
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(newFilteredList[
                                                                          index]
                                                                      [
                                                                      'product_name']),
                                                                  Text(
                                                                    newFilteredList[
                                                                            index]
                                                                        [
                                                                        'barcode'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  j = filteredList.indexOf(
                                                                      newFilteredList[
                                                                              index]
                                                                          [
                                                                          'product_name']);
                                                                  print(
                                                                      "Index of Selected Product : $j");
                                                                  _sea.text = newFilteredList[
                                                                          index]
                                                                      [
                                                                      'product_name'];
                                                                  searchStarted =
                                                                      false;
                                                                  queryStarted =
                                                                      false;
                                                                  newFilteredList
                                                                      .clear();
                                                                });
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 400,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              newFilteredList
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(newFilteredList[
                                                                          index]
                                                                      [
                                                                      'product_name']),
                                                                  Text(
                                                                    newFilteredList[
                                                                            index]
                                                                        [
                                                                        'barcode'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  j = filteredList.indexOf(
                                                                      newFilteredList[
                                                                              index]
                                                                          [
                                                                          'product_name']);
                                                                  print(
                                                                      "Index of Selected Product : $j");
                                                                  _sea.text = newFilteredList[
                                                                          index]
                                                                      [
                                                                      'product_name'];
                                                                  searchStarted =
                                                                      false;
                                                                  queryStarted =
                                                                      false;
                                                                  newFilteredList
                                                                      .clear();
                                                                });
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                                : _selectedCategory == "Water"
                                                    ? SizedBox(
                                                        height: 400,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              waterList.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(waterList[
                                                                          index]
                                                                      [
                                                                      'product_name']),
                                                                  Text(
                                                                    waterList[
                                                                            index]
                                                                        [
                                                                        'barcode'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  j = filteredList.indexOf(
                                                                      waterList[
                                                                              index]
                                                                          [
                                                                          'product_name']);
                                                                  print(
                                                                      "Index of Selected Product : $j");
                                                                  _sea.text = waterList[
                                                                          index]
                                                                      [
                                                                      'product_name'];
                                                                  searchStarted =
                                                                      false;
                                                                  queryStarted =
                                                                      false;
                                                                  waterList
                                                                      .clear();
                                                                });
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 300,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              filteredList
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              title: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(customList[
                                                                          index]
                                                                      [
                                                                      'product_name']),
                                                                  Text(
                                                                    customList[
                                                                            index]
                                                                        [
                                                                        'barcode'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                  ),
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  j = filteredList.indexOf(
                                                                      customList[
                                                                              index]
                                                                          [
                                                                          'product_name']);
                                                                  print(
                                                                      "Index of Selected Product : $j");
                                                                  searchStarted =
                                                                      false;
                                                                  queryStarted =
                                                                      false;
                                                                  _sea.text =
                                                                      filteredList[
                                                                          index];
                                                                });
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  readOnly: true,
                                                  cursorColor:
                                                      const Color(0XFFE84201),
                                                  style: const TextStyle(
                                                      color: Color(0XFFE84201)),
                                                  decoration: InputDecoration(
                                                    hintText: j == -1
                                                        ? " UOM"
                                                        : _data!.data![j].type,
                                                    hintStyle: const TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 12),
                                                    border: InputBorder.none,
                                                    // prefixIcon: Icon(Icons.search,color:Color(0XFFE84201)),
                                                    //suffixIcon: Icon(Icons.clear,color:Color(0XFFE84201)),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  readOnly: true,
                                                  cursorColor:
                                                      const Color(0XFFE84201),
                                                  style: const TextStyle(
                                                      color: Color(0XFFE84201)),
                                                  decoration: InputDecoration(
                                                    hintText: j == -1
                                                        ? " Barcode"
                                                        : _data!
                                                            .data![j].barcode,
                                                    hintStyle: const TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 12),
                                                    border: InputBorder.none,
                                                    // prefixIcon: Icon(Icons.search,color:Color(0XFFE84201)),
                                                    //suffixIcon: Icon(Icons.clear,color:Color(0XFFE84201)),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller: dateInput,
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                  //editing controller of this TextField
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    icon: Icon(
                                                      Icons.calendar_today,
                                                      size: 15,
                                                    ), //icon of text field
                                                    //labelText: "Enter Date" //label text of field
                                                  ),
                                                  readOnly: true,
                                                  //set it true, so that user will not able to edit text
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1950),
                                                            //DateTime.now() - not to allow to choose before today.
                                                            lastDate:
                                                                DateTime(2100));

                                                    if (pickedDate != null) {
                                                      print(
                                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  pickedDate);
                                                      print(
                                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                                      setState(() {
                                                        dateInput.text =
                                                            formattedDate; //set output date to TextField value.
                                                      });
                                                    } else {}
                                                  },
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                    controller: _qua,
                                                    cursorColor:
                                                        const Color(0XFFE84201),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFFE84201)),
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          " Enter Refill Quantity",
                                                      hintStyle: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      border: InputBorder.none,
                                                      // prefixIcon: Icon(Icons.search,color:Color(0XFFE84201)),
                                                      //suffixIcon: Icon(Icons.clear,color:Color(0XFFE84201)),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Card(
                                              color: Colors.white,
                                              elevation: 0,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: TextField(
                                                  cursorColor:
                                                      Color(0XFFE84201),
                                                  style: TextStyle(
                                                      color: Color(0XFFE84201)),
                                                  decoration: InputDecoration(
                                                    hintText: " Remarks",
                                                    hintStyle: TextStyle(
                                                        color: Colors.black38,
                                                        fontSize: 12),
                                                    border: InputBorder.none,
                                                    // prefixIcon: Icon(Icons.search,color:Color(0XFFE84201)),
                                                    //suffixIcon: Icon(Icons.clear,color:Color(0XFFE84201)),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              
                                              k = 1;
                                              // MODIFIED CODE
                                              String category =
                                                  _selectedCategory!;
                                              String name = _sea.text;
                                              // ORIGINAL CODE
                                              // String name = _data!
                                              // .data![j].productName
                                              // .toString();
                                              String udm = _data!.data![j].type
                                                  .toString();
                                              String refill =
                                                  dateInput.text.toString();
                                              String refillQty = _qua.text;
                                              String id =
                                                  _data!.data![j].id.toString();
                                              dataList.add(DataItem(
                                                category: category,
                                                name: name,
                                                id: id,
                                                date: refill,
                                                udm: udm,
                                                quantity: refillQty,
                                              ));
                                              print(
                                                  "Details of products : $_selectedCategory, $name, $udm, $refill, $id, ${_data!.data![j].brandId}, $refillQty");
                                              Map<String, dynamic> register =
                                                  {};
                                              register['category'] =
                                                  _selectedCategory;
                                              register['product_id'] = (_data!
                                                  .data![j].id
                                                  .toString());
                                              register['amount'] =
                                                  int.parse(_qua.text);
                                              // register['date'] =
                                              //     dateInput.text.toString();
                                              item.add(register);
                                              _qua.clear();
                                              j = 0;
                                              // searchStarted = false;
                                              _sea.clear();
                                            });
                                            controller.animateTo(1);
                                          },
                                          child: Card(
                                              elevation: 0,
                                              color: const Color(0XFFE84201)
                                                  .withOpacity(.6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0), //<-- SEE HERE
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 6,
                                                    bottom: 6),
                                                child: Text(
                                                  "SAVE",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.animateTo(1);
                                          },
                                          child: Card(
                                              elevation: 0,
                                              color: const Color(0XFFE84201)
                                                  .withOpacity(.6),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0), //<-- SEE HERE
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 6,
                                                    bottom: 6),
                                                child: Text(
                                                  "NOTHING TO UPDATE",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  i == 1
                                      ? Positioned(
                                          top: 60,
                                          left: 10,
                                          right: 10,
                                          child: Container(
                                              color: Colors.white,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .8,
                                              child: ListView.builder(
                                                  physics:
                                                      const ScrollPhysics(),
                                                  itemCount:
                                                      filteredList.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            "Index Value Selected : $index");
                                                        setState(() {
                                                          j = index;
                                                          i = 0;
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          _sea.clear();
                                                        });
                                                      },
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            // searchStarted
                                                            //     ? Text(
                                                            //         searchListNew[
                                                            //             index])
                                                            //     :
                                                            Text(filteredList[
                                                                    index]
                                                                .toString()),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(), // Disable ListView's scroll
                                              shrinkWrap: true,
                                              itemCount: dataList.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Card(
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          dataList[index].name,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0XFFE84201)),
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Category   : ${dataList[index].category}"),
                                                            IconButton(
                                                              onPressed: () {
                                                                dataList
                                                                    .removeAt(
                                                                        index);
                                                                setState(() {});
                                                              },
                                                              icon: const Icon(Icons
                                                                  .delete_outline),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            "Product Name   : ${dataList[index].name}"),
                                                            
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            "Product ID   : ${dataList[index].id}"),
                                                            const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            "Refill Quantity  : ${dataList[index].quantity}"),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            "Refill Date   : ${dataList[index].date}"),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            "UOM             : ${dataList[index].udm}"),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          const SizedBox(height: 20),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {});
                                              print(
                                                  "Values to Replenish : $outletId, $outid, $item, ");
                                              ApiService.service
                                                  .addReplenishment(context,
                                                      outid, item, outletId)
                                                  .then((value) => {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Activity(
                                                                        idNav!,
                                                                        addressNav!,
                                                                        nameNav!,
                                                                        latNav!,
                                                                        longNav!,
                                                                        radNav,
                                                                        1,
                                                                        kmNav!,
                                                                        outletId!,
                                                                      )),
                                                        )
                                                      });
                                            },
                                            child: dataList.isEmpty
                                                ? Container()
                                                : Card(
                                                    elevation: 0,
                                                    color:
                                                        const Color(0XFFE84201)
                                                            .withOpacity(.6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 6,
                                                          bottom: 6),
                                                      child: Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )),
                                          ),
                                          const SizedBox(
                                              height: 20), // Add bottom padding
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
