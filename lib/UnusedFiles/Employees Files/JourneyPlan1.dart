// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:rms/Employee/ApiService.dart';
// import 'package:rms/Employee/MyHomePage.dart';
// import 'package:rms/Employee/OutletDetail.dart';
// import 'package:rms/Employee/ToVisitPage.dart';
// import 'package:rms/Employee/VisitedPage.dart';
// import 'package:rms/Employee/WeekCompleted.dart';
// import 'package:rms/Employee/WeeklyjourneyPage.dart';
// import 'package:rms/Employee/YettoVisitePage.dart';
// import 'package:rms/Employee/version.dart';
// import 'package:rms/NetworkModel/SplitShift_Model.dart';
// import 'package:rms/NetworkModel/TodayPlannedJourney_Model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class JourneyPlan extends StatefulWidget {
//   Data? data;
//   SplitShiftModel? splitShiftModel;
//   int? j;
//   JourneyPlan(this.j, {super.key});
//   @override
//   State<JourneyPlan> createState() =>
//       _JourneyPlanState(data, splitShiftModel, j);
// }

// class _JourneyPlanState extends State<JourneyPlan> with WidgetsBindingObserver {
//   AppLifecycleState _appState = AppLifecycleState.inactive;
//   int i = 0;
//   int l = 0;
//   int? j;
//   int lengthlist = 0;
//   var myList = [];
//   var response;
//   String km = "";
//   String emp = "";
//   String user = "";
//   Position? _currentPosition;
//   Data? data;
//   TodayPlannedJourneyModel? _data;
//   SplitShiftModel? splitShiftModel;
//   //  late StreamSubscription<ConnectivityResult> _subscription;
//   // bool _isSnackbarActive = false;
//   List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
//   _JourneyPlanState(Data? data, SplitShiftModel? splitShiftModel, this.j);
//   _gettodayplanned() async {
//     await ApiService.service.plannedJourney(context).then((value) => {
//           setState(() {
//             myList.clear();
//             _data = value;
//             myList.addAll(_data!.data!);
//             lengthlist = myList.length;
//           })
//         });
//   }

//   _getRequests() async {
//     await _getCurrentLocation();
//     await _gettodayplanned();
//     setState(() {
//       myList = [];
//     });
//   }

//   _getversion() async {
//     ApiService.service.version(context).then((value) => {});
//   }

//   void _saveLastPage(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('page', page);
//   }

//   _getCurrentLocation() async {
//     print("Fetching Location");
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       //Geolocator.openLocationSettings();
//       _currentPosition = position;

//       print("Fetched Latitude : ${_currentPosition!.latitude}");
//       print("Fetched Longitude : ${_currentPosition!.longitude}");
//     });
//     print("Location Done..");
//   }

// // Function to calculate distance between two points
//   double _calculateDistance(double startLatitude, double startLongitude,
//       double endLatitude, double endLongitude) {
//     double distanceInMeters = Geolocator.distanceBetween(
//         startLatitude, startLongitude, endLatitude, endLongitude);
//     return distanceInMeters;
//   }

//   bool _isLoaderVisible = false;
//   Future<void> loader() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     emp = prefs1.get("id").toString();
//     user = prefs1.get("user").toString();
//     _getRequests();
//     context.loaderOverlay.show();
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//     await Future.delayed(const Duration(seconds: 4));
//     if (_isLoaderVisible) {
//       context.loaderOverlay.hide();
//     }
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//   }

//   Future<void> initConnectivity() async {
//     late List<ConnectivityResult> result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       // developer.log('Couldn\'t check connectivity status', error: e);
//       return;
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }

//     return _updateConnectionStatus(result);
//   }

//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//     // ignore: avoid_print
//     print('Connectivity changed: $_connectionStatus');
//     setState(() {
//       _connectionStatus == [ConnectivityResult.none]
//           ? showConnectivityDialog()
//           : null;
//     });
//   }

//   String _lastPage = '';
//   void _getLastPage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _lastPage = prefs.getString('page') ?? "JourneyPlan";
//       print("Last Page : $_lastPage");
//     });
//   }

//   @override
//   initState() {
//     super.initState();
//     _saveLastPage("JourneyPlan");
//     loader();
//     _getversion();
//     _gettodayplanned();
//     _getCurrentLocation();
//     WidgetsBinding.instance.addObserver(this);
//     //  _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//     //   if (result == ConnectivityResult.none) {
//     //     _showNetworkDisconnectedSnackbar();
//     //   } else {
//     //     _hideNetworkDisconnectedSnackbar();
//     //   }
//     // });
//     initConnectivity();
//     setState(() {
//       _connectivitySubscription =
//           _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     });

//     // Preference.setPage("JourneyPlan");
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     _appState = state;
//     _getLastPage();
//     print("App State is : $_appState");
//     if (state == AppLifecycleState.resumed) {
//       myList.clear();
//       // setState(() {
//       initConnectivity();
//       _connectivitySubscription =
//           _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//       // });
//       print("Calling Life Cycle Change Events");
//       _connectionStatus == [ConnectivityResult.none]
//           ? showConnectivityDialog()
//           : null;
//       if (_lastPage == "JourneyPlan") {
//         print("Calling Functions for Journey Plan Page");
//         await _gettodayplanned();
//         print("Planned JP Done..");
//         await Future.delayed(const Duration(seconds: 4));
//         await _getCurrentLocation();
//         print("Location Fetched");
//         setState(() {
//           print(
//               "Reloaded Location Values : ${_currentPosition!.latitude}, ${_currentPosition!.longitude}");
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     // _connectivitySubscription.cancel();
//   }

//   showConnectivityDialog() {
//     print("Inside the DialogBox");
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(content: StatefulBuilder(
//             // You need this, notice the parameters below:
//             builder: (BuildContext context, StateSetter setState) {
//           return SizedBox(
//             width: MediaQuery.of(context).size.width * .7,
//             height: MediaQuery.of(context).size.height * .2,
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 children: [
//                   Text(
//                     "OFFLINE",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 18,
//                         color: const Color(0XFFE84201).withOpacity(.8)),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                       "You are OFFLINE... Please Ensure Network Connectivity..."),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Card(
//                         elevation: 0,
//                         color: const Color(0XFFE84201),
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(8.0), //<-- SEE HERE
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.only(
//                               left: 20, right: 20, top: 6, bottom: 6),
//                           child: Text(
//                             "OK",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }));
//       },
//     );
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   // Future<void> initConnectivity() async {
//   //   late List<ConnectivityResult> result;
//   //   // Platform messages may fail, so we use a try/catch PlatformException.
//   //   try {
//   //     result = await _connectivity.checkConnectivity();
//   //   } on PlatformException catch (e) {
//   //     // developer.log('Couldn\'t check connectivity status', error: e);
//   //     return;
//   //   }

//   //   // If the widget was removed from the tree while the asynchronous platform
//   //   // message was in flight, we want to discard the reply rather than calling
//   //   // setState to update our non-existent appearance.
//   //   if (!mounted) {
//   //     return Future.value(null);
//   //   }

//   //   return _updateConnectionStatus(result);
//   // }

//   // Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//   //   setState(() {
//   //     _connectionStatus = result;
//   //   });
//   //   // ignore: avoid_print
//   //   print('Connectivity changed: $_connectionStatus');
//   //   setState(() {
//   //     _connectionStatus == [ConnectivityResult.none]
//   //         ? showConnectivityDialog()
//   //         : null;
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             elevation: 1,
//             foregroundColor: Colors.black.withOpacity(.6),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           j == 1
//                               ? Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(
//                                       builder: (BuildContext context) =>
//                                           MyHomePage("1")))
//                               : Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(
//                                       builder: (BuildContext context) =>
//                                           MyHomePage("1")));
//                         },
//                         icon: const Icon(Icons.arrow_back)),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Journey Plan",
//                           style: TextStyle(
//                               color: Colors.black.withOpacity(.6),
//                               fontSize: 21,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           " $user - ($emp) - v ${AppVersion.version}",
//                           style: TextStyle(
//                               color: Colors.black.withOpacity(.6),
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             actions: const [
//               // IconButton(
//               //     onPressed: () {},
//               //     icon: const Icon(
//               //       Icons.refresh,
//               //       size: 26,
//               //     )),
//             ],
//           ),
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/Pattern.png"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               i = 0;
//                             });
//                           },
//                           child: Card(
//                             elevation: 0,
//                             color:
//                                 i == 0 ? const Color(0XFFE84201) : Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(8.0), //<-- SEE HERE
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_today,
//                                     color: i == 0
//                                         ? Colors.white
//                                         : Colors.black.withOpacity(.6),
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "Today's",
//                                         style: TextStyle(
//                                             color: i == 0
//                                                 ? Colors.white
//                                                 : Colors.black.withOpacity(.6)),
//                                       ),
//                                       Text(
//                                         "Journey Plan",
//                                         style: TextStyle(
//                                             color: i == 0
//                                                 ? Colors.white
//                                                 : Colors.black.withOpacity(.6)),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               i = 1;
//                             });
//                           },
//                           child: Card(
//                             elevation: 0,
//                             color:
//                                 i == 1 ? const Color(0XFFE84201) : Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(8.0), //<-- SEE HERE
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.calendar_today,
//                                     color: i == 1
//                                         ? Colors.white
//                                         : Colors.black.withOpacity(.6),
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "Week's",
//                                         style: TextStyle(
//                                             color: i == 1
//                                                 ? Colors.white
//                                                 : Colors.black.withOpacity(.6)),
//                                       ),
//                                       Text(
//                                         "Journey Plan",
//                                         style: TextStyle(
//                                             color: i == 1
//                                                 ? Colors.white
//                                                 : Colors.black.withOpacity(.6)),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     i == 0
//                         ? Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Container(
//                                   color: Colors.white,
//                                   height: 35,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: TabBar(
//                                     indicatorColor: const Color(0XFFE84201),
//                                     labelColor: const Color(0XFFE84201),
//                                     labelStyle: TextStyle(
//                                       color: Colors.black.withOpacity(.6),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     indicatorSize: TabBarIndicatorSize.tab,
//                                     tabAlignment: TabAlignment.fill,
//                                     isScrollable: false,
//                                     tabs: [
//                                       const Tab(
//                                         text: "PLANNED",
//                                       ),
//                                       Container(
//                                         child: const Tab(
//                                           text: "YET TO VISIT",
//                                         ),
//                                       ),
//                                       const Tab(
//                                         text: "VISITED",
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * .703,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: TabBarView(
//                                   children: [
//                                     // Container(
//                                     //   height: _connectionStatus ==
//                                     //           [ConnectivityResult.none]
//                                     //       ? 25
//                                     //       : 0,
//                                     //       width: MediaQuery.of(context).size.width,
//                                     //   color: Colors.orange[300],
//                                     //   child: const Center(
//                                     //     child: Text(
//                                     //         "You are OFFLINE... Please Ensure Network Connectivity...."),
//                                     //   ),
//                                     // ),
//                                     _currentPosition != null && lengthlist != 0
//                                         ? Center(
//                                             child: ListView.builder(
//                                                 itemCount: lengthlist,
//                                                 itemBuilder:
//                                                     (BuildContext context,
//                                                         int index) {
//                                                   km = _calculateDistance(
//                                                           _currentPosition!
//                                                               .latitude,
//                                                           _currentPosition!
//                                                               .longitude,
//                                                           double.parse(_data!
//                                                                   .data!.isEmpty
//                                                               ? "0"
//                                                               : _data!
//                                                                   .data![index]
//                                                                   .outlet!
//                                                                   .outletLat
//                                                                   .toString()),
//                                                           double.parse(_data!
//                                                                   .data!.isEmpty
//                                                               ? "0"
//                                                               : _data!
//                                                                   .data![index]
//                                                                   .outlet!
//                                                                   .outletLong
//                                                                   .toString()))
//                                                       .toStringAsFixed(2);
//                                                   km = (double.parse(km) / 1000)
//                                                       .toStringAsFixed(2);
//                                                   return GestureDetector(
//                                                     onTap: () {
//                                                       response = _data!
//                                                                   .data![index]
//                                                                   .isCompleted ==
//                                                               "1"
//                                                           ? ApiService.service
//                                                               .spitshit(
//                                                                   context,
//                                                                   _data!
//                                                                       .data![
//                                                                           index]
//                                                                       .outletId
//                                                                       .toString())
//                                                           : null;
//                                                       _data!.data![index]
//                                                                   .isCompleted ==
//                                                               "1"
//                                                           ? showDialog<void>(
//                                                               context: context,
//                                                               builder: (context) =>
//                                                                   AlertDialog(
//                                                                       backgroundColor:
//                                                                           Colors
//                                                                               .white,
//                                                                       elevation:
//                                                                           0,
//                                                                       content:
//                                                                           StatefulBuilder(
//                                                                               // You need this, notice the parameters below:
//                                                                               builder: (BuildContext context,
//                                                                                   StateSetter
//                                                                                       setState) {
//                                                                         return SizedBox(
//                                                                           width:
//                                                                               MediaQuery.of(context).size.width * .7,
//                                                                           height:
//                                                                               MediaQuery.of(context).size.height * .162,
//                                                                           child:
//                                                                               Padding(
//                                                                             padding:
//                                                                                 const EdgeInsets.all(15.0),
//                                                                             child:
//                                                                                 Column(
//                                                                               children: [
//                                                                                 Text(
//                                                                                   "Split Shift",
//                                                                                   style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: const Color(0XFFE84201).withOpacity(.8)),
//                                                                                 ),
//                                                                                 const SizedBox(
//                                                                                   height: 10,
//                                                                                 ),
//                                                                                 const Text("Do you want to add Split Shift"),
//                                                                                 const SizedBox(
//                                                                                   height: 10,
//                                                                                 ),
//                                                                                 GestureDetector(
//                                                                                   onTap: () {
//                                                                                     Navigator.pop(context);
//                                                                                     print("Checking Split Shift API Response : $response");
//                                                                                     response.then((value) => {
//                                                                                           setState(() {
//                                                                                             splitShiftModel = value;
//                                                                                             print("Split Shift model Value : ${splitShiftModel!.data.toString()}");
//                                                                                             splitShiftModel!.success == true
//                                                                                                 ? Navigator.of(context)
//                                                                                                     .push(
//                                                                                                       MaterialPageRoute(
//                                                                                                         builder: (_) => OutletDetail(
//                                                                                                           _data!.data![index].storeCode.toString() + _data!.data![index].storeName.toString(),
//                                                                                                           "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
//                                                                                                           _data!.data![index].outlet!.outletLat.toString(),
//                                                                                                           _data!.data![index].outlet!.outletLong.toString(),
//                                                                                                           _data!.data![index].address.toString(),
//                                                                                                           _data!.data![index].contactNumber.toString(),
//                                                                                                           splitShiftModel!.data.toString(),
//                                                                                                           double.parse(_data!.data![index].outlet!.geoDistance.toString()),
//                                                                                                           0,
//                                                                                                           _data!.data![index].outlet!.outletId.toString(),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     )
//                                                                                                     .then((val) => val ? _getRequests() : null)
//                                                                                                 : Navigator.of(context)
//                                                                                                     .push(
//                                                                                                       MaterialPageRoute(
//                                                                                                         builder: (_) => OutletDetail(
//                                                                                                           "${_data!.data![index].storeCode} ${_data!.data![index].storeName}",
//                                                                                                           "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
//                                                                                                           _data!.data![index].outlet!.outletLat.toString(),
//                                                                                                           _data!.data![index].outlet!.outletLong.toString(),
//                                                                                                           _data!.data![index].address.toString(),
//                                                                                                           _data!.data![index].contactNumber.toString(),
//                                                                                                           // splitShiftModel!.data.toString(),
//                                                                                                           _data!.data![index].id.toString(),
//                                                                                                           double.parse(_data!.data![index].outlet!.geoDistance.toString()),
//                                                                                                           0,
//                                                                                                           _data!.data![index].outlet!.outletId.toString(),
//                                                                                                         ),
//                                                                                                       ),
//                                                                                                     )
//                                                                                                     .then((val) => val ? _getRequests() : null);
//                                                                                           })
//                                                                                         });
//                                                                                   },
//                                                                                   child: Card(
//                                                                                       elevation: 0,
//                                                                                       color: const Color(0XFFE84201),
//                                                                                       shape: RoundedRectangleBorder(
//                                                                                         borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                                                                                       ),
//                                                                                       child: const Padding(
//                                                                                         padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
//                                                                                         child: Text(
//                                                                                           "OK",
//                                                                                           style: TextStyle(color: Colors.white),
//                                                                                         ),
//                                                                                       )),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         );
//                                                                       })))
//                                                           : _data!.data![index]
//                                                                       .isCompleted ==
//                                                                   "0"
//                                                               ? Navigator.of(
//                                                                       context)
//                                                                   .push(
//                                                                     MaterialPageRoute(
//                                                                         builder: (_) =>
//                                                                             OutletDetail(
//                                                                               _data!.data![index].storeCode.toString() + _data!.data![index].storeName.toString(),
//                                                                               "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
//                                                                               _data!.data![index].outlet!.outletLat.toString(),
//                                                                               _data!.data![index].outlet!.outletLong.toString(),
//                                                                               _data!.data![index].address.toString(),
//                                                                               _data!.data![index].contactNumber.toString(),
//                                                                               _data!.data![index].id.toString(),
//                                                                               double.parse(_data!.data![index].outlet!.geoDistance.toString()),
//                                                                               0,
//                                                                               _data!.data![index].outlet!.outletId.toString(),
//                                                                             )),
//                                                                   )
//                                                                   .then((val) => val
//                                                                       ? _getRequests()
//                                                                       : null)
//                                                               : null;
//                                                     },
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 6.0),
//                                                       child: Card(
//                                                         elevation: 0,
//                                                         color: Colors.white,
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius.circular(
//                                                                   8.0), //<-- SEE HERE
//                                                         ),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Text(
//                                                                 _data!
//                                                                         .data![
//                                                                             index]
//                                                                         .storeCode
//                                                                         .toString() +
//                                                                     _data!
//                                                                         .data![
//                                                                             index]
//                                                                         .storeName
//                                                                         .toString(),
//                                                                 style: const TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w800,
//                                                                     fontSize:
//                                                                         14),
//                                                               ),
//                                                               Text(
//                                                                 "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black
//                                                                         .withOpacity(
//                                                                             .6),
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     fontSize:
//                                                                         14),
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 5,
//                                                               ),
//                                                               _data!.data![index]
//                                                                           .isCompleted ==
//                                                                       "1"
//                                                                   ? Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .end,
//                                                                       children: [
//                                                                         Card(
//                                                                             elevation:
//                                                                                 0,
//                                                                             color: const Color(
//                                                                                 0XFFE84201),
//                                                                             shape:
//                                                                                 RoundedRectangleBorder(
//                                                                               borderRadius: BorderRadius.circular(4.0), //<-- SEE HERE
//                                                                             ),
//                                                                             child:
//                                                                                 const Padding(
//                                                                               padding: EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
//                                                                               child: Text(
//                                                                                 "Split Shift",
//                                                                                 style: TextStyle(fontSize: 9, color: Colors.white),
//                                                                               ),
//                                                                             )),
//                                                                       ],
//                                                                     )
//                                                                   : Container(),
//                                                               const SizedBox(
//                                                                 height: 5,
//                                                               ),
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Container(
//                                                                         height:
//                                                                             15,
//                                                                         width:
//                                                                             15,
//                                                                         color: Colors
//                                                                             .greenAccent,
//                                                                         child:
//                                                                             const Center(
//                                                                           child:
//                                                                               Icon(
//                                                                             Icons.phone,
//                                                                             size:
//                                                                                 12,
//                                                                             color:
//                                                                                 Colors.white,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         width:
//                                                                             6,
//                                                                       ),
//                                                                       Text(
//                                                                         _data!
//                                                                             .data![index]
//                                                                             .contactNumber
//                                                                             .toString(),
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.black.withOpacity(.6),
//                                                                             fontSize: 12),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         width:
//                                                                             45,
//                                                                       ),
//                                                                       Container(
//                                                                         height:
//                                                                             15,
//                                                                         width:
//                                                                             15,
//                                                                         color: Colors
//                                                                             .blue,
//                                                                         child:
//                                                                             const Center(
//                                                                           child:
//                                                                               Icon(
//                                                                             Icons.location_on,
//                                                                             size:
//                                                                                 12,
//                                                                             color:
//                                                                                 Colors.white,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       const SizedBox(
//                                                                         width:
//                                                                             6,
//                                                                       ),
//                                                                       Text(
//                                                                         "$km KM",
//                                                                         style: TextStyle(
//                                                                             color:
//                                                                                 Colors.black.withOpacity(.6),
//                                                                             fontSize: 12),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                   _data!.data![index]
//                                                                               .isCompleted ==
//                                                                           "1"
//                                                                       ? const Padding(
//                                                                           padding:
//                                                                               EdgeInsets.only(right: 8.0),
//                                                                           child:
//                                                                               Icon(
//                                                                             Icons.check_circle_outline,
//                                                                             color:
//                                                                                 Colors.green,
//                                                                             size:
//                                                                                 20,
//                                                                           ),
//                                                                         )
//                                                                       : Container(),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }),
//                                           )
//                                         : Container(
//                                             // height: MediaQuery.of(context).size.height,
//                                             // width: MediaQuery.of(context).size.width,
//                                             child: const Center(
//                                               child: Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 18.0),
//                                                 child: Text(
//                                                   "You seem to have no active Journey Plans for the Day... Please check with your Field Manager...",
//                                                   style: TextStyle(
//                                                       color: Colors.black45),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                     _currentPosition != null
//                                         ? ToVisit(_currentPosition!.latitude,
//                                             _currentPosition!.longitude)
//                                         : Container(),
//                                     Visited(),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Container(
//                                   color: Colors.white,
//                                   height: 35,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: TabBar(
//                                     indicatorColor: const Color(0XFFE84201),
//                                     labelColor: const Color(0XFFE84201),
//                                     labelStyle: TextStyle(
//                                       color: Colors.black.withOpacity(.6),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     indicatorSize: TabBarIndicatorSize.tab,
//                                     tabAlignment: TabAlignment.fill,
//                                     isScrollable: false,
//                                     tabs: [
//                                       const Tab(
//                                         text: "PLANNED",
//                                       ),
//                                       Container(
//                                         child: const Tab(
//                                           text: "YET TO VISIT",
//                                         ),
//                                       ),
//                                       const Tab(
//                                         text: "VISITED",
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * .703,
//                                 width: MediaQuery.of(context).size.width,
//                                 child: TabBarView(
//                                   children: [
//                                     WeeklyjourneyPage(),
//                                     YettoVisit(),
//                                     WeekCompleted(),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
