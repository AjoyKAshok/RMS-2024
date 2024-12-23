// import 'dart:async';
// import 'dart:io';

// import 'package:app_settings/app_settings.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:rms/Employee/ActivitiesPage.dart';
// import 'package:rms/Employee/version.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Planogram extends StatefulWidget {
//   String name = "";
//   String address = "";
//   String timesheetid = '';
//   String idNav = "";
//   String addressNav = "";
//   String nameNav = "";
//   String latNav = "";
//   String longNav = "";
//   String radiusNav = "";
//   String iNav = "";
//   String kmNav = "";
//   Planogram(
//       this.timesheetid,
//       this.name,
//       this.address,
//       this.idNav,
//       this.addressNav,
//       this.nameNav,
//       this.latNav,
//       this.longNav,
//       this.radiusNav,
//       this.iNav,
//       this.kmNav,
//       {super.key});

//   @override
//   State<Planogram> createState() => _PlanogramState();
// }

// class _PlanogramState extends State<Planogram> with WidgetsBindingObserver {
//   AppLifecycleState _appState = AppLifecycleState.inactive;
//   String? idNav;
//   String? addressNav;
//   String? nameNav;
//   double? radNav;
//   String? latNav;
//   String? longNav;
//   String? kmNav;

//   String emp = "";
//   String user = "";

//   String _lastPage = '';
//   void _getLastPage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _lastPage = prefs.getString('page') ?? 'Planogram';
//     });
//   }

//   void _saveLastPage(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('page', page);
//   }

//   loadValues() async {
//     await loader1();
//   }

//   bool _isLoaderVisible = false;
//   Future<void> loader() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     context.loaderOverlay.show();
//     setState(() {
//       nameNav = prefs1.getString('name')!;
//       idNav = prefs1.getString('ids')!;
//       // checkinNav = widget.checkinNav;
//       // ouid = prefs1.getString('ouid')!;
//       // place = prefs1.getString('place')!;
//       addressNav = prefs1.getString('desi')!;
//       radNav = double.parse(prefs1.getString('radius')!);
//       // contact = prefs1.getString('number')!;
//       latNav = prefs1.getString('lat')!;
//       longNav = prefs1.getString('long')!;
//       kmNav = prefs1.getString('km') ?? widget.kmNav;
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//     await Future.delayed(const Duration(seconds: 2));
//     if (_isLoaderVisible) {
//       context.loaderOverlay.hide();
//     }
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//   }

//   // Initialize connectivity status
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   Future<void> _initConnectivity() async {
//     ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } catch (e) {
//       result = ConnectivityResult.none;
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//     return _updateConnectionStatus(result);
//   }

//   // Update the UI based on the connectivity status
//   void _updateConnectionStatus(ConnectivityResult result) {
//     setState(() {
//       _connectionStatus = result;
//     });
//     if (result == ConnectivityResult.none) {
//       _showNoConnectionDialog();
//     }
//   }

//   void openAppSettings() async {
//     const url = 'app-settings:';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not open app settings';
//     }
//   }

//   void _showNoConnectionDialog() {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('No Internet Connection'),
//           content: const Text('You have lost your internet connection.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 // AppSettings.openAppSettings(type: AppSettingsType.wifi);
//                 Platform.isIOS
//                     ? openAppSettings()
//                     : AppSettings.openAppSettingsPanel(
//                         AppSettingsPanelType.internetConnectivity);
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   checkNetwork() async {
//     await _initConnectivity();
//   }

//   fetchNetwork() async {
//     print("Network Check from Availability Page");
//     await checkNetwork();
//   }

//   File? _imgFile;
//   File? _imgFile1;

//   void takeSnapshot() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? img = await picker.pickImage(
//       source: ImageSource.camera, // alternatively, use ImageSource.gallery
//       maxWidth: 400,
//     );
//     if (img == null) return;
//     setState(() {
//       _imgFile = File(img.path); // convert it to a Dart:io file
//     });
//   }

//   void takeSnapshot1() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? img = await picker.pickImage(
//       source: ImageSource.camera, // alternatively, use ImageSource.gallery
//       maxWidth: 400,
//     );
//     if (img == null) return;
//     setState(() {
//       _imgFile1 = File(img.path); // convert it to a Dart:io file
//     });
//   }

//   @override
//   initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     // reason.clear();

//     loader();
//     loadValues();
//     _saveLastPage("Planogram");

//     fetchNetwork();
//     // Preference.setPage("JourneyPlan");
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     _appState = state;
//     _getLastPage();
//     print("App State is : $_appState");
//     if (state == AppLifecycleState.resumed) {
//       // myList.clear();
//       print("Calling Life Cycle Change Events");
//       if (_lastPage == "Planogram") {
//         print("Calling Functions for Planogram Page");
//         await Future.delayed(const Duration(seconds: 4));
//         setState(() {
//           fetchNetwork();
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//   }

//   Future<void> loader1() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     emp = prefs1.get("id").toString();
//     user = prefs1.get("user").toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: true,
//           elevation: 1,
//           foregroundColor: Colors.black.withOpacity(.6),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Activity(
//                           idNav!, addressNav!, nameNav!,
//                           latNav!, longNav!, radNav!, 1, kmNav!,
//                           // checkinNav!
//                         )),
//               );
//             },
//             icon: const Icon(Icons.arrow_back),
//             color: const Color(0XFF909090),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Planogram",
//                     style: TextStyle(
//                         color: Color(0XFFE84201),
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   Text(
//                     "$user - $emp - v ${AppVersion.version}",
//                     style: TextStyle(
//                         color: Colors.black.withOpacity(.6),
//                         fontSize: 8,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // body: SizedBox(
//         //     height: MediaQuery.of(context).size.height,
//         //     width: MediaQuery.of(context).size.width,
//         //     child: Table(
//         //       columnWidths: const {
//         //         0: FractionColumnWidth(.45),
//         //         1: FractionColumnWidth(.45),
//         //       },
//         //       children: [
//         //         TableRow(children: [
//         //           Row(
//         //             mainAxisAlignment: MainAxisAlignment.center,
//         //             children: [
//         //               IconButton(
//         //                 onPressed: () {
//         //                   // print("before...");
//         //                   // print('Planogram New: $index');
//         //                   // Selectedscreen = "planogram";
//         //                   // WidgetsFlutterBinding
//         //                   //     .ensureInitialized();

//         //                   // ontap = 'before';
//         //                   // selectedindex = index;
//         //                   // print('Planogram New: $selectedindex');
//         //                   // WidgetsBinding.instance
//         //                   //     .addPostFrameCallback((_) {
//         //                   //   Navigator.pushReplacement(
//         //                   //       context,
//         //                   //       MaterialPageRoute(
//         //                   //           builder:
//         //                   //               (BuildContext context) =>
//         //                   //                   TakePictureScreen()));
//         //                   // });
//         //                 },
//         //                 icon: const Icon(
//         //                   CupertinoIcons.photo_camera_solid,
//         //                 ),
//         //                 padding: const EdgeInsets.only(left: 0, right: 0),
//         //               ),
//         //               const Padding(
//         //                 padding: EdgeInsets.only(left: 0.0),
//         //                 child: Text(
//         //                   "Before",
//         //                   style: TextStyle(fontWeight: FontWeight.bold),
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //           Row(
//         //             mainAxisAlignment: MainAxisAlignment.center,
//         //             children: [
//         //               IconButton(
//         //                 onPressed: () {
//         //                   // print("before...");
//         //                   // print('Planogram New: $index');
//         //                   // Selectedscreen = "planogram";
//         //                   // WidgetsFlutterBinding
//         //                   //     .ensureInitialized();

//         //                   // ontap = 'before';
//         //                   // selectedindex = index;
//         //                   // print('Planogram New: $selectedindex');
//         //                   // WidgetsBinding.instance
//         //                   //     .addPostFrameCallback((_) {
//         //                   //   Navigator.pushReplacement(
//         //                   //       context,
//         //                   //       MaterialPageRoute(
//         //                   //           builder:
//         //                   //               (BuildContext context) =>
//         //                   //                   TakePictureScreen()));
//         //                   // });
//         //                 },
//         //                 icon: const Icon(
//         //                   CupertinoIcons.photo_camera_solid,
//         //                 ),
//         //                 padding: const EdgeInsets.only(left: 0, right: 0),
//         //               ),
//         //               const Padding(
//         //                 padding: EdgeInsets.only(left: 0.0),
//         //                 child: Text(
//         //                   "After",
//         //                   style: TextStyle(fontWeight: FontWeight.bold),
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //         ]),
//         //       ],
//         //     )),
//         body: SingleChildScrollView(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/Pattern.png"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     Card(
//                       elevation: 0,
//                       color: Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: SingleChildScrollView(
//                           child: Row(
//                             children: [
//                               const Icon(
//                                 Icons.home_filled,
//                                 size: 30,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     nameNav!,
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: 15),
//                                   ),
//                                   Text(
//                                     addressNav!,
//                                     style: TextStyle(
//                                         color: Colors.black.withOpacity(.6),
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 12),
//                                   ),
//                                   Text(
//                                     idNav!,
//                                     style: TextStyle(
//                                         color: Colors.black.withOpacity(.6),
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 12),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: 60,
//                       width: MediaQuery.of(context).size.width * .94,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.0),
//                         color: const Color(0xfff5e1d5),
//                       ),
//                       padding: const EdgeInsets.all(8),
//                       child: const TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Search by Category Name',
//                           hintStyle: TextStyle(
//                             color: Color(0XFFE84201),
//                           ),
//                           border: InputBorder.none,
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Color(0XFFE84201),
//                             size: 30,
//                           ),
//                           suffixIcon: Icon(
//                             Icons.clear,
//                             color: Color(0XFFE84201),
//                             size: 25,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: 5,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Card(
//                             elevation: 0,
//                             color: const Color(0xfff5e1d5),
//                             child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       index == 1
//                                           ? "CHOCOLATE"
//                                           : index == 2
//                                               ? "ICE-CREAM"
//                                               : index == 3
//                                                   ? "PET FOOD"
//                                                   : index == 4
//                                                       ? "CAKES"
//                                                       : "OTHERS",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 16,
//                                           color: Color(0XFFE84201)),
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Column(
//                                           children: [
//                                             (_imgFile == null)
//                                                 ? Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     color: Colors.white,
//                                                     child: const Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Icon(
//                                                             Icons
//                                                                 .image_outlined,
//                                                             size: 60,
//                                                             color:
//                                                                 Colors.black54),
//                                                         //SizedBox(height: 10,),
//                                                         Text(
//                                                           "No images available",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               fontSize: 10,
//                                                               color: Colors
//                                                                   .black54),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 : Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: FileImage(
//                                                             _imgFile!),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),
//                                             Row(
//                                               children: [
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       takeSnapshot();
//                                                     },
//                                                     icon: const Icon(
//                                                         Icons.camera_alt)),
//                                                 const Text("Before"),
//                                               ],
//                                             ),
                                            
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
                                            
//                                             //SizedBox(height: 10,),
//                                             (_imgFile1 == null)
//                                                 ? Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     color: Colors.white,
//                                                     child: const Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Icon(
//                                                             Icons
//                                                                 .image_outlined,
//                                                             size: 60,
//                                                             color:
//                                                                 Colors.black54),
//                                                         //SizedBox(height: 10,),
//                                                         Text(
//                                                           "No images available",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               fontSize: 10,
//                                                               color: Colors
//                                                                   .black54),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 : Container(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     height:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .height *
//                                                             .15,
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: FileImage(
//                                                             _imgFile1!),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Row(
//                                               children: [
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       takeSnapshot1();
//                                                     },
//                                                     icon: const Icon(
//                                                         Icons.camera_alt)),
//                                                 const Text("After"),
//                                               ],
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     )
//                                     // Text(id,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: Colors.white),),
//                                   ],
//                                 )),
//                           );
//                         }),
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
