import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rms/ClientRep/client_home.dart';
import 'package:rms/Employee/MyHomePage.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/Employee/version.dart';
import 'package:rms/FieldManager/HomePage.dart';
import 'package:rms/NetworkModel/Addavailability_model.dart';
import 'package:rms/NetworkModel/Availability_model.dart';
import 'package:rms/NetworkModel/Checkin_Model.dart';
import 'package:rms/NetworkModel/Checkout_Model.dart';
import 'package:rms/NetworkModel/DashBoardMonthly_Model.dart';
import 'package:rms/NetworkModel/DashboardDaily_Model.dart';
import 'package:rms/NetworkModel/Login_Model.dart';
import 'package:rms/NetworkModel/Logout_Model.dart';
import 'package:rms/NetworkModel/Replenish_model.dart';
import 'package:rms/NetworkModel/SplitShift_Model.dart';
import 'package:rms/NetworkModel/Stock_model.dart';
import 'package:rms/NetworkModel/TimesheetDaily_Model.dart';
import 'package:rms/NetworkModel/TimesheetMonthly_model.dart';
import 'package:rms/NetworkModel/TodayCompletedJourney_Model.dart';
import 'package:rms/NetworkModel/TodayPlannedJourney_Model.dart';
import 'package:rms/NetworkModel/TodaySkippedJourney_Model.dart';
import 'package:rms/NetworkModel/VisitedJourney_Model.dart';
import 'package:rms/NetworkModel/WeekplannedJourney_Model.dart';
import 'package:rms/NetworkModel/YettoVisit_Model.dart';
import 'package:rms/NetworkModelfm/StockCheck_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../NetworkModel/AddStack_model.dart';
import '../NetworkModel/version_model.dart';

class ApiService {
  ApiService._();

  static final ApiService service = ApiService._();

  Future<LoginModel> login(context, email, password) async {
    String url2 = 'https://rms2.rhapsody.ae/api/login';
    Map<String, String> register = {};
    register['email'] = email;
    register['password'] = password;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      String userid = data["token"].toString();
      log('data: $userid');
      //Provider.of<AppProvider>(context, listen: false).setToken(userid);
      Preference.setToken(userid);
      String id = data["user"]["emp_id"].toString();
      log('data: $id');
      //Provider.of<AppProvider>(context, listen: false).setToken(userid);
      Preference.setId(id);
      String name = data["user"]["name"].toString();
      log('data: $name');
      Preference.setUser(name);
      String role = data["user"]["role_id"].toString();
      log('data: $role');
      //Provider.of<AppProvider>(context, listen: false).setToken(userid);
      Preference.setRole(role);
      //Provider.of<AppProvider>(context, listen: false).setToken(userid);
      String client = data["client"].toString();
      print("Client is $client");
      Preference.setClient(client);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      data["user"]["role_id"].toString() == "5"
          ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            )
          :  data["user"]["role_id"].toString() == "15" ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientHome()),
            ) : Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage("0")),
            );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Login Successfull...")),
          backgroundColor: Colors.black,
        ),
      );
      return LoginModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Invalid Email or Password")),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<DashboardDailyModel> dashboarddaily(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/dashboard_daily';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return DashboardDailyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<DashBoardMonthlyModel> dashboardmonthly(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/dashboard_monthly';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return DashBoardMonthlyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<TodayPlannedJourneyModel> plannedJourney(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/today_planned_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return TodayPlannedJourneyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<WeekplannedJourneyModel> weekplannedJourney(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/week_planned_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_idt'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return WeekplannedJourneyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<YettoVisitModel> yettovisitJourney(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/week_skipped_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return YettoVisitModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<CheckinModel> checkin(context, id, checkin, loc) async {
    String url2 = 'https://rms2.rhapsody.ae/api/check-in';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['id'] = id;
    register['checkin_time'] = checkin;
    register['checkin_location'] = loc;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Successfully Checked In")),
          backgroundColor: Colors.black,
        ),
      );
      return CheckinModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<AddStackModel> addStock(context, outid, item, km) async {
    String url2 = 'https://rms2.rhapsody.ae/api/store_refill_details';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map body = {
      "employee_id": params['id'],
      "outlet_id": int.parse(km),
      "time_sheet_id": int.parse(outid),
      "refill_items": item,
    };
    print(jsonEncode(body));
    http.Response response = await http.post(
      Uri.parse(url2),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + params['token'],
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Successfully Added")),
          backgroundColor: Colors.black,
        ),
      );
      return AddStackModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<ReplenishModel> addReplenishment(context, outid, item, km) async {
    String url2 = 'https://rms2.rhapsody.ae/api/add_replenishment';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map body = {
      "employee_id": params['id'],
      "outlet_id": km.toString(),
      "timesheet_id": outid.toString(),
      "refill_items": item,
    };
    print(jsonEncode(body));
    http.Response response = await http.post(
      Uri.parse(url2),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + params['token'],
      },
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Successfully Added")),
          backgroundColor: Colors.black,
        ),
      );
      return ReplenishModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<CheckoutModel> checkout(context, id, checkin, loc) async {
    String url2 = 'https://rms2.rhapsody.ae/api/check-out';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['id'] = id;
    register['checkout_time'] = checkin;
    register['checkout_location'] = loc;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();

    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Successfully Checked Out")),
          backgroundColor: Colors.black,
        ),
      );
      return CheckoutModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<VisitedJourneyModel> visitJourney(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/week_completed_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return VisitedJourneyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<SplitShiftModel> spitshit(context, outletid) async {
    String url2 = 'https://rms2.rhapsody.ae/api/split-shift';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    register['outlet_id'] = outletid;
    log('params: $register');
    print("Split Shift Scenario Invoked");
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return SplitShiftModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Timer(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text("Split Shift exceeded")),
            backgroundColor: Colors.black,
          ),
        );
      });
    }
  }

  Future<StockModel> stock(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/stock_product_details_new';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    // params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    // register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return StockModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<TodaySkippedJourneyModel> tovisit(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/today_skipped_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return TodaySkippedJourneyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<TodayCompletedJourneyModel> visited(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/today_completed_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return TodayCompletedJourneyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<AvailabilityModel> availability(context, id) async {
    String url2 = 'https://rms2.rhapsody.ae/api/availability_details';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['time_sheet_id'] = id;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return AvailabilityModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<AddavailabilityModel> addavailability(
      context,
      outletid,
      timesheetid,
      opmid,
      List productid,
      List brandname,
      List categoryname,
      List productname,
      List check,
      List reason) async {
    String url2 = 'https://rms2.rhapsody.ae/api/add_availability';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    print("The Prod Id Vals Used for Adding : $productid");
    print("The count of Prod Id Vals Used for Adding : ${productid.length}");
    print("The B Name Vals Used for Adding : $brandname");
    print("The count of B Name Vals Used for Adding : ${brandname.length}");
    print("The C Name Vals Used for Adding : $categoryname");
    print("The count of C Name Vals Used for Adding : ${categoryname.length}");
    print("The Prod Name Vals Used for Adding : $productname");
    print(
        "The count of Prod Name Vals Used for Adding : ${productname.length}");
    print("The Check Vals Used for Adding : $check");
    print("The Reason Vals Used for Adding : $reason");
    print("The Count of Reason Vals Used for Adding : ${reason.length}");

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map body = {
      "outlet_id": outletid,
      "timesheet_id": timesheetid,
      "outlet_products_mapping_id": opmid,
      "product_id": productid,
      "brand_name": brandname,
      "category_name": categoryname,
      "product_name": productname,
      "check_value": check,
      "reason": reason,
    };
    print(jsonEncode(body));
    http.Response response = await http.post(
      Uri.parse(url2),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + params['token'],
      },
      body: jsonEncode(body),
    );
    log('data:$body');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');

      return AddavailabilityModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  // Future<StockCheckModel> stockCheckReport(
  //     context, outletId, empId, date) async {
  //   String url2 = 'https://rms2.rhapsody.ae/api/view_refill_details';
  //   SharedPreferences prefs1 = await SharedPreferences.getInstance();

  //   Map params = new HashMap<String, dynamic>();
  //   params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
  //   print("The token used : ${params['token']}");
  //   Map<String, String> register = Map();
  //   register['employee_id'] = empId;
  //   register['outlet_id'] = outletId;
  //   register['date1'] = date;
  //   log('params: $register');
  //   // try {
  //   var requestMultipart = http.MultipartRequest("GET", Uri.parse(url2));
  //   requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
  //   requestMultipart.fields.addAll(register);
  //   final responseStream = await requestMultipart.send();
  //   final response = await http.Response.fromStream(responseStream);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     // print("The response : ${response.body}");
  //     var data = jsonDecode(response.body);
  //     log('data: $data');
  //     return StockCheckModel.fromJson(data);
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw throw Exception('Failed to load album');
  //   }
  // }

  Future<StockCheckModel> stockReport(context, outletId, empId, date) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${params['token']}',
    };
    final Map<String, dynamic> requestBody = {
      'employee_id': empId,
      'outlet_id': outletId,
      'date1': date,
    };
    String url = "https://rms2.rhapsody.ae/api/view_refill_details";
    Uri uri = Uri.parse(url).replace(queryParameters: requestBody);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${params['token']}',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return StockCheckModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('API Call Error!!!');
    }
  }

  Future<LogoutModel> logout(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/logout';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      prefs1.clear();
      var data = jsonDecode(response.body);
      log('data: $data');
      return LogoutModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<VersionModel> version(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/version-check';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    //params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['number'] = AppVersion.version;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      // prefs1.clear();
      var data = jsonDecode(response.body);
      log('data: $data');

      return VersionModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Alert!!!'),
            content: const Text(
                'You seem to be on an outdated version of the app. Please update the app to continue...'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  // Close the dialog

                  await DefaultCacheManager().emptyCache();
                  if (Platform.isIOS) {
                    String url =
                        "https://apps.apple.com/in/app/rhapsody-merchandising/id1570126675";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  } else {
                    String url =
                        "https://play.google.com/store/apps/details?id=rameolic.merchandising&pcampaignid=web_share";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      throw throw Exception('Failed to load album');
    }
  }

  Future<TimesheetDailyModel> dailytimesheet(context, date) async {
    String url2 = 'https://rms2.rhapsody.ae/api/timesheet_daily';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    register['date'] = date;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return TimesheetDailyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<TimesheetMonthlyModel> monthlytimesheet(context, date) async {
    String url2 = 'https://rms2.rhapsody.ae/api/timesheet_monthly';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = params['id'];
    register['month'] = date;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return TimesheetMonthlyModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  createlog(message, status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Message : $message");
   
  }

  /* Future<UserupdateModel> userupdate(context,name,number,email,state,address) async {
    String url2 = 'http://gypz.in/api/api/main/usersupdate';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map params = new HashMap<String, dynamic>();
    params['token'] = (prefs.get("token") != "") ? prefs.get("token") : "";
    Map<String, String> register = Map();
    register['phone_number'] = number;
    register['username'] = name;
    register['email'] = email;
    register['state'] = state;
    register['address'] = address;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer '+params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    //body: params);

    print(response.body);


    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    var data = jsonDecode(response.body);
    log('data: $data');
    String userid = data["token"].toString();
    log('data: $userid');
    // Provider.of<AppProvider>(context, listen: false).setToken(userid);
    return UserupdateModel.fromJson(data);

  }*/
/*  Future<UserModel?> usermodel(context) async {
    String url2 = 'http://gypz.in/api/api/main/users';

    // try {
    final response = await http.get(Uri.parse(url2),
        // new Uri(
        //     scheme: PROTOCOL,
        //     host: HOST,
        //     //port: int.parse("3000", radix: 10),
        //     path: "adduser"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    //body: params);

    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      var data = jsonDecode(response.body);
      log('data: $data');
      return UserModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }*/
/* Future<PeopleList?> listmodel(context) async {
    String url2 = 'https://randomuser.me/api/?results=2';

    // try {
    final response = await http.get(Uri.parse(url2),
        // new Uri(
        //     scheme: PROTOCOL,
        //     host: HOST,
        //     //port: int.parse("3000", radix: 10),
        //     path: "adduser"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    //body: params);

    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      var data = jsonDecode(response.body);
      log('data: $data');
      return PeopleList.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Future<FilterModel?> filter(context, String selectedOption) async {
    String url2 = 'https://randomuser.me/api/?gender='+selectedOption;

    // try {
    final response = await http.get(Uri.parse(url2),
        // new Uri(
        //     scheme: PROTOCOL,
        //     host: HOST,
        //     //port: int.parse("3000", radix: 10),
        //     path: "adduser"),
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    //body: params);

    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      var data = jsonDecode(response.body);
      log('data: $data');
      return FilterModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }*/
}
