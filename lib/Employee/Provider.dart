import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {

  String token="";
  String name="";
  String desi="";
  int  add =0 ;

  setToken(String token){
    this.token=token;
    notifyListeners();
  }
  setName(String name){
    this.name=name;
    notifyListeners();
  }
  setDesi(String desi){
    this.desi=desi;
    notifyListeners();
  }
}