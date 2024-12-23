// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:rms/Employee/ApiService.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:rms/Employee/AvailabilityPage.dart';
// import 'package:rms/Employee/JourneyPlan.dart';
// import 'package:rms/Employee/MyHomePage.dart';
// import 'package:rms/Employee/StockcheckPage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:loader_overlay/loader_overlay.dart';

// class Activity extends StatefulWidget {
//   String id="";
//   String address="";
//   String name="";
//   String lat="";
//   String long="";
//   double? _desiredRadius;
//   int? i;
//   Activity(this.id,this.address,this.name,this.lat,this.long,this._desiredRadius,this.i);
//   @override
//   State<Activity> createState() => _ActivityState(this.id,this.address,this.name,this.lat,this.long,this._desiredRadius,this.i);
// }

// class _ActivityState extends State<Activity> {
//   String id="";
//   String address="";
//   String name="";
//   String lat="";
//   String long="";
//   String address1="";
//   String emp="";
//   String user="";
//   double? _desiredRadius;
//   double? distance;
//   String formattedDate = DateFormat('kk:mm:ss').format(DateTime.now());
//   int? i;
//   _ActivityState(this.id,this.address,this.name,this.lat,this.long,this._desiredRadius,this.i);
//   Position? _currentPosition;

//   void _saveLastPage(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('page', page);
//   }
//   void _saveName(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('name', page);
//   }
//   void _saveids(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('ids', page);
//   }
//   void _saveaddress(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('desi', page);
//   }
//   void _saveradius(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('radius', page);
//   }
//   void _savelat(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('lat', page);
//   }
//   void _savelong(String page) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('long', page);
//   }
//   bool _isLoaderVisible = false;
//   Future<void> loader() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     emp=prefs1.get("id").toString();
//     user=prefs1.get("user").toString();
//     context.loaderOverlay.show();
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//     await Future.delayed(Duration(seconds: 1));
//     if (_isLoaderVisible) {
//       context.loaderOverlay.hide();
//     }
//     setState(() {
//       _isLoaderVisible = context.loaderOverlay.visible;
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     loader();
//     _saveLastPage("Activity");
//     _saveName(name);
//     _saveids(id);
//     _saveaddress(address);
//     _saveradius(_desiredRadius.toString());
//     _savelat(lat);
//     _savelong(long);
//     _getCurrentLocation();
//   }

//   // Function to get current location
//   void _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       //Geolocator.openLocationSettings();
//       _currentPosition = position;
//     });
//   }

//   // Function to calculate distance between two points
//   double _calculateDistance(double startLatitude, double startLongitude,
//       double endLatitude, double endLongitude) {
//     double distanceInMeters = Geolocator.distanceBetween(
//         startLatitude, startLongitude, endLatitude, endLongitude);
//     return distanceInMeters;
//   }
//   Future<String> getAddressFromLatLng(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//       Placemark place = placemarks[0];
//       String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//       return address;
//     } catch (e) {
//       return "Unable to fetch address";
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             elevation: 1,
//             foregroundColor: Colors.black.withOpacity(.6),
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Activities",style: TextStyle(color:Color(0XFFE84201),fontSize: 24,fontWeight: FontWeight.w500),),
//                         Text(user+"("+emp+")",style: TextStyle(color: Colors.black.withOpacity(.6),fontSize: 8,fontWeight: FontWeight.w500),),
//                       ],
//                     ),
//                     SizedBox(width: 10,),
//                     IconButton(onPressed: (){},
//                   icon: Icon(Icons.refresh,size: 30,)),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: (){
//                     setState((){  distance = _calculateDistance(
//                       _currentPosition!.latitude,
//                       _currentPosition!.longitude,
//                       double.parse(lat),
//                       double.parse(long),
//                     );
//                     distance=(double.parse(distance.toString())/1000);
//                      address1 =  getAddressFromLatLng(_currentPosition!.latitude, _currentPosition!.longitude,).toString();
//                     });
//                     showDialog<void>(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                             backgroundColor: Colors.white,
//                             elevation: 0,
//                             content:StatefulBuilder(  // You need this, notice the parameters below:
//                                 builder: (BuildContext context, StateSetter setState) {
//                                   return Container(
//                                       height: 162,
//                                       child:Column(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text("Check Out",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: Color(0XFFE84201).withOpacity(.8)),),
//                                           Divider(),
//                                           Text("Current Distance from the store is\n"+distance.toString()+" KM"),
//                                           Divider(),
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Center(
//                                                 child: GestureDetector(
//                                                   onTap: (){
//                                                     var response =(distance! <= _desiredRadius!)?ApiService.service
//                                                         .checkout(context,id.toString(),formattedDate,address1):showDialog<void>(
//                                                 context: context,
//                                                 builder: (context) => AlertDialog(
//                                                 backgroundColor: Colors.white,
//                                                 elevation: 0,
//                                                 content:StatefulBuilder(  // You need this, notice the parameters below:
//                                                 builder: (BuildContext context, StateSetter setState) {
//                                                 return Container(
//                                                   width: MediaQuery.of(context).size.width*.7,
//                                                 height:  MediaQuery.of(context).size.height*.22,
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(15.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Text("Location Alert!!!",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18,color: Color(0XFFE84201).withOpacity(.8)),),
//                                                       SizedBox(height: 10,),
//                                                       Text("Distance from the store is more than the permissible limit. Please try from a location to the store"),
//                                                       SizedBox(height: 10,),
//                                                       GestureDetector(
//                                                           onTap: (){
//                                                              var response=  ApiService.service
//                                                                         .checkout(context,id.toString(),formattedDate,address1);
//                                                                     response!.then((value) => {
//                                                                     i==0?Navigator.pop(context,true):Navigator.of(context).pushReplacement(MaterialPageRoute(
//                                                                     builder: (BuildContext context) => MyHomePage("1")))
//                                                                     });
//                                                                     },
//                                                           child: Card(
//                                                               elevation: 0,
//                                                               color: Color(0XFFE84201),
//                                                               shape: RoundedRectangleBorder(
//                                                                 borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                                                               ),
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 6),
//                                                                 child: Text("OK",style: TextStyle(color: Colors.white),),
//                                                               )),),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 );})));
//                                                     response.then((value) => {
//                                                      i==0?{ Navigator.pop(context,true),
//                                                       Navigator.pop(context,true)}:Navigator.of(context).pushReplacement(MaterialPageRoute(
//                                                          builder: (BuildContext context) => JourneyPlan(1)))
//                                                     });
//                                                   },
//                                                   child: Card(
//                                                       elevation: 0,
//                                                       color: Color(0XFFE84201),
//                                                       shape: RoundedRectangleBorder(
//                                                         borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                                                       ),
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 6),
//                                                         child: Text("OK",style: TextStyle(color: Colors.white),),
//                                                       )),
//                                                 ),
//                                               ),
//                                               Center(
//                                                 child: GestureDetector(
//                                                   onTap: (){
//                                                       Navigator.pop(context);
//                                                   },
//                                                   child: Card(
//                                                       elevation: 0,
//                                                       color: Colors.black12,
//                                                       shape: RoundedRectangleBorder(
//                                                         borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                                                       ),
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.only(left: 20,right: 20,top: 6,bottom: 6),
//                                                         child: Text("Cancel",style: TextStyle(color: Colors.white),),
//                                                       )),
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       )
//                                   );})));
//                     Scaffold.of(context).showBottomSheet(
//                           (BuildContext context) {
//                         return Container(
//                           height: 200,
//                           color: Colors.amber,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 const Text('BottomSheet'),
//                                 ElevatedButton(
//                                   child: const Text('Close BottomSheet'),
//                                   onPressed: () {
//                                     var response =(distance! <= _desiredRadius!)?ApiService.service
//                                         .checkout(context,id.toString(),formattedDate,address1):null;
//                                     response!.then((value) => {
//                                       Navigator.pop(context,true)
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                     },
//                   child: Card(
//                       elevation: 0,
//                       color: Color(0XFFE84201).withOpacity(.6),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15,right: 15,top: 6,bottom: 6),
//                         child: Text("Check out",style: TextStyle(color: Colors.white),),
//                       )),
//                 )
//               ],
//             ),
//           ),
//           body: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/Pattern.png"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             child: Container(
//               child:Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     Card(
//                       elevation: 0,
//                       color: Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Icon(Icons.home_filled,size: 40,),
//                             SizedBox(width: 10,),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),),
//                                 Text(address,style: TextStyle(color: Colors.black.withOpacity(.6),fontWeight: FontWeight.w400,fontSize: 12),),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     Card(
//                       elevation: 0,
//                       color:Color(0XFFE84201),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Check Out Feature will not be available beyond 300\nMeter Radius from the store...",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: Colors.white),),
//                             SizedBox(height: 10,),
//                             Text("Ensure All Activities in the store are completed before Check Out...",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,color: Colors.white),),
//                           ],
//                         )
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     GestureDetector(
//                       onTap: (){Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) =>  Availability()),
//                       );},
//                       child: SizedBox(
//                         height: 110,
//                         width: MediaQuery.of(context).size.width,
//                         child: Card(
//                           elevation: 0,
//                           color:Colors.white,
//                           child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.bar_chart,size: 60,),
//                                   Text("Availability"),
//                                 ],
//                               )
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     GestureDetector(
//                       onTap: (){Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) =>  StockCheck()),
//                       );},
//                       child: SizedBox(
//                         height: 110,
//                         width: MediaQuery.of(context).size.width,
//                         child: Card(
//                           elevation: 0,
//                           color:Colors.white,
//                           child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(Icons.shopping_bag_outlined,size: 60,),
//                                   Text("Stock Check Details"),
//                                 ],
//                               )
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             )
//           ),
//       ),
//     );
//   }
// }