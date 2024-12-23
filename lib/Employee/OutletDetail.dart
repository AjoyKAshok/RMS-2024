import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rms/Employee/ActivitiesPage.dart';
import 'package:rms/Employee/ApiService.dart';
import 'package:rms/Employee/JourneyPlan.dart';
import 'package:rms/Employee/version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OutletDetail extends StatefulWidget {
  String name = "";
  String place = "";
  String lat = "";
  String long = "";
  String address = "";
  String contact = "";
  String id = "";
  final double? _desiredRadius;
  int? j;
  String km = "";
  String outletId = "";
  OutletDetail(
      this.name,
      this.place,
      this.lat,
      this.long,
      this.address,
      this.contact,
      this.id,
      this._desiredRadius,
      this.j,
      this.km,
      this.outletId,
      {super.key});
  @override
  State<OutletDetail> createState() => _OutletDetailState(name, place, lat,
      long, address, contact, id, _desiredRadius, j, km, outletId);
}

class _OutletDetailState extends State<OutletDetail>
    with WidgetsBindingObserver {
  AppLifecycleState _appState = AppLifecycleState.inactive;
  String name = "";
  String place = "";
  String lat = "";
  String long = "";
  String address = "";
  late String address1;
  late double distance;
  String contact = "";
  String emp = "";
  String user = "";
  String id = "";
  final double? _desiredRadius; // in meters
  String formattedDate = DateFormat('kk:mm:ss').format(DateTime.now());
  int i = 0;
  int button = 0;
  int button1 = 0;
  int selectedOption = 1;
  int? j;
  String km = "";
  String km1 = "";
  bool clicked = false;
  String outletId = '';
  //Position? _currentPosition;
  final String _currentAddress = "";
  final bool _isFetchingLocation = false;
  final Completer<GoogleMapController> _controller = Completer();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  _OutletDetailState(
      this.name,
      this.place,
      this.lat,
      this.long,
      this.address,
      this.contact,
      this.id,
      this._desiredRadius,
      this.j,
      this.km,
      this.outletId);

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

  Position? _currentPosition;
  String _lastPage = '';
  void _getLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPage = prefs.getString('page') ?? 'OutletDetail';
    });
  }

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

  void _saveplace(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('place', page);
  }

  void _saveaddress(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('desi', page);
  }

  void _saveradius(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('radius', page);
  }

  void _savenumber(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('number', page);
  }

  void _savelat(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lat', page);
  }

  void _savelong(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('long', page);
  }

  void _savekm(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('km', page);
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
    await Future.delayed(const Duration(seconds: 1));
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  _getCurrentLocation1() async {
    // LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: false,
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      //Geolocator.openLocationSettings();
      _currentPosition = position;
      km1 = _calculateDistance(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              double.parse(lat),
              double.parse(long))
          .toStringAsFixed(2);
      km1 = (double.parse(km1) / 1000).toStringAsFixed(2);
    });
  }

  fetchAddress(double lat1, double long1) async {
    return await getAddressFromLatLng(lat1, long1);
  }

  _getversion() async {
    ApiService.service.version(context).then((value) => {});
  }

  // Initialize connectivity status
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

  fetchNetworkOut() async {
    print("Network Check from Outlet Page");
    await checkNetwork();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loader();
    _getversion();
    _getCurrentLocation();
    _getLastPage();
    _saveLastPage("OutletDetail");
    print("Outlet Detail Name : ${widget.name}");
    _saveName(widget.name);
    _saveids(id);
    _saveplace(place);
    _saveaddress(address);
    _saveradius(_desiredRadius.toString());
    _savenumber(contact);
    _savelat(lat);
    _savelong(long);
    _savekm(km1);
    print("Outlet Id Got : ${widget.outletId}");
    fetchNetworkOut();
    setState(() {
      j == 1 ? j = 1 : j = 0;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _appState = state;
    _getLastPage();

    if (state == AppLifecycleState.resumed) {
      if (_lastPage == "OutletDetail") {
        print("Calling Calculate Distance for OUTLET");
        await Future.delayed(const Duration(seconds: 4));
        setState(() {
          fetchNetworkOut();
        });
        await _getCurrentLocation1();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: false,
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      //Geolocator.openLocationSettings();
      _currentPosition = position;
      km1 = _calculateDistance(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              double.parse(lat),
              double.parse(long))
          .toStringAsFixed(2);
      km1 = (double.parse(km1) / 1000).toStringAsFixed(2);
    });
  }
  // Function to get current location

  // Function to calculate distance between two points
  double _calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters;
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialPosition = CameraPosition(
      target: LatLng(double.parse(lat), double.parse(long)),
      zoom: 12,
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JourneyPlan(0)),
                );
              },
              icon: const Icon(Icons.arrow_back),
              color: const Color(0XFF909090),
            ),
            elevation: 1,
            foregroundColor: Colors.black.withOpacity(.6),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Outlet Details",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontSize: 21,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "$user($emp) - v " + AppVersion.version,
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Pattern.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.name}",
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
                              place,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: const Color(0XFFE84201),
                                  child: const Center(
                                    child: Icon(
                                      Icons.phone,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  contact,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 45,
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: const Color(0XFFE84201),
                                  child: const Center(
                                    child: Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "$km1 KM",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              height: 200,
                              width: 500,
                              child: GoogleMap(
                                myLocationButtonEnabled: true,
                                mapType: MapType.normal,
                                initialCameraPosition: initialPosition,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                                markers: {
                                  Marker(
                                    markerId: const MarkerId('marker_1'),
                                    position: LatLng(
                                        double.parse(lat), double.parse(long)),
                                    infoWindow: const InfoWindow(
                                        title: 'Marker Title',
                                        snippet: 'Marker Snippet'),
                                    onTap: () {
                                      // Handle marker tap
                                    },
                                  ),
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    GestureDetector(
                      onTap: km1 != ""
                          ? () async {
                              setState(() {
                                button1 = 1;
                                clicked = true;
                              });
                              ApiService.service
                                  .createlog("Check In Button Clicked", true);
                              await _getCurrentLocation();
                              setState(() {
                                distance = _calculateDistance(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude,
                                  double.parse(lat),
                                  double.parse(long),
                                );
                              });
                              // double latitude = 37.4219983; // Example latitude
                              // double longitude = -122.084; // Example longitude
                              address1 = await fetchAddress(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              );

                              if (distance <= _desiredRadius!) {
                                var response = ApiService.service.checkin(
                                    context,
                                    id.toString(),
                                    formattedDate.toString(),
                                    address1);
                                response.then((value) => {
                                      setState(() {
                                        clicked = false;
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Activity(
                                                id.toString(),
                                                address,
                                                name,
                                                lat,
                                                long,
                                                _desiredRadius,
                                                j,
                                                km, outletId),
                                          ),
                                        );
                                      })
                                    });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content:
                                //         Center(child: Text("Successfully Checked In")),
                                //     backgroundColor: Colors.black,
                                //   ),
                                // );
                              } else {
                                showDialog<void>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    content: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .3,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Wrong Location!!!",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(),
                                            /*Text("It seems that you are not at the customer location.\nplease try again after reaching the store...",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black),),
                                    SizedBox(height: 5,),*/
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Distance to the Store is : $km1 KM",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Please try again after reaching the customer location...",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        button1 = 0;
                                                        clicked = false;
                                                      });
                                                    },
                                                    child: Card(
                                                        elevation: 0,
                                                        // color: Colors.black12,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8.0), //<-- SEE HERE
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                                colors: [
                                                                  button == 0
                                                                      ? Color(
                                                                          0xFFF88200)
                                                                      : Colors
                                                                          .grey,
                                                                  button == 0
                                                                      ? Color(
                                                                          0xFFE43700)
                                                                      : Colors
                                                                          .grey
                                                                ]),
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 23,
                                                                    right: 23,
                                                                    top: 6,
                                                                    bottom: 6),
                                                            child: Text(
                                                              "OK",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ]),
                                          ]),
                                    ),
                                  ),
                                );
                              }
                              // });
                              // await showDialog<void>(
                              //     context: context,
                              //     builder: (context) => AlertDialog(
                              //         backgroundColor: Colors.white,
                              //         elevation: 0,
                              //         content: Container(
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(10),
                              //             color: Colors.white,
                              //           ),
                              //           height: 130,
                              //           child: Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               const Text(
                              //                 "Location",
                              //                 style: TextStyle(
                              //                     fontWeight: FontWeight.w800,
                              //                     fontSize: 14,
                              //                     color: Colors.black),
                              //               ),
                              //               const SizedBox(
                              //                 height: 10,
                              //               ),
                              //               /*Text("It seems that you are not at the customer location.\nplease try again after reaching the store...",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black),),
                              //             SizedBox(height: 5,),*/
                              //               Text(
                              //                 "Distance to the Store is : $km1 KM",
                              //                 style: const TextStyle(
                              //                     fontWeight: FontWeight.w600,
                              //                     fontSize: 12,
                              //                     color: Colors.black),
                              //               ),
                              //               const SizedBox(
                              //                 height: 0,
                              //               ),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment.center,
                              //                 children: [
                              //                   GestureDetector(
                              //                     onTap: () {
                              //                       Navigator.pop(context);
                              //                     },
                              //                     child: Card(
                              //                         elevation: 0,
                              //                         color: Colors.black12,
                              //                         shape: RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius.circular(
                              //                                   8.0), //<-- SEE HERE
                              //                         ),
                              //                         child: const Padding(
                              //                           padding: EdgeInsets.only(
                              //                               left: 23,
                              //                               right: 23,
                              //                               top: 6,
                              //                               bottom: 6),
                              //                           child: Text("OK"),
                              //                         )),
                              //                   ),
                              //                   const SizedBox(
                              //                     width: 40,
                              //                   ),
                              //                   // GestureDetector(
                              //                   //   onTap: () {
                              //                   //     Navigator.pop(context);
                              //                       // showDialog<void>(
                              //                       //     context: context,
                              //                       //     builder:
                              //                       //         (context) => AlertDialog(
                              //                       //               backgroundColor:
                              //                       //                   Colors.white,
                              //                       //               elevation: 0,
                              //                       //               content:
                              //                       //                   StatefulBuilder(
                              //                       //                       // You need this, notice the parameters below:
                              //                       //                       builder: (BuildContext
                              //                       //                               context,
                              //                       //                           StateSetter
                              //                       //                               setState) {
                              //                       //                 return SizedBox(
                              //                       //                     height: 182,
                              //                       //                     child: Column(
                              //                       //                       crossAxisAlignment:
                              //                       //                           CrossAxisAlignment
                              //                       //                               .start,
                              //                       //                       children: [
                              //                       //                         const Text(
                              //                       //                           "New Force Check-in",
                              //                       //                           style: TextStyle(
                              //                       //                               fontWeight: FontWeight
                              //                       //                                   .w800,
                              //                       //                               fontSize:
                              //                       //                                   18,
                              //                       //                               color:
                              //                       //                                   Colors.black),
                              //                       //                         ),
                              //                       //                         SizedBox(
                              //                       //                           height:
                              //                       //                               30,
                              //                       //                           child:
                              //                       //                               ListTile(
                              //                       //                             title: const Text(
                              //                       //                                 'GPS Not Working'),
                              //                       //                             leading:
                              //                       //                                 Radio<int>(
                              //                       //                               value:
                              //                       //                                   1,
                              //                       //                               groupValue:
                              //                       //                                   selectedOption,
                              //                       //                               onChanged:
                              //                       //                                   (value) {
                              //                       //                                 setState(() {
                              //                       //                                   selectedOption = value!;
                              //                       //                                   print("Button value: $value");
                              //                       //                                 });
                              //                       //                               },
                              //                       //                             ),
                              //                       //                           ),
                              //                       //                         ),
                              //                       //                         SizedBox(
                              //                       //                           height:
                              //                       //                               30,
                              //                       //                           child:
                              //                       //                               ListTile(
                              //                       //                             title: const Text(
                              //                       //                                 'Geo Location was wrong'),
                              //                       //                             leading:
                              //                       //                                 Radio<int>(
                              //                       //                               value:
                              //                       //                                   2,
                              //                       //                               groupValue:
                              //                       //                                   selectedOption,
                              //                       //                               onChanged:
                              //                       //                                   (value) {
                              //                       //                                 setState(() {
                              //                       //                                   selectedOption = value!;
                              //                       //                                   print("Button value: $value");
                              //                       //                                 });
                              //                       //                               },
                              //                       //                             ),
                              //                       //                           ),
                              //                       //                         ),
                              //                       //                         ListTile(
                              //                       //                           title: const Text(
                              //                       //                               'Others'),
                              //                       //                           leading:
                              //                       //                               Radio<
                              //                       //                                   int>(
                              //                       //                             value:
                              //                       //                                 3,
                              //                       //                             groupValue:
                              //                       //                                 selectedOption,
                              //                       //                             onChanged:
                              //                       //                                 (value) {
                              //                       //                               setState(
                              //                       //                                   () {
                              //                       //                                 selectedOption =
                              //                       //                                     value!;
                              //                       //                                 print("Button value: $value");
                              //                       //                               });
                              //                       //                             },
                              //                       //                           ),
                              //                       //                         ),
                              //                       //                         Center(
                              //                       //                           child:
                              //                       //                               GestureDetector(
                              //                       //                             onTap:
                              //                       //                                 () {
                              //                       //                               setState(
                              //                       //                                   () {
                              //                       //                                 double
                              //                       //                                     distance =
                              //                       //                                     _calculateDistance(
                              //                       //                                   _currentPosition!.latitude,
                              //                       //                                   _currentPosition!.longitude,
                              //                       //                                   double.parse(lat),
                              //                       //                                   double.parse(long),
                              //                       //                                 );
                              //                       //                                 double
                              //                       //                                     latitude =
                              //                       //                                     37.4219983; // Example latitude
                              //                       //                                 double
                              //                       //                                     longitude =
                              //                       //                                     -122.084; // Example longitude
                              //                       //                                 String
                              //                       //                                     address1 =
                              //                       //                                     getAddressFromLatLng(
                              //                       //                                   _currentPosition!.latitude,
                              //                       //                                   _currentPosition!.longitude,
                              //                       //                                 ).toString();
                              //                       //                                 if (distance <=
                              //                       //                                     _desiredRadius!) {
                              //                       //                                   var response = ApiService.service.checkin(context, id.toString(), formattedDate.toString(), address1);
                              //                       //                                   response.then((value) => {
                              //                       //                                         setState(() {
                              //                       //                                           Navigator.pop(context);
                              //                       //                                           Navigator.push(
                              //                       //                                             context,
                              //                       //                                             MaterialPageRoute(builder: (context) => Activity(id.toString(), address, name, lat, long, _desiredRadius, j, km)),
                              //                       //                                           );
                              //                       //                                         })
                              //                       //                                       });
                              //                       //                                   ScaffoldMessenger.of(context).showSnackBar(
                              //                       //                                     const SnackBar(
                              //                       //                                       content: Center(child: Text("Successfully Checked In")),
                              //                       //                                       backgroundColor: Colors.black,
                              //                       //                                     ),
                              //                       //                                   );
                              //                       //                                 } else {
                              //                       //                                   var response = ApiService.service.checkin(context, id.toString(), formattedDate.toString(), address + place);
                              //                       //                                   response.then((value) => {
                              //                       //                                         setState(() {
                              //                       //                                           Navigator.pop(context);
                              //                       //                                           Navigator.push(
                              //                       //                                             context,
                              //                       //                                             MaterialPageRoute(builder: (context) => Activity(id.toString(), address, name, lat, long, _desiredRadius, j, km)),
                              //                       //                                           );
                              //                       //                                         })
                              //                       //                                       });
                              //                       //                                   ScaffoldMessenger.of(context).showSnackBar(
                              //                       //                                     const SnackBar(
                              //                       //                                       content: Center(child: Text("Away from 300 meter")),
                              //                       //                                       backgroundColor: Colors.black,
                              //                       //                                     ),
                              //                       //                                   );
                              //                       //                                 }
                              //                       //                               });
                              //                       //                             },
                              //                       //                             child: Card(
                              //                       //                                 elevation: 0,
                              //                       //                                 color: const Color(0XFFE84201),
                              //                       //                                 shape: RoundedRectangleBorder(
                              //                       //                                   borderRadius: BorderRadius.circular(8.0), //<-- SEE HERE
                              //                       //                                 ),
                              //                       //                                 child: const Padding(
                              //                       //                                   padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
                              //                       //                                   child: Text(
                              //                       //                                     "Submit",
                              //                       //                                     style: TextStyle(color: Colors.white),
                              //                       //                                   ),
                              //                       //                                 )),
                              //                       //                           ),
                              //                       //                         )
                              //                       //                       ],
                              //                       //                     ));
                              //                       //               }),
                              //                       //             ));
                              //                   //   },
                              //                   //   child: Card(
                              //                   //     elevation: 0,
                              //                   //     color: const Color(0XFFE84201),
                              //                   //     shape: RoundedRectangleBorder(
                              //                   //       borderRadius:
                              //                   //           BorderRadius.circular(
                              //                   //               8.0), //<-- SEE HERE
                              //                   //     ),
                              //                   //     child: const Padding(
                              //                   //       padding: EdgeInsets.only(
                              //                   //           left: 20,
                              //                   //           right: 20,
                              //                   //           top: 6,
                              //                   //           bottom: 6),
                              //                   //       child: Text(
                              //                   //         "YES",
                              //                   //         style: TextStyle(
                              //                   //             color: Colors.white),
                              //                   //       ),
                              //                   //     ),
                              //                   //   ),
                              //                   // ),
                              //                 ],
                              //               ),
                              //             ],
                              //           ),
                              //         )));
                              _saveLastPage(
                                  'OutletDetail'); /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  MyHomePage()),
                      );*/
                            }
                          : () {
                              setState(() {
                                button1 = 1;
                              });
                            },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: km1 != ""
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                        button1 == 0
                                            ? Color(0xFFF88200)
                                            : Colors.grey,
                                        button1 == 0
                                            ? Color(0xFFE43700)
                                            : Colors.grey
                                      ])
                                : const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.grey, Colors.white]),
                          ),
                          child: Center(
                            child: clicked
                                ? CircularProgressIndicator(
                                    color: Colors.orange[300],
                                  )
                                : Text(
                                    "Check In",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: km1 != ""
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _currentPosition != null
                          ? 'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}'
                          : '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
