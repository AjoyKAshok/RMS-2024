/// status : 200
/// success : true
/// data : [{"employee_id":"RMS0446","first_name":"Fahad","surname":"Parambil"},{"employee_id":"RMS0594","first_name":"Nar","surname":"Bahadur"}]

class SearchModel {
  SearchModel({
      num? status, 
      bool? success, 
      List<Data>? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  SearchModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  bool? _success;
  List<Data>? _data;
SearchModel copyWith({  num? status,
  bool? success,
  List<Data>? data,
}) => SearchModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  num? get status => _status;
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// employee_id : "RMS0446"
/// first_name : "Fahad"
/// surname : "Parambil"

class Data {
  Data({
      String? employeeId, 
      String? firstName, 
      String? surname,}){
    _employeeId = employeeId;
    _firstName = firstName;
    _surname = surname;
}

  Data.fromJson(dynamic json) {
    _employeeId = json['employee_id'];
    _firstName = json['first_name'];
    _surname = json['surname'];
  }
  String? _employeeId;
  String? _firstName;
  String? _surname;
Data copyWith({  String? employeeId,
  String? firstName,
  String? surname,
}) => Data(  employeeId: employeeId ?? _employeeId,
  firstName: firstName ?? _firstName,
  surname: surname ?? _surname,
);
  String? get employeeId => _employeeId;
  String? get firstName => _firstName;
  String? get surname => _surname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employee_id'] = _employeeId;
    map['first_name'] = _firstName;
    map['surname'] = _surname;
    return map;
  }

}