import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/ActivitiesPage.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/NetworkModel/Availability_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Availability extends StatefulWidget {
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
  // String checkinNav = "";
  Availability(
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
      // this.checkinNav,
      {super.key});
  Data? data;
  @override
  State<Availability> createState() =>
      _AvailabilityState(data, timesheetid, name, address);
}

class _AvailabilityState extends State<Availability>
    with WidgetsBindingObserver {
  AppLifecycleState _appState = AppLifecycleState.inactive;
  int i = 0;
  int k = 0;
  int m = 0;

  List<int> j = [];
  String dropdownvalue = 'Category';
  String dropdownvalue1 = 'Brand';
  List<String> dropdownvalue2 = [];
  List<String> reasonValues = ['Select Reason', 'Out of Stock'];
  List<String> selectedReason = [];
  String category = '';
  String brand = '';
  final TextEditingController _sea = TextEditingController();
  String outletid = '';
  String timesheetid = '';
  String name = "";
  String address = "";
  String opmid = '';
  bool defaultSubmit = true;
  bool outOfStockMarked = false;
  List<dynamic> productid = [];
  List<dynamic> storedReasons = [];
  var brandname = [];
  var categoryname = [];
  var productname = [];
  var check = [];
  // var defaultCheck = [];
  var reason = [];
  int lengthlist = 0;
  int reasonCheck = 0;
  var myList = [];
  List<bool> light = [];
  List<String> reasonEdit = [];
  String emp = "";
  String user = "";
  Data? data;
  String? idNav;
  String? addressNav;
  String? nameNav;
  double? radNav;
  String? latNav;
  String? longNav;
  String? kmNav;
  String? checkinNav;
  AvailabilityModel? _availabilityModel;
  _AvailabilityState(Data? data, this.timesheetid, this.name, this.address);
// List of items in our dropdown menu
  List<String> items = [
    'Category',
  ];
  List<String> items12 = [];
  List<String> items123 = [];
  var items1 = [
    'Brand',
  ];
  var items2 = [
    'Select\nReason',
    'Out of Stock',
  ];
  _getavailability() async {
    await ApiService.service
        .availability(context, timesheetid)
        .then((value) => {
              setState(() {
                _availabilityModel = value;
                myList.addAll(_availabilityModel!.data!);
                lengthlist = myList.length;
                print(lengthlist);
                print("The List : ${_availabilityModel!.data![0].outletId}");
              }),
              for (int i = 0; i < lengthlist; i++)
                {
                  items12.add(_availabilityModel!.data![i].cName!),
                  !items.contains(items12.last)
                      ? items.add(items12.last)
                      : items12.clear(),
                  light.add(false),
                  dropdownvalue2 =
                      List.generate(lengthlist, (index) => 'Select\nReason'),
                  // defaultCheck = List.generate(lengthlist, (index) => 2),
                  // print("Default Check Values : $defaultCheck"),
                  reason.add(_availabilityModel!.data![i].reason),
                  productid.add(_availabilityModel!.data![i].productId),
                  productname.add(_availabilityModel!.data![i].pName),
                  brandname.add(_availabilityModel!.data![i].bName),
                  categoryname.add(_availabilityModel!.data![i].cName),
                  if (_availabilityModel!.data![i].isAvailable != null)
                    {
                      check.add(
                          int.parse(_availabilityModel!.data![i].isAvailable!)),
                      if (_availabilityModel!.data![i].reason != null)
                        {reason[i] = "Out of Stock"}
                      else
                        {reason[i] = ""}
                    }
                  else
                    {
                      check.add(1),
                      reason[i] = "",
                    }
                },
              print("The Check Value array : $check"),
              print("THe stored reasons from api : $reason"),
              print("THe reason count : ${reason.length}"),
              for (int i = 0; i < lengthlist; i++)
                {
                  items123.add(_availabilityModel!.data![i].bName!),
                  !items1.contains(items123.last)
                      ? items1.add(items123.last)
                      : items123.clear(),
                },
              for (int i = 0; i < lengthlist; i++)
                {
                  filteredList.add(
                      "${_availabilityModel!.data![i].pName} ${_availabilityModel!.data![i].zrepCode}")
                }
            });
  }

  var filteredList = [];
  var categoryList = [];
  List<String> searchList = [];
  void filterSearchResults(String query) {
    List<String> searchList = [];

    if (query.isNotEmpty) {
      print("If in Filtered List");
      for (var item in filteredList) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          searchList.add(item);
        }
      }
      setState(() {
        filteredList.clear();
        filteredList.addAll(searchList);
      });
      return;
    } else {
      print("Else in Filtered List");
      setState(() {
        filteredList.clear();
        print("Cleared Filter LIst : $filteredList");
        print("lengthlist : $lengthlist");

        for (int i = 0; i < lengthlist; i++) {
          filteredList.add(
              "${_availabilityModel!.data![i].pName} ${_availabilityModel!.data![i].zrepCode}");
        }
      });
      print("Added into Filter LIst : $filteredList");
    }
  }

  loadValues() async {
    await loader1();
  }

  Future<void> loader1() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp = prefs1.get("id").toString();
    user = prefs1.get("user").toString();
  }

  void CategoryCount(String query) {
    List<String> searchList = [];
    categoryList.clear();
    for (int i = 0; i < lengthlist; i++) {
      if (brand == ""
          ? _availabilityModel!.data![i].cName == category
          : _availabilityModel!.data![i].cName == category &&
              _availabilityModel!.data![i].bName == brand) {
        categoryList.add(
            "${_availabilityModel!.data![i].pName} ${_availabilityModel!.data![i].zrepCode}");
      }
    }
  }

  void brandCount(String query) {
    List<String> searchList = [];
    categoryList.clear();
    for (int i = 0; i < lengthlist; i++) {
      if (category == ""
          ? _availabilityModel!.data![i].bName == brand
          : _availabilityModel!.data![i].cName == category &&
              _availabilityModel!.data![i].bName == brand) {
        categoryList.add(
            "${_availabilityModel!.data![i].pName} ${_availabilityModel!.data![i].zrepCode}");
      }
    }
  }

  String _lastPage = '';
  void _getLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getString('page') ?? 'Availability';
    });
  }

  void _saveLastPage(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('page', page);
  }

  void _onChanged(bool value) {
    print(value);
    setState(() {
      if (value == false) {
        // light = false;
      } else {}
    });
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
    outletid = widget.outletId;
    loader();
    loadValues();
    _saveLastPage("Availability");
    _getavailability();
    filterSearchResults("");
    fetchNetwork();
    // Preference.setPage("JourneyPlan");
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
      if (_lastPage == "Availability") {
        print("Calling Functions for Availability Page");
        await Future.delayed(const Duration(seconds: 4));
        setState(() {
          fetchNetwork();
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
                          latNav!, longNav!, radNav!, 1, kmNav!, outletid
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
                    "Availability",
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
              Row(
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.refresh,
                  //       size: 30,
                  //     )),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        reasonCheck = 0;
                      });
                      // CODE BELOW IS FROM ORIGINAL APP

                      for (int i = 0; i < check.length; i++) {
                        print("Entered For Loop of Old Code");
                        if (check[i] == 0) {
                          if (reason[i].length > 0) {
                            setState(() {
                              reasonCheck = reasonCheck + 1;
                            });
                          } else {
                            const snackBar = SnackBar(
                                elevation: 20.00,
                                duration: Duration(seconds: 2),
                                content: Text(
                                  "Please select reason",
                                ));
                            // scaffoldKey.currentState.showSnackBar(snackBar);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            /*        Flushbar(
                            message: "Please select reason",
                            duration: Duration(seconds: 3),
                          )..show(context);*/
                          }
                        } else {
                          setState(() {
                            reasonCheck = reasonCheck + 1;
                          });
                        }
                      }
                      print(
                          "reasonChecked..$reasonCheck..Avaiablity.reason...${reason.length}..Avaiablity.checkvalue..${check.length}");

                      if (reasonCheck == reason.length) {
                        print("Outlet Id Value Passed : $outletid");
                        print("Timesheet Id Value Passed : $timesheetid");
                        print("OPM Value Passed : $opmid");
                        print("Brand Value Passed : $brandname");
                        print("Category Value Passed : $categoryname");
                        print("Product Name Value Passed : $productname");
                        print("Check Value Passed : $check");
                        print("Check Value Count : ${check.length}");
                        print("Reason Value Passed : $reason");
                        print("Reason Value Count : ${reason.length}");
                      }
                      // ABOVE CODE IS FOR UNDERSTANDING
                      print("Exited For Loop of Old Code");
                      print("Outlet Id Value Passed : $outletid");
                      print("Timesheet Id Value Passed : $timesheetid");
                      print("OPM Value Passed : $opmid");
                      print("Product Id Value Count : ${productid.length}");
                      print("PID Value Count : ${productid.length}");
                      print("Brand Value Passed : $brandname");
                      print("Brand Value Count : ${brandname.length}");
                      print("Category Value Passed : $categoryname");
                      print("Category Value Count : ${categoryname.length}");
                      print("Product Name Value Passed : $productname");
                      print("Product Value Count : ${productname.length}");
                      print("Check Value Passed : $check");
                      print("Check Value Count : ${check.length}");
                      print("Reason Value Passed : $reason");
                      print("Reason Value Count : ${reason.length}");
                      print("Value of Out of Stock Marked : $outOfStockMarked");

                      if (!outOfStockMarked) {
                        outletid =
                            _availabilityModel!.data![0].outletId.toString();
                        timesheetid =
                            _availabilityModel!.data![0].id.toString();
                        opmid = _availabilityModel!.data![0].opm.toString();
                        productid[0] = (_availabilityModel!.data![0].productId);
                        brandname[0] = (_availabilityModel!.data![0].bName);
                        categoryname[0] = (_availabilityModel!.data![0].cName);
                        productname[0] = (_availabilityModel!.data![0].pName);
                        check[0] = 2;
                        reason[0] = "In Stock";
                      }

                      print(
                          "Testing the changed values : 0, Product Name : ${productname[0]}, Check Value : ${check[0]}, Reason : ${reason[0]} ");

                      ApiService.service
                          .addavailability(
                              context,
                              outletid,
                              timesheetid,
                              opmid,
                              productid,
                              brandname,
                              categoryname,
                              productname,
                              check,
                              reason)
                          .then((value) => {
                                // Navigator.pop(context, true)
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Activity(
                                            idNav!,
                                            addressNav!,
                                            nameNav!,
                                            latNav!,
                                            longNav!,
                                            radNav,
                                            1,
                                            kmNav!, outletid,
                                            // checkinNav!
                                          )),
                                )
                              });
                    },
                    child: Card(
                        elevation: 0,
                        color: const Color(0XFFE84201).withOpacity(.6),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), //<-- SEE HERE
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 6, bottom: 6),
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Pattern.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.home_filled,
                                  size: 40,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      address,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.6),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 0,
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .46,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // Initial Value
                                        value: dropdownvalue,

                                        // Down Arrow Icon
                                        icon: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .01),
                                          child: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            size: 25,
                                            color: Color(0XFFE84201),
                                          ),
                                        ),

                                        // Array list of items
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .32,
                                              child: Text(
                                                softWrap: true,
                                                items,
                                                style: TextStyle(
                                                    fontSize: items.length > 12
                                                        ? 13
                                                        : 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                            // setState(() {
                                            category = dropdownvalue;
                                            category == "Category"
                                                ? m = 0
                                                : m = 1;
                                            // });
                                            CategoryCount(category);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .46,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // Initial Value
                                        value: dropdownvalue1,

                                        // Down Arrow Icon
                                        icon: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .01),
                                          child: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            size: 25,
                                            color: Color(0XFFE84201),
                                          ),
                                        ),

                                        // Array list of items
                                        items: items1.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue1 = newValue!;
                                            setState(() {
                                              brand = dropdownvalue1;
                                              brand == "Brand" ? m = 0 : m = 1;
                                            });
                                            brandCount(brand);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color: Colors.white,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _sea,
                                  cursorColor: const Color(0XFFE84201),
                                  style:
                                      const TextStyle(color: Color(0XFFE84201)),
                                  decoration: InputDecoration(
                                    hintText:
                                        "Search by product name/ZERP code",
                                    hintStyle: const TextStyle(
                                        color: Colors.black38, fontSize: 12),
                                    border: InputBorder.none,
                                    // prefixIcon: Icon(Icons.search,color:Color(0XFFE84201)),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            k = 0;
                                            _sea.clear();
                                            filteredList.clear();
                                            FocusScope.of(context).unfocus();
                                          });
                                        },
                                        child: const Icon(Icons.clear,
                                            color: Color(0XFFE84201))),
                                  ),
                                  onChanged: (value) {
                                    filterSearchResults(value);
                                  },
                                  onTap: () {
                                    setState(() {
                                      k = 1;
                                    });
                                  },
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 0,
                          color: const Color(0XFFE84201).withOpacity(.2),
                          child: Column(
                            children: [
                              // Container(
                              //   height: 50,
                              //   decoration: BoxDecoration(

                              //     borderRadius: const BorderRadius.all(
                              //         Radius.circular(9)),
                              //     color: Colors.orange[100],
                              //   ),
                              //   child: CheckboxListTile(
                              //     title: const Text(
                              //         'Select if all items are in stock'),
                              //     value: false,
                              //     onChanged: (val) {},
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9)),
                                  color: Color(0XFFE84201),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Item/Description",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      Text(
                                        "Avl",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    k == 1
                                        ? SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .5,
                                            child: ListView.builder(
                                                itemCount: filteredList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  setState(() {
                                                    light[index] == true
                                                        ? reason
                                                            .add("Out of Stock")
                                                        : reason.add(
                                                            _availabilityModel!
                                                                .data![index]
                                                                .reason);
                                                  });
                                                  print(filteredList.length);
                                                  return SingleChildScrollView(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .42,
                                                            height: 60,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                right:
                                                                    BorderSide(
                                                                  //                   <--- left side
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.0,
                                                                ),
                                                                bottom:
                                                                    BorderSide(
                                                                  //                    <--- top side
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 5,
                                                                      bottom: 5,
                                                                      top: 5),
                                                              child: Text(
                                                                filteredList[
                                                                        index]
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            )),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .2,
                                                          height: 60,
                                                          decoration:
                                                              const BoxDecoration(
                                                            border: Border(
                                                              right: BorderSide(
                                                                //                   <--- left side
                                                                color: Colors
                                                                    .black,
                                                                width: 1.0,
                                                              ),
                                                              bottom:
                                                                  BorderSide(
                                                                //                    <--- top side
                                                                color: Colors
                                                                    .black,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Switch(
                                                            // This bool value toggles the switch.
                                                            value: light[index],
                                                            activeColor:
                                                                Colors.red,
                                                            inactiveThumbColor:
                                                                Colors.white,
                                                            inactiveTrackColor:
                                                                Colors.green,
                                                            onChanged:
                                                                (bool value) {
                                                              print(
                                                                  "Value of Light : $value");
                                                              // This is called when the user toggles the switch.
                                                              setState(() {
                                                                light[index] ==
                                                                        true
                                                                    ? j.remove(
                                                                        index)
                                                                    : j.add(
                                                                        index);
                                                                j.contains(
                                                                        index)
                                                                    ? light[index] =
                                                                        true
                                                                    : light[index] =
                                                                        false;
                                                                //_onChanged(value);
                                                                // light[index] == true ? dropdownvalue2 = 'Select\nReason' : dropdownvalue2 = 'Select\nReason';
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .235,
                                                          height: 60,
                                                          decoration:
                                                              const BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                //
                                                                color: Colors
                                                                    .black,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                          ),
                                                          child:
                                                              DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton(
                                                              // Initial Value
                                                              value:
                                                                  // reason[index] != '' ? reason[index] : reasonValues[0],
                                                                  dropdownvalue2[
                                                                      index],
                                                              //  light[index] == true ? dropdownvalue2 = 'Select\nReason' : dropdownvalue2 = 'Select\nReason',

                                                              // Down Arrow Icon
                                                              icon: light[index] ==
                                                                      true
                                                                  ? const Icon(
                                                                      Icons
                                                                          .arrow_drop_down_sharp,
                                                                      size: 18,
                                                                      color: Color(
                                                                          0XFFE84201),
                                                                    )
                                                                  : Container(),

                                                              // Array list of items
                                                              items: items2.map(
                                                                  (String
                                                                      items) {
                                                                return DropdownMenuItem(
                                                                  value: items,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            5.0),
                                                                    child: light[index] ==
                                                                            true
                                                                        ? Text(
                                                                            items,
                                                                            style:
                                                                                const TextStyle(fontSize: 12),
                                                                          )
                                                                        : Container(),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              // After selecting the desired option,it will
                                                              // change button value to selected value
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownvalue2[
                                                                          index] =
                                                                      newValue!;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          )
                                        : m == 1
                                            ? SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .5,
                                                child: ListView.builder(
                                                    itemCount:
                                                        categoryList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return SingleChildScrollView(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .42,
                                                                height: 60,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    right:
                                                                        BorderSide(
                                                                      //                   <--- left side
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    bottom:
                                                                        BorderSide(
                                                                      //                    <--- top side
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          top:
                                                                              5),
                                                                  child: Text(
                                                                    categoryList[
                                                                            index] +
                                                                        "chgjjg",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                )),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .2,
                                                              height: 60,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                    //                   <--- left side
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0,
                                                                  ),
                                                                  bottom:
                                                                      BorderSide(
                                                                    //                    <--- top side
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Switch(
                                                                // This bool value toggles the switch.
                                                                value: light[
                                                                    index],
                                                                activeColor:
                                                                    Colors.red,
                                                                inactiveThumbColor:
                                                                    Colors
                                                                        .white,
                                                                inactiveTrackColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged: (bool
                                                                    value) {
                                                                  print(
                                                                      "Value of Light : $value");
                                                                  // This is called when the user toggles the switch.
                                                                  setState(() {
                                                                    light[index] ==
                                                                            true
                                                                        ? j.remove(
                                                                            index)
                                                                        : j.add(
                                                                            index);
                                                                    j.contains(
                                                                            index)
                                                                        ? light[index] =
                                                                            true
                                                                        : light[index] =
                                                                            false;
                                                                    //_onChanged(value);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .235,
                                                              height: 60,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    //
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              child:
                                                                  DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton(
                                                                  // Initial Value
                                                                  value:
                                                                      dropdownvalue2[
                                                                          index],

                                                                  // Down Arrow Icon
                                                                  icon: light[index] ==
                                                                          true
                                                                      ? const Icon(
                                                                          Icons
                                                                              .arrow_drop_down_sharp,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Color(0XFFE84201),
                                                                        )
                                                                      : Container(),

                                                                  // Array list of items
                                                                  items: items2
                                                                      .map((String
                                                                          items) {
                                                                    return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5.0),
                                                                        child: light[index] ==
                                                                                true
                                                                            ? Text(
                                                                                items,
                                                                                style: const TextStyle(fontSize: 12),
                                                                              )
                                                                            : Container(),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  // After selecting the desired option,it will
                                                                  // change button value to selected value
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(
                                                                        () {
                                                                      dropdownvalue2[
                                                                              index] =
                                                                          newValue!;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              )
                                            : SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .5,
                                                child: ListView.builder(
                                                    itemCount: k == 1
                                                        ? filteredList.length
                                                        : lengthlist,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      // print(
                                                      //     " The Avail Value Resp : ${_availabilityModel!.data![index].isAvailable}");
                                                      // print(
                                                      //     " The Reason Value Resp : $reason");
                                                      // outletid = _availabilityModel!
                                                      //     .data![index].outletId
                                                      //     .toString();
                                                      // timesheetid =
                                                      //     _availabilityModel!
                                                      //         .data![index].id
                                                      //         .toString();
                                                      // opmid = _availabilityModel!
                                                      //     .data![index].opm
                                                      //     .toString();
                                                      // productid.add(
                                                      //     _availabilityModel!
                                                      //         .data![index]
                                                      //         .productId);
                                                      // brandname.add(
                                                      //     _availabilityModel!
                                                      //         .data![index].bName);
                                                      // categoryname.add(
                                                      //     _availabilityModel!
                                                      //         .data![index].cName);
                                                      // productname.add(
                                                      //     _availabilityModel!
                                                      //         .data![index].pName);
                                                      // check.add((_availabilityModel!
                                                      //     .data![index].isAvailable));
                                                      // //filteredList.add(_availabilityModel!.data![index].pName.toString()+" "+_availabilityModel!.data![index].zrepCode.toString());
                                                      // light[index] == true
                                                      //     ? reason.add("Out of Stock")
                                                      //     : reason.add(
                                                      //         _availabilityModel!
                                                      //             .data![index]
                                                      //             .reason);
                                                      print(
                                                          filteredList.length);
                                                      return SingleChildScrollView(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .42,
                                                                height: 60,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    right:
                                                                        BorderSide(
                                                                      //                   <--- left side
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    bottom:
                                                                        BorderSide(
                                                                      //                    <--- top side
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          top:
                                                                              5),
                                                                  child: Text(
                                                                    "${_availabilityModel!.data![index].pName} ${_availabilityModel!.data![index].zrepCode}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                )),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .2,
                                                              height: 60,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  right:
                                                                      BorderSide(
                                                                    //                   <--- left side
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0,
                                                                  ),
                                                                  bottom:
                                                                      BorderSide(
                                                                    //                    <--- top side
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              child: Switch(
                                                                // This bool value toggles the switch.
                                                                value: light[
                                                                    index],
                                                                activeColor:
                                                                    Colors.red,
                                                                inactiveThumbColor:
                                                                    Colors
                                                                        .white,
                                                                inactiveTrackColor:
                                                                    Colors
                                                                        .green,
                                                                onChanged: (bool
                                                                    value) {
                                                                  print(
                                                                      "Value of Light : $value");
                                                                  // This is called when the user toggles the switch.
                                                                  setState(() {
                                                                    light[index] ==
                                                                            true
                                                                        ? j.remove(
                                                                            index)
                                                                        : j.add(
                                                                            index);
                                                                    j.contains(
                                                                            index)
                                                                        ? light[index] =
                                                                            true
                                                                        : light[index] =
                                                                            false;
                                                                    //_onChanged(value);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .238,
                                                              height: 60,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    //
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              child:
                                                                  DropdownButtonHideUnderline(
                                                                child:
                                                                    DropdownButton(
                                                                  // Initial Value
                                                                  value:
                                                                      dropdownvalue2[
                                                                          index],

                                                                  // Down Arrow Icon
                                                                  icon: light[index] ==
                                                                          true
                                                                      ? const Icon(
                                                                          Icons
                                                                              .arrow_drop_down_sharp,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Color(0XFFE84201),
                                                                        )
                                                                      : Container(),

                                                                  // Array list of items
                                                                  items: items2
                                                                      .map((String
                                                                          items) {
                                                                    return DropdownMenuItem(
                                                                      value:
                                                                          items,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5.0),
                                                                        child: light[index] ==
                                                                                true
                                                                            ? Text(
                                                                                items,
                                                                                style: const TextStyle(fontSize: 12),
                                                                              )
                                                                            : Container(),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  // After selecting the desired option,it will
                                                                  // change button value to selected value
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(
                                                                        () {
                                                                      outOfStockMarked =
                                                                          true;
                                                                      dropdownvalue2[
                                                                              index] =
                                                                          newValue!;
                                                                      print(
                                                                          "The Changed DropDown Value : $dropdownvalue2");
                                                                      print(
                                                                          "The Check value : ${_availabilityModel!.data![index].pName} - ${_availabilityModel!.data![index].reason}");
                                                                      print(
                                                                          "The producut name is : ${productname[index]}");
                                                                      outletid = _availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .outletId
                                                                          .toString();
                                                                      timesheetid = _availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString();
                                                                      opmid = _availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .opm
                                                                          .toString();
                                                                      productid[index] = (_availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .productId);
                                                                      brandname[index] = (_availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .bName);
                                                                      categoryname[index] = (_availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .cName);
                                                                      productname[index] = (_availabilityModel!
                                                                          .data![
                                                                              index]
                                                                          .pName);
                                                                      check[index] =
                                                                          0;
                                                                      reason[index] =
                                                                          "Out of Stock";

                                                                      print(
                                                                          "Testing the changed values : $index, Product Name : ${productname[index]}, Check Value : ${check[index]}, Reason : ${reason[index]} ");
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }
}

class Item {
  final int id;
  final String name;
  bool isToggled;
  String? selectedReason;

  Item({
    required this.id,
    required this.name,
    this.isToggled = false,
    this.selectedReason,
  });
}
