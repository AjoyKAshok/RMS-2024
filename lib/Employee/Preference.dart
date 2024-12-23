// import 'dart:convert';
// import 'dart:io';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path_provider/path_provider.dart';

// class Preference {

//   // setSettings(SettingsModel settingsModel) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String jsonData = SettingsModel.preferenceToJson(settingsModel);
//   //   prefs.setString('settingsModel', jsonData);
//   // }
//   //
//   // Future<SettingsModel> getSettings() async {
//   //   var jsonData = await read("settingsModel");
//   //
//   //   SettingsModel settingsModel=new SettingsModel();
//   //   // if (null != jsonData) {
//   //   settingsModel = SettingsModel.preferenceFromJson(jsonData);
//   //   // } else {
//   //   //   settingsModel = new SettingsModel();
//   //   // }
//   //   return settingsModel;
//   // }

//   static setToken(String userid) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('token', userid);
//   }
//   static Future<String?> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString("token");
//     return userid;
//   }
//   static setId(String id) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('id', id);
//   }
//   static Future<String?> getid() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? id = prefs1.getString("id");
//     return id;
//   }
//   static setUser(String user) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('user', user);
//   }
//   static Future<String?> getUser() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? user = prefs1.getString("user");
//     return user;
//   }
//   static setRole(String role) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('role', role);
//   }
//   static Future<String?> getRole() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? role = prefs1.getString("role");
//     return role;
//   }
//   static setClient(String client) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('client', client);
//   }
//   static Future<String?> getClient() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? role = prefs1.getString("client");
//     return role;
//   }
//   static setPage(String page) async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     prefs2.setString('page', page);
//   }
//   static Future<String?> getpage() async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     String? page = prefs2.getString("page");
//     return page;
//   }
//   static setIds(String ids) async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     prefs2.setString('ids', ids);
//   }
//   static Future<String?> getIds() async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     String? ids = prefs2.getString("ids");
//     return ids;
//   }
//   static setPlace(String place) async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     prefs2.setString('place', place);
//   }
//   static Future<String?> getPlace() async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     String? place = prefs2.getString("place");
//     return place;
//   }
//   static setName(String name) async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     prefs2.setString('name', name);
//   }
//   static Future<String?> getName() async {
//     SharedPreferences prefs2 = await SharedPreferences.getInstance();
//     String? name = prefs2.getString("name");
//     return name;
//   }
//   static setDesi(String desi) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('desi', desi);
//   }
//   static Future<String?> getDesi() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? desi = prefs1.getString("desi");
//     return desi;
//   }
//   static setRadius(String desi) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('radius', desi);
//   }
//   static Future<String?> getRadius() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? desi = prefs1.getString("radius");
//     return desi;
//   }
//   static setNumber(String desi) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('number', desi);
//   }
//   static Future<String?> getNumber() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? desi = prefs1.getString("number");
//     return desi;
//   }
//   static setlat(String desi) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('lat', desi);
//   }
//   static Future<String?> getlat() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? desi = prefs1.getString("lat");
//     return desi;
//   }
//   static setlong(String desi) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('long', desi);
//   }
//   static Future<String?> getlong() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? desi = prefs1.getString("long");
//     return desi;
//   }
//   static setkm(String desi) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('km', desi);
//   }
//   static Future<String?> getkm() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? desi = prefs1.getString("km");
//     return desi;
//   }
//   static setMerchandiser(String merch) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('merch', merch);
//   }
//   static setMerchandiserName(String merch) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setString('empName', merch);
//   }
//   static Future<String?> getMerchandiser() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     String? merch = prefs1.getString("merch");
//     return merch;
//   }
//   static setOutlets(List<String> out) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setStringList('out', out);
//   }
//   static setUnschOutlets(List<String> out) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setStringList('uout', out);
//   }
//   static setStores(List<String> storeName) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setStringList('store', storeName);
//   }
//   static setUnschStores(List<String> storeName) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setStringList('ustore', storeName);
//   }
//   static Future<List<String>?> getOutlets() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     List<String>? out = prefs1.getStringList("out");
//     return out;
//   }
//   static Future<List<String>?> getUnschOutlets() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     List<String>? uout = prefs1.getStringList("uout");
//     return uout;
//   }
//   static setouid(List<String> ouid) async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     prefs1.setStringList('ouid', ouid);
//   }
//   static Future<List<String>?> getouid() async {
//     SharedPreferences prefs1 = await SharedPreferences.getInstance();
//     List<String>? ouid = prefs1.getStringList("ouid");
//     return ouid;
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class Preference {

  // setSettings(SettingsModel settingsModel) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String jsonData = SettingsModel.preferenceToJson(settingsModel);
  //   prefs.setString('settingsModel', jsonData);
  // }
  //
  // Future<SettingsModel> getSettings() async {
  //   var jsonData = await read("settingsModel");
  //
  //   SettingsModel settingsModel=new SettingsModel();
  //   // if (null != jsonData) {
  //   settingsModel = SettingsModel.preferenceFromJson(jsonData);
  //   // } else {
  //   //   settingsModel = new SettingsModel();
  //   // }
  //   return settingsModel;
  // }

  static setToken(String userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', userid);
  }
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString("token");
    return userid;
  }
  static setId(String id) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('id', id);
  }
  static Future<String?> getid() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? id = prefs1.getString("id");
    return id;
  }
  static setUser(String user) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('user', user);
  }
  static Future<String?> getUser() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? user = prefs1.getString("user");
    return user;
  }
  static setRole(String role) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('role', role);
  }
  static Future<String?> getRole() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? role = prefs1.getString("role");
    return role;
  }
  static setClient(String client) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('client', client);
  }
  static Future<String?> getClient() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? role = prefs1.getString("client");
    return role;
  }
  static setPage(String page) async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    prefs2.setString('page', page);
  }
  static Future<String?> getpage() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? page = prefs2.getString("page");
    return page;
  }
  static setIds(String ids) async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    prefs2.setString('ids', ids);
  }
  static Future<String?> getIds() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? ids = prefs2.getString("ids");
    return ids;
  }
  static setPlace(String place) async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    prefs2.setString('place', place);
  }
  static Future<String?> getPlace() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? place = prefs2.getString("place");
    return place;
  }
  static setName(String name) async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    prefs2.setString('name', name);
  }
  static Future<String?> getName() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String? name = prefs2.getString("name");
    return name;
  }
  static setDesi(String desi) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('desi', desi);
  }
  static Future<String?> getDesi() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? desi = prefs1.getString("desi");
    return desi;
  }
  static setRadius(String desi) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('radius', desi);
  }
  static Future<String?> getRadius() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? desi = prefs1.getString("radius");
    return desi;
  }
  static setNumber(String desi) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('number', desi);
  }
  static Future<String?> getNumber() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? desi = prefs1.getString("number");
    return desi;
  }
  static setlat(String desi) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('lat', desi);
  }
  static Future<String?> getlat() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? desi = prefs1.getString("lat");
    return desi;
  }
  static setlong(String desi) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('long', desi);
  }
  static Future<String?> getlong() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? desi = prefs1.getString("long");
    return desi;
  }
  static setkm(String desi) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('km', desi);
  }
  static Future<String?> getkm() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? desi = prefs1.getString("km");
    return desi;
  }
  static setMerchandiser(String merch) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('merch', merch);
  }
  static setMerchandiser1(String merch) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('merch1', merch);
  }
  static setMerchandiserName(String merch) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('empName', merch);
  }
  static setMerchandiserName1(String merch) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setString('empName1', merch);
  }
  static Future<String?> getMerchandiser() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? merch = prefs1.getString("merch");
    return merch;
  }
  static Future<String?> getMerchandiser1() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? merch = prefs1.getString("merch1");
    return merch;
  }
  static setOutlets(List<String> out) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setStringList('out', out);
  }
  static setOutlets1(List<String> out) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setStringList('out1', out);
  }
  static setStores(List<String> storeName) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setStringList('store', storeName);
  }
  static setStores1(List<String> storeName) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setStringList('store1', storeName);
  }
  static Future<List<String>?> getOutlets() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String>? out = prefs1.getStringList("out");
    return out;
  }
  static Future<List<String>?> getOutlets1() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String>? out = prefs1.getStringList("out1");
    return out;
  }
  static setouid(List<String> ouid) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    prefs1.setStringList('ouid', ouid);
  }
  static Future<List<String>?> getouid() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List<String>? ouid = prefs1.getStringList("ouid");
    return ouid;
  }
}