import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rms/Employee/MyHomePage.dart';
import 'package:rms/Employee/Preference.dart';
import 'package:rms/NetworkModel/Login_Model.dart';
import 'package:rms/NetworkModel/TimesheetMonthly_model.dart';
import 'package:rms/NetworkModel/WeekplannedJourney_Model.dart';
import 'package:rms/NetworkModelfm/AddScheduled_model.dart';
import 'package:rms/NetworkModelfm/Addreliever_model.dart';
import 'package:rms/NetworkModelfm/DashboardFm_model.dart';
import 'package:rms/NetworkModelfm/Merchandiser_model.dart';
import 'package:rms/NetworkModelfm/Outlet_model.dart';
import 'package:rms/NetworkModelfm/Reliever_model.dart';
import 'package:rms/NetworkModelfm/Relieverdetail_model.dart';
import 'package:rms/NetworkModelfm/Search_model.dart';
import 'package:rms/NetworkModelfm/Skipped_model.dart';
import 'package:rms/NetworkModelfm/Timesheet_model.dart';
import 'package:rms/NetworkModelfm/Unschedule_model.dart';
import 'package:rms/NetworkModelfm/Visited_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NetworkModelfm/Journeydelete_model.dart';
import '../NetworkModelfm/Report_model.dart';

class ApiServices {
  ApiServices._();

  static final ApiServices service = ApiServices._();

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
      //Provider.of<AppProvider>(context, listen: false).setToken(userid);
      Preference.setUser(name);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage("0")),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("Logged In Successfully")),
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

  Future<DashboardFmModel> dashboard(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/fieldmanager_dashboard';
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
      return DashboardFmModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<OutletModel> outlet(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/outlet_details';
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
      print("THe Details : $data");
      log('data: $data');
      return OutletModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<SkippedModel> skipped(context, emp) async {
    String url2 = 'https://rms2.rhapsody.ae/api/today_skipped_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = emp;
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
      return SkippedModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<VisitedModel> visited(context, emp) async {
    String url2 = 'https://rms2.rhapsody.ae/api/today_completed_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = emp;
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
      return VisitedModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<RelieverModel> reliever(context) async {
    String url2 =
        'https://rms2.rhapsody.ae/api/merchandiser_under_fieldmanager_details';
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
      return RelieverModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<RelieverdetailModel> relieverdetail(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/view_reliver_details';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log('data: $data');
      return RelieverdetailModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<AddrelieverModel> addreliver(
      context, emp, rel, fromdate, todate, reason) async {
    String url2 = 'https://rms2.rhapsody.ae/api/add_reliver';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['employee_id'] = emp;
    register['reliever_id'] = rel;
    register['from_date'] = fromdate;
    register['to_date'] = todate;
    register['reason'] = reason;
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
      return AddrelieverModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<SearchModel> searchreliver(context, emp, fromdate, todate) async {
    String url2 = 'https://rms2.rhapsody.ae/api/search_reliver';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_merch_id'] = emp;
    register['from_date'] = fromdate;
    register['to_date'] = todate;
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
      return SearchModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<TimesheetMonthlyModel> monthlytimesheet(context, date, emp) async {
    String url2 = 'https://rms2.rhapsody.ae/api/timesheet_monthly';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = emp;
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

  Future<UnscheduleModel> addunschedule(context, emp, date, outletid) async {
    String url2 = 'https://rms2.rhapsody.ae/api/add_unscheduled_journeyplan';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    Map params = HashMap<String, dynamic>();
    // params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map body = {"emp_id": emp, "date": date, "outlet_id": outletid};
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

      return UnscheduleModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<AddScheduledModel> addschedule(
      context, emp, month, days, year, outletid) async {
    // String url2 = 'https://rms2.rhapsody.ae/api/add_scheduled_journeyplan';
    String url2 = 'https://rms2.rhapsody.ae/api/add_scheduled_journeyplan_m';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    Map params = HashMap<String, dynamic>();
    // params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    final DateTime now = DateTime.now();
    Map body = {
      "emp_id": emp,
      // "month": int.parse(month),
      "months": month,
      "days": days,
      "year": year,
      "outlet_id": outletid
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
      data['data'] == "already exists"
          ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(
                  child: Text(
                      "One or More Outlets Selected Already Exists in Journey Plan.")),
              backgroundColor: Colors.red,
            ))
          : null;
      return AddScheduledModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<MerchandiserModel> merchandiser(context) async {
    String url2 =
        'https://rms2.rhapsody.ae/api/merchandiser_under_fieldmanager_details';
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
      return MerchandiserModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<WeekplannedJourneyModel> weekjourny(context, emp) async {
    String url2 = 'https://rms2.rhapsody.ae/api/week_planned_journey';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_idt'] = emp;
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

  Future<JourneydeleteModel> deletejourney(context, timesheet) async {
    String url2 = 'https://rms2.rhapsody.ae/api/delete_journeyplan';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['time_sheet_id'] = timesheet;
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
      return JourneydeleteModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<ReportModel> report(context) async {
    String url2 = 'https://rms2.rhapsody.ae/api/client_view_outlet_details';
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
      print("Outlets from Report API");
      return ReportModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<TimesheetModel> dailytimesheet(context, id, date) async {
    String url2 = 'https://rms2.rhapsody.ae/api/timesheet_daily';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    //params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = id;
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
      return TimesheetModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }
}
