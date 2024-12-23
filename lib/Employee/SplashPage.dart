import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rms/ClientRep/client_home.dart';
import 'package:rms/Employee/ActivitiesPage.dart';
import 'package:rms/Employee/JourneyPlan.dart';
import 'package:rms/Employee/LoginPage.dart';
import 'package:rms/Employee/MyHomePage.dart';
import 'package:rms/Employee/OutletDetail.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/FieldManager/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  /*String page="";
  String ids="";
  String place="";
  String name="";
  Future<String?> names(context) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    page= (prefs1.get("page") != "") ? prefs1.get("page").toString() : "";
    ids= (prefs1.get("ids") != "") ? prefs1.get("ids").toString() : "";
    place= (prefs1.get("place") != "") ? prefs1.get("place").toString() : "";
    name= (prefs1.get("name") != "") ? prefs1.get("name").toString() : "";
    return page;
  }*/
  String _lastPage = '';
  String name = '';
  String id = '';
  String ouid = '';
  String place = '';
  String address = '';
  String radius = '';
  String contact = '';
  String lat = '';
  String long = '';
  String km = '';
  String role = '';
  String outletId = '';
  void _getLastPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString('role')!;
      _lastPage =
          prefs.getString('page') == null ? "" : prefs.getString('page')!;
      name = prefs.getString('name')!;
      id = prefs.getString('ids')!;
      ouid = prefs.getString('ouid')!;
      place = prefs.getString('place')!;
      address = prefs.getString('desi')!;
      radius = prefs.getString('radius')!;
      contact = prefs.getString('number')!;
      lat = prefs.getString('lat')!;
      long = prefs.getString('long')!;
      km = prefs.getString('km')!;
      outletId = prefs.getString('outletId')!;
    });
  }

  @override
  void startTimer() {
    Timer(const Duration(seconds: 2), () {
      navigationPage(); //It will redirect  after 3 seconds
    });
  }

  Future<void> navigationPage() async {
    Preference.getToken().then((value) {
      if (value != null && value.isNotEmpty) {
        //Provider.of<AppProvider>(context, listen: false).setToken(value);
        // ApiService.service.deletecart(context);
        print("THe name passed : $name");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => _lastPage == "JourneyPlan"
                    ? JourneyPlan(1)
                    : _lastPage == "Activity"
                        ? Activity(
                            id, address, name, lat, long, 300.00, 1, "0", ouid)
                        : _lastPage == "OutletDetail"
                            ? OutletDetail(name, place, lat, long, address,
                                contact, id, 300.00, 1, km, outletId)
                            : role == "5"
                                ? HomePage()
                                : role == "15"
                                    ? const ClientHome()
                                    : MyHomePage("1")));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _getLastPage();
  }

/*  @override
  void initState() {
    super.initState();
    //names(context);
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                 */ /*page=="JourneyPlan"?JourneyPlan() :page=="Activity"?Activity(ids,place,name):*/ /*LoginPage()
            )
        )
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Image.asset(
              "images/RMS_Splash.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Text(
              "Version : ${AppVersion.version}",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
