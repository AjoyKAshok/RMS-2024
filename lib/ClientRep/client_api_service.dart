import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:rms/ClientNetworkModel/OOSModel.dart';
import 'package:rms/ClientNetworkModel/ReplenishDetailModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:collection';

import 'dart:convert';
import 'dart:developer';

import 'package:rms/NetworkModelfm/Merchandiser_model.dart';

class ClientApiService {
  ClientApiService._();

  static final ClientApiService clientservice = ClientApiService._();

  Future<MerchandiserModel> cocamerchandiser(context) async {
    String url2 =
        'https://rms2.rhapsody.ae/api/merchandiser_under_cocaRep_details';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    // params['id'] = (prefs1.get("id") != "") ? prefs1.get("id") : "";
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    // Map<String, String> register = {};
    // register['emp_id'] = params['id'];
    // log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    // requestMultipart.fields.addAll(register);
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

  Future<OOSModel> clientoos(context, id, dateGiven) async {
    String url2 =
        'https://rms2.rhapsody.ae/api/today_completed_journey_under_cocaRep';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};
    register['emp_id'] = id;
    register['date'] = dateGiven;
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
      return OOSModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<ReplenishDetailModel> clientreplenish(context, dateGiven) async {
    String url2 = 'https://rms2.rhapsody.ae/api/view_replenishment';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};

    register['date'] = dateGiven;
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
      log('Replenished Data: $data');
      return ReplenishDetailModel.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }

  Future<dynamic> downloadReport(fromDate, toDate) async {
    String url2 = 'https://rms2.rhapsody.ae/api/download_oosReport';
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    Map params = HashMap<String, dynamic>();
    params['token'] = (prefs1.get("token") != "") ? prefs1.get("token") : "";
    Map<String, String> register = {};

    register['from'] = fromDate;
    register['to'] = toDate;
    log('params: $register');
    // try {
    var requestMultipart = http.MultipartRequest("POST", Uri.parse(url2));
    requestMultipart.headers['Authorization'] = 'Bearer ' + params['token'];
    requestMultipart.fields.addAll(register);
    final responseStream = await requestMultipart.send();
    final response = await http.Response.fromStream(responseStream);
    print("Check : ${response.statusCode}");
    if (response.statusCode == 200) {
      log('Replenished Data One: ${(response.body)}');
      // var data = jsonDecode(response.body);
      // log('Replenished Data: $data');
      return Uint8List.fromList(response.bodyBytes);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw throw Exception('Failed to load album');
    }
  }
}
