// import 'package:flutter/material.dart';
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
//   bool _isLocationFetching = false;
//   Data? data;
//   TodayPlannedJourneyModel? _data;
//   SplitShiftModel? splitShiftModel;

//   _JourneyPlanState(Data? data, SplitShiftModel? splitShiftModel, this.j);
//   _gettodayplanned() async {
//     print("Journey Plan Fetching");
//     await ApiService.service.plannedJourney(context).then((value) => {
//           setState(() {
//             _data = value;
//             myList.addAll(_data!.data!);
//             lengthlist = myList.length;
//             print("$lengthlist");
//           })
//         });
//     print("Journey Plan Done");
//   }

//   _getRequests() async {
//     print("Fetching Requests");
//     await _gettodayplanned();

//     setState(() {
//       myList = [];
//     });
//   }

//   reloadVals() async {
//     print("Reloading Values");
//     print("Journey Plan Fetching Directly");
//     // await ApiService.service.plannedJourney(context).then((value) => {
//     //       setState(() {
//     //         myList.clear();
//     //         _data = value;
//     //         myList.addAll(_data!.data!);
//     //         lengthlist = myList.length;
//     //       })
//     //     });
//     // await _getCurrentLocation();
//     print("Journey Plan Done...");
//   }

//   void _saveLastPage(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('page', page);
//   }

 
//   _getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     Position position = await Geolocator.getCurrentPosition(
//         forceAndroidLocationManager: false,
//         desiredAccuracy: LocationAccuracy.high);

    

//     setState(() {
//       //Geolocator.openLocationSettings();
//       _currentPosition = position;
//       print("Latitude : ${_currentPosition!.latitude}");
//       print("Longitude : ${_currentPosition!.longitude}");
//     });
//   }

//   reloadLoaction() async {
//     print("Fetching Location from reload");
//     // LocationPermission permission = await Geolocator.requestPermission();
//     Position position = await Geolocator.getCurrentPosition(
//         forceAndroidLocationManager: false,
//         desiredAccuracy: LocationAccuracy.high);

//     setState(() {
//       //Geolocator.openLocationSettings();
//       _currentPosition = position;
//       print("Latitude Received : ${_currentPosition!.latitude}");
//       print("Longitude Received : ${_currentPosition!.longitude}");
//       print("Location Received");
//     });

//     print("Calculating Distance");
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

//   @override
//   initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     loader();
//     _gettodayplanned();
//     _saveLastPage("JourneyPlan");
//     _getCurrentLocation();

//     // Preference.setPage("JourneyPlan");
//   }

//   // To be executed whne app returns from Background
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     _appState = state;
//     print("App State is : $_appState");
//     if (state == AppLifecycleState.resumed && !_isLocationFetching) {
//       print("Calling Life Cycle Change Events");
//       // Position updatedPosition = await _locationCompleter.future;
//       // await reloadVals();
//       // await reloadLoaction();

//       _isLocationFetching =
//           true; // Set flag to true to indicate location fetch is in progress
//       await Future.delayed(Duration(seconds: 3));
//       await _getCurrentLocation(); // Reload the current location
//       // setState(() {
//       //   print("Updating Location...");
//       //   _currentPosition = updatedPosition;
//       //   print("Location Updated");
//       // });
//       _isLocationFetching = false;

//       // Reload your page here
//       // This will be called when the app comes to the foreground
//       // setState(() {
//       // });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 1,
//           foregroundColor: Colors.black.withOpacity(.6),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         j == 1
//                             ? Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         MyHomePage("1")))
//                             : Navigator.pop(context, true);
//                       },
//                       icon: const Icon(Icons.arrow_back)),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Journey Plan",
//                         style: TextStyle(
//                             color: Colors.black.withOpacity(.6),
//                             fontSize: 21,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         "$user($emp)",
//                         style: TextStyle(
//                             color: Colors.black.withOpacity(.6),
//                             fontSize: 8,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.refresh,
//                   size: 26,
//                 )),
//           ],
//         ),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("images/Pattern.png"),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           i = 0;
//                         });
//                       },
//                       child: Card(
//                         elevation: 0,
//                         color: i == 0 ? const Color(0XFFE84201) : Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(8.0), //<-- SEE HERE
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.calendar_today,
//                                 color: i == 0
//                                     ? Colors.white
//                                     : Colors.black.withOpacity(.6),
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     "Today's",
//                                     style: TextStyle(
//                                         color: i == 0
//                                             ? Colors.white
//                                             : Colors.black.withOpacity(.6)),
//                                   ),
//                                   Text(
//                                     "Journey Plan",
//                                     style: TextStyle(
//                                         color: i == 0
//                                             ? Colors.white
//                                             : Colors.black.withOpacity(.6)),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           i = 1;
//                         });
//                       },
//                       child: Card(
//                         elevation: 0,
//                         color: i == 1 ? const Color(0XFFE84201) : Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(8.0), //<-- SEE HERE
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.calendar_today,
//                                 color: i == 1
//                                     ? Colors.white
//                                     : Colors.black.withOpacity(.6),
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     "Week's",
//                                     style: TextStyle(
//                                         color: i == 1
//                                             ? Colors.white
//                                             : Colors.black.withOpacity(.6)),
//                                   ),
//                                   Text(
//                                     "Journey Plan",
//                                     style: TextStyle(
//                                         color: i == 1
//                                             ? Colors.white
//                                             : Colors.black.withOpacity(.6)),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 i == 0
//                     ? Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               color: Colors.white,
//                               height: 35,
//                               width: MediaQuery.of(context).size.width,
//                               child: TabBar(
//                                 indicatorColor: const Color(0XFFE84201),
//                                 labelColor: const Color(0XFFE84201),
//                                 labelStyle: TextStyle(
//                                   color: Colors.black.withOpacity(.6),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 tabAlignment: TabAlignment.fill,
//                                 isScrollable: false,
//                                 tabs: [
//                                   const Tab(
//                                     text: "PLANNED",
//                                   ),
//                                   Container(
//                                     child: const Tab(
//                                       text: "YET TO VISIT",
//                                     ),
//                                   ),
//                                   const Tab(
//                                     text: "VISITED",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .703,
//                             width: MediaQuery.of(context).size.width,
//                             child: TabBarView(
//                               children: [
//                                 _currentPosition != null
//                                     ? Center(
//                                         child: ListView.builder(
//                                             itemCount: lengthlist,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               print("Index : $index");
//                                               km = _calculateDistance(
//                                                       _currentPosition!
//                                                           .latitude,
//                                                       _currentPosition!
//                                                           .longitude,
//                                                       double.parse(
//                                                           _data!.data!.isEmpty
//                                                               ? "0"
//                                                               : _data!
//                                                                   .data![index]
//                                                                   .outlet!
//                                                                   .outletLat
//                                                                   .toString()),
//                                                       double.parse(
//                                                           _data!.data!.isEmpty
//                                                               ? "0"
//                                                               : _data!
//                                                                   .data![index]
//                                                                   .outlet!
//                                                                   .outletLong
//                                                                   .toString()))
//                                                   .toStringAsFixed(2);
//                                               km = (double.parse(km) / 1000)
//                                                   .toStringAsFixed(2);
//                                               return GestureDetector(
//                                                 onTap: () {
//                                                   response = _data!.data![index]
//                                                               .isCompleted ==
//                                                           "1"
//                                                       ? ApiService.service
//                                                           .spitshit(
//                                                               context,
//                                                               _data!
//                                                                   .data![index]
//                                                                   .outletId
//                                                                   .toString())
//                                                       : null;
//                                                   _data!.data![index]
//                                                               .isCompleted ==
//                                                           "1"
//                                                       ? showDialog<void>(
//                                                           context: context,
//                                                           builder: (context) =>
//                                                               AlertDialog(
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .white,
//                                                                   elevation: 0,
//                                                                   content:
//                                                                       StatefulBuilder(
//                                                                           // You need this, notice the parameters below:
//                                                                           builder: (BuildContext context,
//                                                                               StateSetter
//                                                                                   setState) {
//                                                                     return SizedBox(
//                                                                       width: MediaQuery.of(context)
//                                                                               .size
//                                                                               .width *
//                                                                           .7,
//                                                                       height: MediaQuery.of(context)
//                                                                               .size
//                                                                               .height *
//                                                                           .162,
//                                                                       child:
//                                                                           Padding(
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             15.0),
//                                                                         child:
//                                                                             Column(
//                                                                           children: [
//                                                                             Text(
//                                                                               "Split Shift",
//                                                                               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: const Color(0XFFE84201).withOpacity(.8)),
//                                                                             ),
//                                                                             const SizedBox(
//                                                                               height: 10,
//                                                                             ),
//                                                                             const Text("Do you want to add Split Shift"),
//                                                                             const SizedBox(
//                                                                               height: 10,
//                                                                             ),
//                                                                             GestureDetector(
//                                                                               onTap: () {
//                                                                                 Navigator.pop(context);
//                                                                                 response.then((value) => {
//                                                                                       setState(() {
//                                                                                         splitShiftModel = value;
//                                                                                         splitShiftModel!.success == true
//                                                                                             ? Navigator.of(context)
//                                                                                                 .push(
//                                                                                                   MaterialPageRoute(builder: (_) => OutletDetail(_data!.data![index].storeCode.toString() + _data!.data![index].storeName.toString(), "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}", _data!.data![index].outlet!.outletLat.toString(), _data!.data![index].outlet!.outletLong.toString(), _data!.data![index].address.toString(), _data!.data![index].contactNumber.toString(), splitShiftModel!.data.toString(), double.parse(_data!.data![index].outlet!.geoDistance.toString()), 0, km)),
//                                                                                                 )
//                                                                                                 .then((val) => val ? _getRequests() : null)
//                                                                                             : Navigator.of(context)
//                                                                                                 .push(
//                                                                                                   MaterialPageRoute(builder: (_) => OutletDetail(_data!.data![index].storeCode.toString() + _data!.data![index].storeName.toString(), "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}", _data!.data![index].outlet!.outletLat.toString(), _data!.data![index].outlet!.outletLong.toString(), _data!.data![index].address.toString(), _data!.data![index].contactNumber.toString(), splitShiftModel!.data.toString(), double.parse(_data!.data![index].outlet!.geoDistance.toString()), 0, km)),
//                                                                                                 )
//                                                                                                 .then((val) => val ? _getRequests() : null);
//                                                                                       })
//                                                                                     });
//                                                                               },
//                                                                               child: Card(
//                                                                                   elevation: 0,
//                                                                                   color: const Color(0XFFE84201),
//                                                                                   shape: RoundedRectangleBorder(
//                                                                                     borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                                                                                   ),
//                                                                                   child: const Padding(
//                                                                                     padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
//                                                                                     child: Text(
//                                                                                       "OK",
//                                                                                       style: TextStyle(color: Colors.white),
//                                                                                     ),
//                                                                                   )),
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     );
//                                                                   })))
//                                                       : _data!.data![index]
//                                                                   .isCompleted ==
//                                                               "0"
//                                                           ? Navigator.of(
//                                                                   context)
//                                                               .push(
//                                                                 MaterialPageRoute(
//                                                                     builder: (_) => OutletDetail(
//                                                                         _data!.data![index].storeCode.toString() +
//                                                                             _data!.data![index].storeName
//                                                                                 .toString(),
//                                                                         "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
//                                                                         _data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .outlet!
//                                                                             .outletLat
//                                                                             .toString(),
//                                                                         _data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .outlet!
//                                                                             .outletLong
//                                                                             .toString(),
//                                                                         _data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .address
//                                                                             .toString(),
//                                                                         _data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contactNumber
//                                                                             .toString(),
//                                                                         _data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .id
//                                                                             .toString(),
//                                                                         double.parse(_data!
//                                                                             .data![index]
//                                                                             .outlet!
//                                                                             .geoDistance
//                                                                             .toString()),
//                                                                         0,
//                                                                         km)),
//                                                               )
//                                                               .then((val) => val
//                                                                   ? _getRequests()
//                                                                   : null)
//                                                           : null;
//                                                 },
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 6.0),
//                                                   child: Card(
//                                                     elevation: 0,
//                                                     color: Colors.white,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               8.0), //<-- SEE HERE
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         children: [
//                                                           Text(
//                                                             _data!.data![index]
//                                                                     .storeCode
//                                                                     .toString() +
//                                                                 _data!
//                                                                     .data![
//                                                                         index]
//                                                                     .storeName
//                                                                     .toString(),
//                                                             style: const TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w800,
//                                                                 fontSize: 14),
//                                                           ),
//                                                           Text(
//                                                             "${_data!.data![index].outlet!.outletArea}  ${_data!.data![index].outlet!.outletCity}  ${_data!.data![index].outlet!.outletCountry}",
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .black
//                                                                     .withOpacity(
//                                                                         .6),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontSize: 14),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 5,
//                                                           ),
//                                                           _data!.data![index]
//                                                                       .isCompleted ==
//                                                                   "1"
//                                                               ? Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .end,
//                                                                   children: [
//                                                                     Card(
//                                                                         elevation:
//                                                                             0,
//                                                                         color: const Color(
//                                                                             0XFFE84201),
//                                                                         shape:
//                                                                             RoundedRectangleBorder(
//                                                                           borderRadius:
//                                                                               BorderRadius.circular(4.0), //<-- SEE HERE
//                                                                         ),
//                                                                         child:
//                                                                             const Padding(
//                                                                           padding: EdgeInsets.only(
//                                                                               left: 8.0,
//                                                                               right: 8,
//                                                                               top: 2,
//                                                                               bottom: 2),
//                                                                           child:
//                                                                               Text(
//                                                                             "Split Shift",
//                                                                             style:
//                                                                                 TextStyle(fontSize: 9, color: Colors.white),
//                                                                           ),
//                                                                         )),
//                                                                   ],
//                                                                 )
//                                                               : Container(),
//                                                           const SizedBox(
//                                                             height: 5,
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             children: [
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Container(
//                                                                     height: 15,
//                                                                     width: 15,
//                                                                     color: Colors
//                                                                         .greenAccent,
//                                                                     child:
//                                                                         const Center(
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .phone,
//                                                                         size:
//                                                                             12,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 6,
//                                                                   ),
//                                                                   Text(
//                                                                     _data!
//                                                                         .data![
//                                                                             index]
//                                                                         .contactNumber
//                                                                         .toString(),
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .black
//                                                                             .withOpacity(
//                                                                                 .6),
//                                                                         fontSize:
//                                                                             12),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 45,
//                                                                   ),
//                                                                   Container(
//                                                                     height: 15,
//                                                                     width: 15,
//                                                                     color: Colors
//                                                                         .blue,
//                                                                     child:
//                                                                         const Center(
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .location_on,
//                                                                         size:
//                                                                             12,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 6,
//                                                                   ),
//                                                                   Text(
//                                                                     "$km KM",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .black
//                                                                             .withOpacity(
//                                                                                 .6),
//                                                                         fontSize:
//                                                                             12),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               _data!.data![index]
//                                                                           .isCompleted ==
//                                                                       "1"
//                                                                   ? const Padding(
//                                                                       padding: EdgeInsets.only(
//                                                                           right:
//                                                                               8.0),
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .check_circle_outline,
//                                                                         color: Colors
//                                                                             .green,
//                                                                         size:
//                                                                             20,
//                                                                       ),
//                                                                     )
//                                                                   : Container(),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             }))
//                                     : Container(),
//                                 _currentPosition != null
//                                     ? ToVisit(_currentPosition!.latitude,
//                                         _currentPosition!.longitude)
//                                     : Container(),
//                                 Visited(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     : Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               color: Colors.white,
//                               height: 35,
//                               width: MediaQuery.of(context).size.width,
//                               child: TabBar(
//                                 indicatorColor: const Color(0XFFE84201),
//                                 labelColor: const Color(0XFFE84201),
//                                 labelStyle: TextStyle(
//                                   color: Colors.black.withOpacity(.6),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 tabAlignment: TabAlignment.fill,
//                                 isScrollable: false,
//                                 tabs: [
//                                   const Tab(
//                                     text: "PLANNED",
//                                   ),
//                                   Container(
//                                     child: const Tab(
//                                       text: "YET TO VISIT",
//                                     ),
//                                   ),
//                                   const Tab(
//                                     text: "VISITED",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .703,
//                             width: MediaQuery.of(context).size.width,
//                             child: TabBarView(
//                               children: [
//                                 WeeklyjourneyPage(),
//                                 YettoVisit(),
//                                 WeekCompleted(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
