import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rms/Employee/ActivitiesPage.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/JourneyPlan.dart';
import 'package:rms/Employee/LoginPage.dart';
import 'package:rms/Employee/TimeSheet.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/NetworkModel/DashBoardMonthly_Model.dart';
import 'package:rms/NetworkModel/DashboardDaily_Model.dart';
import 'package:rms/NetworkModel/TodayPlannedJourney_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  DashboardDailyModel? dashboardDailyModel;
  DashBoardMonthlyModel? dashBoardMonthlyModel;
  Data? data;
  String bot = "";
  MyHomePage(this.bot, {super.key});
  @override
  State<MyHomePage> createState() =>
      _MyHomePageState(dashboardDailyModel, dashBoardMonthlyModel, data, bot);
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  AppLifecycleState _appState = AppLifecycleState.inactive;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  int j = 0;
  int button = 0;
  int lengthlist = 0;
  var myList = [];
  String user = "";
  String emp = "";
  String bot = "";
  String storeName = "";
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool valuesLoaded = false;

  DashboardDailyModel? dashboardDailyModel;
  DashBoardMonthlyModel? dashBoardMonthlyModel;
  Data? data;
  Position? _currentPosition;
  TodayPlannedJourneyModel? _data;
  _MyHomePageState(DashboardDailyModel? dashboardDailyModel,
      DashBoardMonthlyModel? dashBoardMonthlyModel, this.data, this.bot);
  void _getCurrentLocation() async {
    print("In the Location Fetching function");
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      //Geolocator.openLocationSettings();
      _currentPosition = position;
    });
  }

  _gettodayplanned() {
    ApiService.service.plannedJourney(context).then((value) => {
          setState(() {
            _data = value;
            myList.addAll(_data!.data!);
            lengthlist = myList.length;
          }),
          for (var checkouttime in _data!.data!)
            {
              checkouttime.checkinTime != null &&
                      checkouttime.checkoutTime == null
                  ? showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        print(
                            "Getting the store Lat and Long : ${checkouttime.outlet!.outletLat}, ${checkouttime.outlet!.outletLong}");
                        print(
                            "The check in date of unfinished outlet : ${checkouttime.checkInTimestamp}");
                        return WillPopScope(
                          onWillPop: () async => false,
                          child: AlertDialog(
                            backgroundColor: Colors.orange[50],
                            title: const Text(
                              "Alert",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            content: const Text(
                              "You have unfinished outlet!",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0),
                                          side: const BorderSide(
                                              color: Colors.white))),
                                  backgroundColor: MaterialStateProperty.all(
                                      button == 1
                                          ? Colors.grey
                                          : const Color(0xFFF88200)),
                                ),
                                child: const Text("OK",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                                onPressed: () {
                                  setState(() {
                                    button = 1;
                                    storeName =
                                        "${checkouttime.storeCode!} - ${checkouttime.storeName!}";
                                    print(
                                        "The Store Name to be passed : $storeName");
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Activity(
                                              checkouttime.id.toString(),
                                              checkouttime.address.toString(),
                                              // checkouttime.storeName.toString(),
                                              storeName,
                                              checkouttime.outlet!.outletLat
                                                  .toString(),
                                              checkouttime.outlet!.outletLong
                                                  .toString(),
                                              double.parse(checkouttime
                                                  .outlet!.geoDistance
                                                  .toString()),
                                              j, "0",
                                              checkouttime.outletId.toString(),
                                              // checkouttime.checkInTimestamp!
                                            )),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : Container()
            },
          setState(() {
            valuesLoaded = true;
            print("Finished Loading Values");
          })
        });
  }

  _getdashboarddaily() {
    ApiService.service.dashboarddaily(context).then((value) => {
          setState(() {
            dashboardDailyModel = value;
          })
        });
  }

  void _saveLastPage(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('page', page);
  }

  _getdashboardmonthly() {
    ApiService.service.dashboardmonthly(context).then((value) => {
          setState(() {
            dashBoardMonthlyModel = value;
          })
        });
  }

  _getRequests() async {
    await _getdashboarddaily();
    _getdashboardmonthly();
    setState(() {
      bot = "1";
    });
  }

  _getversion() async {
    ApiService.service.version(context).then((value) => {});
  }

  bool _isLoaderVisible = false;
  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp = prefs1.get("id").toString();
    user = prefs1.get("user").toString();
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

  String _lastPage = '';
  void _getLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getString('page') ?? 'Dash';
    });
  }

  // Initialize connectivity status
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
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
    print("Network Check from Dash Page");
    await checkNetwork();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _saveLastPage("Dash");
    _getversion();
    _getdashboarddaily();
    _getCurrentLocation();
    _getdashboardmonthly();
    _gettodayplanned();
    loader();
    fetchNetwork();
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
      if (_lastPage == "Dash") {
        print("Calling Functions for Dash Page");
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
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 3,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => scaffoldKey.currentState?.openDrawer(),
                        child: Image.asset(
                          "images/NewRMSMenu.png",
                          width: 34,
                          height: 25,
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/rmsLogo.png",
                          width: 70,
                          height: 35,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "$user($emp) - v ${AppVersion.version}",
                          style: const TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ],
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black, width: .6),
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              i = 0;
                            });
                          },
                          child: Container(
                            decoration: i == 0
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFF88200),
                                          Color(0xFFE43700)
                                        ]),
                                  )
                                : const BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 4, bottom: 4),
                              child: Text(
                                "MTB",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        i == 0 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              i = 1;
                            });
                          },
                          child: Container(
                            decoration: i == 1
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFF88200),
                                          Color(0xFFE43700)
                                        ]),
                                  )
                                : const BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 4, bottom: 4),
                              child: Text(
                                "ToDay",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        i == 1 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: dashBoardMonthlyModel != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/Pattern.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Performance Indicators",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width * .47,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.pinkAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), //<-- SEE HERE
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Icon(
                                                Icons.call,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  i == 0
                                                      ? dashBoardMonthlyModel !=
                                                              null
                                                          ? dashBoardMonthlyModel!
                                                              .sheduleCalls
                                                              .toString()
                                                          : ""
                                                      : dashboardDailyModel!
                                                          .sheduleCalls
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Row(
                                            children: [
                                              SizedBox(
                                                width: 13,
                                              ),
                                              Text(
                                                "Scheduled Visits",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width * .47,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.greenAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), //<-- SEE HERE
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Icon(
                                                Icons.dangerous,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  i == 0
                                                      ? dashBoardMonthlyModel!
                                                          .unSheduleCalls
                                                          .toString()
                                                      : dashboardDailyModel!
                                                          .unSheduleCalls
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Row(
                                            children: [
                                              SizedBox(
                                                width: 13,
                                              ),
                                              Text(
                                                "Unscheduled Visits",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width * .47,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), //<-- SEE HERE
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Icon(
                                                Icons.call_made_outlined,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  i == 0
                                                      ? dashBoardMonthlyModel!
                                                          .sheduleCallsDone
                                                          .toString()
                                                      : dashboardDailyModel!
                                                          .sheduleCallsDone
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Row(
                                            children: [
                                              SizedBox(
                                                width: 13,
                                              ),
                                              Text(
                                                "Scheduled Visits Done",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width * .47,
                                    child: Card(
                                      elevation: 0,
                                      color: Colors.orangeAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), //<-- SEE HERE
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              const Icon(
                                                Icons.call_made_outlined,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  i == 0
                                                      ? dashBoardMonthlyModel!
                                                          .unSheduleCallsDone
                                                          .toString()
                                                      : dashboardDailyModel!
                                                          .unSheduleCallsDone
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Row(
                                            children: [
                                              SizedBox(
                                                width: 13,
                                              ),
                                              Text(
                                                "Uncheduled Visits Done",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Time Sheet",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeSheet()),
                                  );
                                },
                                child: SizedBox(
                                  height: 170,
                                  width:
                                      MediaQuery.of(context).size.width * .31,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.hand_raised_fill,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(i == 0
                                                  ? dashBoardMonthlyModel!
                                                      .attendance
                                                      .toString()
                                                  : dashboardDailyModel!
                                                      .attendance
                                                      .toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            "Your\nAttendence",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeSheet()),
                                  );
                                },
                                child: SizedBox(
                                  height: 170,
                                  width:
                                      MediaQuery.of(context).size.width * .31,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.timelapse,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                children: [
                                                  Text(i == 0
                                                      ? dashBoardMonthlyModel!
                                                          .workingTime
                                                          .toString()
                                                      : dashboardDailyModel!
                                                          .workingTime
                                                          .toString()),
                                                  const Text("---"),
                                                  Text(i == 0
                                                      ? dashBoardMonthlyModel!
                                                          .effectiveTime
                                                          .toString()
                                                      : dashboardDailyModel!
                                                          .effectiveTime
                                                          .toString()),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Working &\nEffective Time",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeSheet()),
                                  );
                                },
                                child: SizedBox(
                                  height: 170,
                                  width:
                                      MediaQuery.of(context).size.width * .31,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.time_solid,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(i == 0
                                                  ? dashBoardMonthlyModel!
                                                      .travelTime
                                                      .toString()
                                                  : dashboardDailyModel!
                                                      .travelTime
                                                      .toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          const Text(
                                            "Your Travel\nTime",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Travel Plan",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 145,
                            width: MediaQuery.of(context).size.width,
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
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                      child: Card(
                                        elevation: 1,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0), //<-- SEE HERE
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text("Completion"),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                  height: 60,
                                                  child:
                                                      CircularPercentIndicator(
                                                    radius: 30.0,
                                                    animation: true,
                                                    lineWidth: 5.0,
                                                    percent: 0.30,
                                                    center: const Text("30"),
                                                    progressColor:
                                                        Colors.pinkAccent,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .43,
                                      child: Card(
                                        elevation: 1,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0), //<-- SEE HERE
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text("Process"),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                  height: 60,
                                                  child:
                                                      CircularPercentIndicator(
                                                    radius: 30.0,
                                                    animation: true,
                                                    lineWidth: 5.0,
                                                    percent: 0.50,
                                                    center: const Text("50"),
                                                    progressColor:
                                                        Colors.orangeAccent,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Activity Performance",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 137,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.0), //<-- SEE HERE
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15, top: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 12,
                                            width: 12,
                                            color: Colors.greenAccent,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "Primary",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.6),
                                                fontSize: 14),
                                          ),
                                          const SizedBox(
                                            width: 45,
                                          ),
                                          Container(
                                            height: 12,
                                            width: 12,
                                            color: Colors.black12,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "Secondary",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.6),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Planned",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.6),
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              "Total",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.6),
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .75,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10.0,
                                          trailing: const Column(
                                            children: [
                                              Text("313"),
                                            ],
                                          ),
                                          percent: 1,
                                          //center: Text("20.0%"),
                                          linearStrokeCap: LinearStrokeCap.butt,
                                          progressColor: Colors.greenAccent,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Actual",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.6),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      //SizedBox(height:5,),
                                      SizedBox(
                                        height: 20,
                                        child: LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .75,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10,
                                          trailing: const Column(
                                            children: [
                                              //Text("Total",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 14),),
                                              Text("13"),
                                            ],
                                          ),
                                          percent: .3,
                                          //center: Text("20.0%"),
                                          linearStrokeCap: LinearStrokeCap.butt,
                                          progressColor: Colors.greenAccent,
                                          backgroundColor: Colors.black12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 110,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0XFFE84201),
                    ), //BoxDecoration
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0XFFE84201),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Menu",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(user,
                            style: const TextStyle(
                              color: Colors.white,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ) //UserAccountDrawerHeader
                    ), //DrawerHeader
                // ListTile(
                //   leading: const Icon(
                //     Icons.person,
                //     size: 25,
                //   ),
                //   title: const Text(
                //     ' Profile ',
                //     style: TextStyle(fontWeight: FontWeight.w500),
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => Profile()),
                //     );
                //   },
                // ),
                // const Divider(),
                // ListTile(
                //   leading: const Icon(Icons.calendar_month, size: 25),
                //   title: const Text(
                //     ' Logs ',
                //     style: TextStyle(fontWeight: FontWeight.w500),
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                // const Divider(),
                // ListTile(
                //   leading: const Icon(Icons.privacy_tip, size: 25),
                //   title: const Text(
                //     ' RMS Version ',
                //     style: TextStyle(fontWeight: FontWeight.w500),
                //   ),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, size: 25),
                  title: const Text(
                    'Log Out',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    var response = ApiService.service.logout(context);
                    response.then((value) => {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                            _saveLastPage("");
                          }),
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                  child: Text(
                                      "You have successfully logged out!")),
                              backgroundColor: Color(0XFFE84201),
                            ),
                          ),
                        });
                  },
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: GestureDetector(
            onTap: () {
              setState(() {
                bot == "0" ? j = 1 : j = 0;
              });
              valuesLoaded
                  ? j == 0
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JourneyPlan(0)),
                        )
                      : showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder: (BuildContext
                                    context,
                                StateSetter setState /*You can rename this!*/) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                  color: Colors.white,
                                ),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Text(
                                              "Roll Call",
                                              style: TextStyle(fontSize: 22),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Checkbox(
                                              checkColor: Colors.orange,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked,
                                              side: const BorderSide(
                                                // ======> CHANGE THE BORDER COLOR HERE <======
                                                color: Colors.grey,
                                                // Give your checkbox border a custom width
                                                width: 1.5,
                                              ),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            const Text(
                                              "Uniform & Hygiene",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Checkbox(
                                              checkColor: Colors.orange,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked1,
                                              side: const BorderSide(
                                                // ======> CHANGE THE BORDER COLOR HERE <======
                                                color: Colors.grey,
                                                // Give your checkbox border a custom width
                                                width: 1.5,
                                              ),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked1 = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            const Text(
                                              "Hand held unit charge",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Checkbox(
                                              checkColor: Colors.orange,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked2,
                                              side: const BorderSide(
                                                // ======> CHANGE THE BORDER COLOR HERE <======
                                                color: Colors.grey,
                                                // Give your checkbox border a custom width
                                                width: 1.5,
                                              ),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked2 = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            const Text(
                                              "Transport",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Checkbox(
                                              checkColor: Colors.orange,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked3,
                                              side: const BorderSide(
                                                // ======> CHANGE THE BORDER COLOR HERE <======
                                                color: Colors.grey,
                                                // Give your checkbox border a custom width
                                                width: 1.5,
                                              ),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked3 = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            const Text(
                                              "POSM",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Checkbox(
                                              checkColor: Colors.orange,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: isChecked4,
                                              side: const BorderSide(
                                                // ======> CHANGE THE BORDER COLOR HERE <======
                                                color: Colors.grey,
                                                // Give your checkbox border a custom width
                                                width: 1.5,
                                              ),
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked4 = value!;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            const Text(
                                              "Location",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            isChecked &&
                                                    isChecked1 &&
                                                    isChecked2 &&
                                                    isChecked3 &&
                                                    isChecked4 == true
                                                ? Navigator.of(context)
                                                    .push(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              JourneyPlan(0)),
                                                    )
                                                    .then((val) => val
                                                        ? _getRequests()
                                                        : null)
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    const SnackBar(
                                                      content: Center(
                                                          child: Text(
                                                              "Please confirm all check points!!!")),
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                  );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35, right: 35),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Color(0xFFF88200),
                                                      Color(0xFFE43700)
                                                    ]),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        )
                  : null;
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .85,
                  right: MediaQuery.of(context).size.width * .37,
                  left: MediaQuery.of(context).size.width * .37),
              decoration: BoxDecoration(
                  gradient: valuesLoaded
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFF88200), Color(0xFFE43700)])
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white, Colors.grey]),
                  shape: BoxShape.circle),
              child: Center(
                child: valuesLoaded
                    ? const Text(
                        "START\nDAY",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      )
                    : const Text(
                        "Please\nWait...",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          )),
    );
  }
}
