import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/AvailabilityPage.dart';
import 'package:rms/Employee/JourneyPlan.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/Employee/ReplenishItems.dart';
import 'package:rms/Employee/StockcheckPage.dart';
import 'package:rms/Employee/version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Activity extends StatefulWidget {
  String id = "";
  String address = "";
  String name = "";
  String lat = "";
  String long = "";
  final double? _desiredRadius;
  int? i;
  String km = "";
  String outletId = "";
  // String checkinTimeStamp = "";
  Activity(this.id, this.address, this.name, this.lat, this.long,
      this._desiredRadius, this.i, this.km, this.outletId,
      // this.checkinTimeStamp,
      {super.key});
  @override
  State<Activity> createState() =>
      _ActivityState(id, address, name, lat, long, _desiredRadius, i, km, outletId,
          // checkinTimeStamp
          );
}

class _ActivityState extends State<Activity> with WidgetsBindingObserver {
  AppLifecycleState _appState = AppLifecycleState.inactive;
  String idNav = "";
  String addressNav = "";
  String nameNav = "";
  String latNav = "";
  String longNav = "";
  String radiusNav = "";
  String iNav = "";
  String kmNav = "";
  String id = "";
  String address = "";
  String name = "";
  String lat = "";
  String long = "";
  String address1 = "";
  String emp = "";
  String user = "";
  String company = "";
  final double? _desiredRadius;
  double? distance;
  var checkoutResponse;
  String formattedDate = DateFormat('kk:mm:ss').format(DateTime.now());
  int? i;
  int button = 0;
  int button1 = 0;
  int button2 = 0;
  String km = "";
  String title = "Fetching Location";
  bool locFetched = false;
  bool distCalc = false;
  int lengthlist = 0;
  var myList = [];
  String storeCodeandName = "";
  String passedStoreName = "";
  String checkinStamp = "";
  String outletIdToPass = "";

  _ActivityState(
    this.id,
    this.address,
    this.name,
    this.lat,
    this.long,
    this._desiredRadius,
    this.i,
    this.km,
    this.outletIdToPass,
    // this.checkinStamp
  );
  Position? _currentPosition;

  void _saveLastPage(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('page', page);
  }

  void _saveName(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', page);
  }

  void _saveids(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ids', page);
  }

  void _saveaddress(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('desi', page);
  }

  void _saveradius(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('radius', page);
  }

  void _savelat(String page) async {
    print("Lat Val from Save Lat : $page");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lat', page);
  }

  void _savelong(String page) async {
    print("Long Val from Save Long : $page");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('long', page);
  }

  void _saveouid(String ouid) async {
    print("Long Val from Save Long : $ouid");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ouid', ouid);
  }

  bool _isLoaderVisible = false;
  loadValues() async {
    await loader();
    await _getCurrentLocation();
    setState(() {
      passedStoreName = widget.name;
    });
  }

  Future<void> loader() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    emp = prefs1.get("id").toString();
    user = prefs1.get("user").toString();
    company = (await Preference.getClient())!;
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await Future.delayed(const Duration(seconds: 1));
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
      _lastPage = prefs.getString('page') ?? "Activity";
      print("Last Page : $_lastPage");
    });
  }

  fetchAddress(double lat1, double long1) async {
    return await getAddressFromLatLng(lat1, long1);
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
    print("Network Check from Activity Page");
    await checkNetwork();
  }

  _gettodayplanned() async {
    await ApiService.service.plannedJourney(context).then((value) => {
          setState(() {
            myList.clear();
            // _data = value;
            myList.addAll(value.data!);
            lengthlist = myList.length;
            
          }),
          print("Checking the length : $lengthlist"),
          for (var store in value.data!)
            {
              setState(() {
                storeCodeandName = "${store.storeCode!} - ${store.storeName!}";
              }),
              print(
                  "From today planned : Store Code and Name - $storeCodeandName, Passed Code and Name - $passedStoreName, Outlet Id : $outletIdToPass"),
              if (storeCodeandName == passedStoreName)
                {
                  store.checkoutTime == null
                      ? setState(() {
                          checkinStamp = store.checkInTimestamp!;
                        })
                      : setState(() {
                          checkinStamp = store.checkInTimestamp!;
                        })
                }
              else
                {
                  print(" The Other Stores are ${store.storeName}"),
                }
            }
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadValues();
    ApiService.service.createlog("Activities Page Visited", true);
    print("Checking the passed store name : ${widget.name}");
    passedStoreName = widget.name;
    idNav = widget.id;
    addressNav = widget.address;
    nameNav = widget.name;
    radiusNav = widget._desiredRadius.toString();
    print("Lat Nav : $latNav");
    latNav = widget.lat;
    longNav = widget.long;
    iNav = widget.i.toString();
    kmNav = widget.km;
    _saveLastPage("Activity");
    _saveName(name);
    _saveids(id);
    _saveaddress(address);
    _saveradius(_desiredRadius.toString());
    _savelat(lat);
    _savelong(long);
    _saveouid(km);
    fetchNetwork();
    _gettodayplanned();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _appState = state;
    _getLastPage();
    _gettodayplanned();
    print("App State is : $_appState");
    if (state == AppLifecycleState.resumed) {
      // myList.clear();
      print("Calling Life Cycle Change Events");
      if (_lastPage == "Activity") {
        loadValues();
        print("Calling Functions for Activity Page");
        await Future.delayed(const Duration(seconds: 4));
        setState(() {
          fetchNetwork();
        });
        // await Future.delayed(const Duration(seconds: 4));

        // await _getCurrentLocation();
        print("Location Fetched");
        setState(() {
          print(
              "Reloaded Location Values : ${_currentPosition!.latitude}, ${_currentPosition!.longitude}");
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // Function to get current location
  _getCurrentLocation() async {
    print("Fetching Current Location");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      //Geolocator.openLocationSettings();
      _currentPosition = position;
    });
    print("Received Location");
  }

  _checkout() {
    checkoutResponse = ApiService.service
        .checkout(context, id.toString(), formattedDate, address1);
    checkoutResponse.then((value) => {
          i == 0
              ? Navigator.pop(context, true)
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => JourneyPlan(1),
                  ),
                ),
        });
  }

  // Function to calculate distance between two points
  double _calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters;
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      return address;
    } catch (e) {
      return "Unable to fetch address";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          foregroundColor: Colors.black.withOpacity(.6),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Activities",
                        style: TextStyle(
                            color: Color(0XFFE84201),
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "$user($emp) - v ${AppVersion.version}",
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontSize: 8,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.refresh,
                  //       size: 30,
                  //     )),
                ],
              ),
              _currentPosition == null
                  ? SizedBox(
                      child: Card(
                          elevation: 0,
                          color:
                              // Color(0XFFE84201).withOpacity(.9),
                              Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), //<-- SEE HERE
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 6, bottom: 6),
                            child: Text(
                              "Fetching Location...",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () async {
                        // await _getCurrentLocation();
                        ApiService.service
                            .createlog("Check Out Button Clicked", true);
                        setState(() {
                          button1 = 1;
                          print(
                              "Calculating the Distance - Initiated - ${_currentPosition!.latitude}, ${_currentPosition!.longitude}, $lat, $long");
                          distance = _calculateDistance(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                            double.parse(lat),
                            double.parse(long),
                          );
                          distance = (double.parse(distance.toString()) / 1000);
                          print("The Distancec calculated : $distance");
                        });
                        address1 = await fetchAddress(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        );

                        setState(() {
                          button1 = 0;
                        });
                        print("Calculating Distance - Done");
                        showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * .25,
                            width: MediaQuery.of(context).size.width,
                            child: AlertDialog(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              content: StatefulBuilder(
                                  // You need this, notice the parameters below:
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                print("Distancec value : $distance");
                                print("Radius Value : $_desiredRadius");
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          _currentPosition == null
                                              ? "Fetching Location"
                                              : "Check Out",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: const Color(0XFFE84201)
                                                  .withOpacity(.8)),
                                        ),
                                        const Divider(),
                                        Text(
                                            "Current Distance from the store is ${distance!.toStringAsFixed(2)} KM"),
                                        const Divider(),
                                        distance == null
                                            ? const SizedBox()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        var response = (distance! <=
                                                                (_desiredRadius! /
                                                                    1000))
                                                            ?
                                                            // _checkout()
                                                            ApiService.service
                                                                .checkout(
                                                                    context,
                                                                    id.toString(),
                                                                    formattedDate,
                                                                    address1)
                                                            : showDialog<void>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  elevation: 0,
                                                                  content: StatefulBuilder(
                                                                      // You need this, notice the parameters below:
                                                                      builder: (BuildContext context, StateSetter setState) {
                                                                    return SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .7,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          .22,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            15.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Text(
                                                                              "Location Alert!!!",
                                                                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: const Color(0XFFE84201).withOpacity(.8)),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            const Text("Distance from the store is more than the permissible limit. Please try from a location closer to the store"),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                ApiService.service.createlog("Check Out Failed due to Wrong Location...", true);
                                                                                print("The values passed to activity are : $id, $address, $name, $lat, $long, $_desiredRadius, $i");
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (BuildContext context) => Activity(
                                                                                      id, address, name, lat, long, _desiredRadius, i, km, outletIdToPass
                                                                                      // checkinStamp
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Card(
                                                                                  elevation: 0,
                                                                                  color: const Color(0XFFE84201),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                                                                                  ),
                                                                                  child: const Padding(
                                                                                    padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
                                                                                    child: Text(
                                                                                      "OK",
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ),
                                                              );
                                                        setState(() {
                                                          button = 1;
                                                        });
                                                        // MODIFICATIONS TO TEST THE NEW LOGIC OF CHECKOUT.
                                                        response
                                                            .then((value) => {
                                                                  print(
                                                                      "After getting the distance comparision response : $distance"),
                                                                  i == 0
                                                                      ? {
                                                                          print(
                                                                              "value of i is $i"),
                                                                          // Navigator.pop(
                                                                          //     context, true),
                                                                          Navigator.pop(
                                                                              context,
                                                                              true),
                                                                          Navigator.of(context)
                                                                              .pushReplacement(
                                                                            MaterialPageRoute(
                                                                              builder: (BuildContext context) => JourneyPlan(1),
                                                                            ),
                                                                          ),
                                                                        }
                                                                      : Navigator.of(
                                                                              context)
                                                                          .pushReplacement(
                                                                          MaterialPageRoute(
                                                                            builder: (BuildContext context) =>
                                                                                JourneyPlan(0),
                                                                          ),
                                                                        ),
                                                                });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Card(
                                                          elevation: 0,
                                                          color: button == 0
                                                              ? const Color(
                                                                  0XFFE84201)
                                                              : Colors.grey,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0), //<-- SEE HERE
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    top: 6,
                                                                    bottom: 6),
                                                            child: Text(
                                                              "OK",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          button1 = 0;
                                                        });
                                                        ApiService.service
                                                            .createlog(
                                                                "Check Out Failed due to Wrong Location",
                                                                true);
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: Card(
                                                          elevation: 0,
                                                          color: Colors.black12,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0), //<-- SEE HERE
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20,
                                                                    right: 20,
                                                                    top: 6,
                                                                    bottom: 6),
                                                            child: Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                      ],
                                    ));
                              }),
                            ),
                          ),
                        );
                        // if (context.mounted) {
                        //   showModalBottomSheet(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return Container(
                        //         height: 200,
                        //         color: Colors.amber,
                        //         child: Center(
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: <Widget>[
                        //               const Text('BottomSheet'),
                        //               ElevatedButton(
                        //                 child: const Text('Close BottomSheet'),
                        //                 onPressed: () {
                        //                   var response =
                        //                       (distance! <= _desiredRadius!)
                        //                           ? ApiService.service.checkout(
                        //                               context,
                        //                               id.toString(),
                        //                               formattedDate,
                        //                               address1)
                        //                           : null;
                        //                   response!.then((value) =>
                        //                       {Navigator.pop(context, true)});
                        //                 },
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   );
                        // }
                      },
                      child: Card(
                          elevation: 0,
                          color: button1 == 0
                              ? const Color(0XFFE84201).withOpacity(.9)
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), //<-- SEE HERE
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 6, bottom: 6),
                            child: Text(
                              "Check out",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home_filled,
                              size: 30,
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
                                      fontSize: 12),
                                ),
                                Text(
                                  "Check in Time Stamp : $checkinStamp",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Card(
                    elevation: 0,
                    color: Color(0XFFE84201),
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check Out Feature will not be available beyond 300\nMeter Radius from the store...",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Ensure All Activities in the store are completed before Check Out...",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                            // Text(id,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: Colors.white),),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // BELOW ROW WIDGET IS FOR TESTING. IN ACTUAL CASE THE DISPLAY SHOULD BE BASED ON THE COMPANY NAME.
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         print(
                  //             "Values to Availability Page :  Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radiusNav, Lat - $latNav, Long - $longNav, Km - $kmNav");
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => Availability(
                  //                     id,
                  //                     name,
                  //                     address,
                  //                     idNav,
                  //                     addressNav,
                  //                     nameNav,
                  //                     latNav,
                  //                     longNav,
                  //                     radiusNav,
                  //                     iNav,
                  //                     kmNav,
                  //                     // checkinStamp
                  //                   )),
                  //         );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           elevation: 0,
                  //           color: Colors.orange[100],
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.bar_chart,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Out of Stock"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Navigator.pushReplacement(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => StockCheck(
                  //         //             id,
                  //         //             km,
                  //         //             idNav,
                  //         //             addressNav,
                  //         //             nameNav,
                  //         //             latNav,
                  //         //             longNav,
                  //         //             radiusNav,
                  //         //             iNav,
                  //         //             kmNav,
                  //         //             // checkinStamp
                  //         //           )),
                  //         // );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           elevation: 0,
                  //           color: Colors.orange[100],
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.shopping_bag_outlined,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Expiry Check"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         print(
                  //             "Values to Availability Page :  Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radiusNav, Lat - $latNav, Long - $longNav, Km - $kmNav");
                  //         Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => Planogram(
                  //                   id,
                  //                   name,
                  //                   address,
                  //                   idNav,
                  //                   addressNav,
                  //                   nameNav,
                  //                   latNav,
                  //                   longNav,
                  //                   radiusNav,
                  //                   iNav,
                  //                   kmNav)),
                  //         );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           elevation: 0,
                  //           color: Colors.orange[100],
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.add_a_photo_sharp,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Planogram"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Navigator.pushReplacement(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => StockCheck(
                  //         //             id,
                  //         //             km,
                  //         //             idNav,
                  //         //             addressNav,
                  //         //             nameNav,
                  //         //             latNav,
                  //         //             longNav,
                  //         //             radiusNav,
                  //         //             iNav,
                  //         //             kmNav,
                  //         //             // checkinStamp
                  //         //           )),
                  //         // );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           color: Colors.orange[100],
                  //           elevation: 0,
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.workspace_premium_sharp,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Promotion Check"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         // print(
                  //         //     "Values to Availability Page :  Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radiusNav, Lat - $latNav, Long - $longNav, Km - $kmNav");
                  //         // Navigator.pushReplacement(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => Availability(
                  //         //             id,
                  //         //             name,
                  //         //             address,
                  //         //             idNav,
                  //         //             addressNav,
                  //         //             nameNav,
                  //         //             latNav,
                  //         //             longNav,
                  //         //             radiusNav,
                  //         //             iNav,
                  //         //             kmNav,
                  //         //             // checkinStamp
                  //         //           )),
                  //         // );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           elevation: 0,
                  //           color: Colors.orange[100],
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.info_sharp,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Competitor Info"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Navigator.pushReplacement(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => StockCheck(
                  //         //             id,
                  //         //             km,
                  //         //             idNav,
                  //         //             addressNav,
                  //         //             nameNav,
                  //         //             latNav,
                  //         //             longNav,
                  //         //             radiusNav,
                  //         //             iNav,
                  //         //             kmNav,
                  //         //             // checkinStamp
                  //         //           )),
                  //         // );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           elevation: 0,
                  //           color: Colors.orange[100],
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.checklist_sharp,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Check List"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         // print(
                  //         //     "Values to Availability Page :  Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radiusNav, Lat - $latNav, Long - $longNav, Km - $kmNav");
                  //         // Navigator.pushReplacement(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //       builder: (context) => Availability(
                  //         //             id,
                  //         //             name,
                  //         //             address,
                  //         //             idNav,
                  //         //             addressNav,
                  //         //             nameNav,
                  //         //             latNav,
                  //         //             longNav,
                  //         //             radiusNav,
                  //         //             iNav,
                  //         //             kmNav,
                  //         //             // checkinStamp
                  //         //           )),
                  //         // );
                  //       },
                  //       child: SizedBox(
                  //         height: 110,
                  //         width: MediaQuery.of(context).size.width * .45,
                  //         child: Card(
                  //           elevation: 0,
                  //           color: Colors.orange[100],
                  //           child: const Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Icon(
                  //                     Icons.shelves,
                  //                     size: 60,
                  //                   ),
                  //                   Text("Share of Shelf"),
                  //                 ],
                  //               )),
                  //         ),
                  //       ),
                  //     ),
                  //     // GestureDetector(
                  //     //   onTap: () {
                  //     //     // Navigator.pushReplacement(
                  //     //     //   context,
                  //     //     //   MaterialPageRoute(
                  //     //     //       builder: (context) => StockCheck(
                  //     //     //             id,
                  //     //     //             km,
                  //     //     //             idNav,
                  //     //     //             addressNav,
                  //     //     //             nameNav,
                  //     //     //             latNav,
                  //     //     //             longNav,
                  //     //     //             radiusNav,
                  //     //     //             iNav,
                  //     //     //             kmNav,
                  //     //     //             // checkinStamp
                  //     //     //           )),
                  //     //     // );
                  //     //   },
                  //     //   child: SizedBox(
                  //     //     height: 110,
                  //     //     width: MediaQuery.of(context).size.width * .45,
                  //     //     child: Card(
                  //     //       elevation: 0,
                  //     //       color: Colors.orange[100],
                  //     //       child: const Padding(
                  //     //           padding: EdgeInsets.all(10.0),
                  //     //           child: Column(
                  //     //             crossAxisAlignment: CrossAxisAlignment.center,
                  //     //             mainAxisAlignment: MainAxisAlignment.center,
                  //     //             children: [
                  //     //               Icon(
                  //     //                 Icons.checklist_sharp,
                  //     //                 size: 60,
                  //     //               ),
                  //     //               Text("Check List"),
                  //     //             ],
                  //     //           )),
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  // ABOVE PORTION OF CODE IS FOR TESTING PURPOSE. DO REMOVE BEFORE ACTUAL VERSION.
                  company == "COCA"
                      ? GestureDetector(
                          onTap: () {
                            print(
                                "Values to Availability Page :  Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radiusNav, Lat - $latNav, Long - $longNav, Km - $kmNav");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Availability(
                                        id,
                                        name,
                                        address,
                                        idNav,
                                        addressNav,
                                        nameNav,
                                        latNav,
                                        longNav,
                                        radiusNav,
                                        iNav,
                                        kmNav, outletIdToPass,
                                        // checkinStamp
                                      )),
                            );
                          },
                          child: SizedBox(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: const Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.bar_chart,
                                        size: 60,
                                      ),
                                      Text("Availability"),
                                    ],
                                  )),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StockCheck(
                                        id,
                                        km,
                                        idNav,
                                        addressNav,
                                        nameNav,
                                        latNav,
                                        longNav,
                                        radiusNav,
                                        iNav,
                                        kmNav, outletIdToPass,
                                        // checkinStamp
                                      )),
                            );
                          },
                          child: SizedBox(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: const Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 60,
                                      ),
                                      Text("Stock Check Details"),
                                    ],
                                  )),
                            ),
                          ),
                        ),

                  company == "COCA"
                      ? GestureDetector(
                          onTap: () {
                            print(
                                "Values to Replenish Page :  Name - $nameNav, Id - $idNav, Address - $addressNav, Radius - $radiusNav, Lat - $latNav, Long - $longNav, Km - $kmNav, Outlet Id - $outletIdToPass");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReplenishItems(
                                        id,
                                        name,
                                        address,
                                        idNav,
                                        addressNav,
                                        nameNav,
                                        latNav,
                                        longNav,
                                        radiusNav,
                                        iNav,
                                        kmNav,
                                        outletIdToPass!,
                                        // checkinStamp
                                      )),
                            );
                          },
                          child: SizedBox(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            child: const Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delivery_dining_outlined,
                                        size: 60,
                                      ),
                                      Text("Replenish Items"),
                                    ],
                                  )),
                            ),
                          ),
                        )
                      : const SizedBox(),

                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => StockCheck(
                  //                   id,
                  //                   km,
                  //                   idNav,
                  //                   addressNav,
                  //                   nameNav,
                  //                   latNav,
                  //                   longNav,
                  //                   radiusNav,
                  //                   iNav,
                  //                   kmNav,
                  //                   // checkinStamp
                  //                 )),
                  //       );
                  //     },
                  //     child: SizedBox(
                  //       height: 110,
                  //       width: MediaQuery.of(context).size.width,
                  //       child: const Card(
                  //         elevation: 0,
                  //         color: Colors.white,
                  //         child: Padding(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Column(
                  //               crossAxisAlignment:
                  //                   CrossAxisAlignment.center,
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Icon(
                  //                   Icons.shopping_bag_outlined,
                  //                   size: 60,
                  //                 ),
                  //                 Text("Stock Check Details"),
                  //               ],
                  //             )),
                  //       ),
                  //     ),
                  //   ),

                  // THE BELOW CODE IS TO ACTIVATE THE PLANOGRAM FEATURE. THE FILE IS IN FEATURES TO ADD FOLDER.
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => Planogram(
                  //               id,
                  //               name,
                  //               address,
                  //               idNav,
                  //               addressNav,
                  //               nameNav,
                  //               latNav,
                  //               longNav,
                  //               radiusNav,
                  //               iNav,
                  //               kmNav)),
                  //     );
                  //   },
                  //   child: SizedBox(
                  //     height: 110,
                  //     width: MediaQuery.of(context).size.width,
                  //     child: const Card(
                  //       elevation: 0,
                  //       color: Colors.white,
                  //       child: Padding(
                  //         padding: EdgeInsets.all(10.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.photo_camera_outlined,
                  //               size: 60,
                  //             ),
                  //             Text("Planogram"),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
