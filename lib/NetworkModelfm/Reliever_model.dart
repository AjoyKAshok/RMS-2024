/// status : 200
/// success : true
/// data : [{"employee_id":"Emp7325","first_name":"ROJA RAMANAN","middle_name":null,"surname":"VILVAPATHY"},{"employee_id":"RMS0024","first_name":"ANKIT DHAKAL","middle_name":null,"surname":null},{"employee_id":"RMS0029","first_name":"LAL","middle_name":null,"surname":"BAHADUR THAPA"},{"employee_id":"RMS0065","first_name":"SAJJAD KHAN","middle_name":null,"surname":null},{"employee_id":"RMS0070","first_name":"MUHAMMAD WAQAS","middle_name":null,"surname":null},{"employee_id":"RMS0075","first_name":"AKBER ALI HASSAN","middle_name":null,"surname":null},{"employee_id":"RMS0089","first_name":"SHANKAR","middle_name":null,"surname":"BASNET LALIT"},{"employee_id":"RMS0094","first_name":"RAM BAHADUR RAWAL","middle_name":null,"surname":null},{"employee_id":"RMS0124","first_name":"EMI JOHN ABRAHAM","middle_name":null,"surname":null},{"employee_id":"RMS0134","first_name":"MAHMOUD ATTIA","middle_name":null,"surname":null},{"employee_id":"RMS0161","first_name":"FASALURAHMAN VATTEKATTEL","middle_name":null,"surname":null},{"employee_id":"RMS0168","first_name":"SHIVA TIMALSINA","middle_name":null,"surname":null},{"employee_id":"RMS0169","first_name":"LALIT JAYSWAL","middle_name":null,"surname":null},{"employee_id":"RMS0171","first_name":"MUHAMMED JUNAIS","middle_name":null,"surname":null},{"employee_id":"RMS0245","first_name":"NIMA","middle_name":null,"surname":"TSHERING LEPCHA"},{"employee_id":"RMS0336","first_name":"KUMAR RAI","middle_name":null,"surname":null},{"employee_id":"RMS0340","first_name":"PITAMBAR LAL THAKUR","middle_name":null,"surname":null},{"employee_id":"RMS0361","first_name":"MAHMOUD ABDELSALAM","middle_name":null,"surname":null},{"employee_id":"RMS0384","first_name":"KHUMA","middle_name":null,"surname":"KANTA TIWARI"},{"employee_id":"RMS0438","first_name":"Shaheer","middle_name":null,"surname":"Kolayil"},{"employee_id":"RMS0446","first_name":"Fahad","middle_name":null,"surname":"Parambil"},{"employee_id":"RMS0447","first_name":"Jasheer","middle_name":null,"surname":"Purayil"},{"employee_id":"RMS0456","first_name":"Irfan Valli","middle_name":null,"surname":"Shaik"},{"employee_id":"RMS0490","first_name":"Laxman","middle_name":null,"surname":"Ghimire"},{"employee_id":"RMS0539","first_name":"Narendra","middle_name":null,"surname":"Magar"},{"employee_id":"RMS0544","first_name":"ARMAN","middle_name":null,"surname":"NASIM"},{"employee_id":"RMS0555","first_name":"ISHWARI","middle_name":null,"surname":"NEUPANE"},{"employee_id":"RMS0566","first_name":"ASHKAR","middle_name":null,"surname":"MAHEEN"},{"employee_id":"RMS0577","first_name":"Farooq","middle_name":null,"surname":"Pasha"},{"employee_id":"RMS0579","first_name":"SHAHUL","middle_name":"HAMEED CHALIL","surname":"HAMZA"},{"employee_id":"RMS0580","first_name":"BISWAS","middle_name":null,"surname":"KHADKA"},{"employee_id":"RMS0593","first_name":"Mohamed","middle_name":null,"surname":"Abdelwahab"},{"employee_id":"RMS0594","first_name":"Nar","middle_name":null,"surname":"Bahadur"},{"employee_id":"RMS0595","first_name":"Shiv Lal","middle_name":null,"surname":"Malla"},{"employee_id":"RMS0616","first_name":"Mohamad","middle_name":null,"surname":"Mubeen"},{"employee_id":"RMS0618","first_name":"Mohamed","middle_name":null,"surname":"Tarek"},{"employee_id":"RMS0655","first_name":"Muhammad","middle_name":null,"surname":"Ahsan Butt"},{"employee_id":"RMS0721","first_name":"Suman","middle_name":null,"surname":"Silwal"},{"employee_id":"RMS0724","first_name":"Virgin","middle_name":null,"surname":"Mae"},{"employee_id":"RMS0741","first_name":"Sarath","middle_name":null,"surname":"Kumar"},{"employee_id":"RMS0752","first_name":"Shabas","middle_name":null,"surname":"Shajahan"},{"employee_id":"RMS0753","first_name":"Kumar","middle_name":null,"surname":"Ale"},{"employee_id":"RMS0755","first_name":"Sujesh","middle_name":null,"surname":"Thoniparambil"}]

class RelieverModel {
  RelieverModel({
      num? status, 
      bool? success, 
      List<Data>? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  RelieverModel.fromJson(dynamic json) {
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
RelieverModel copyWith({  num? status,
  bool? success,
  List<Data>? data,
}) => RelieverModel(  status: status ?? _status,
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

/// employee_id : "Emp7325"
/// first_name : "ROJA RAMANAN"
/// middle_name : null
/// surname : "VILVAPATHY"

class Data {
  Data({
      String? employeeId, 
      String? firstName, 
      dynamic middleName, 
      String? surname,}){
    _employeeId = employeeId;
    _firstName = firstName;
    _middleName = middleName;
    _surname = surname;
}

  Data.fromJson(dynamic json) {
    _employeeId = json['employee_id'];
    _firstName = json['first_name'];
    _middleName = json['middle_name'];
    _surname = json['surname'];
  }
  String? _employeeId;
  String? _firstName;
  dynamic _middleName;
  String? _surname;
Data copyWith({  String? employeeId,
  String? firstName,
  dynamic middleName,
  String? surname,
}) => Data(  employeeId: employeeId ?? _employeeId,
  firstName: firstName ?? _firstName,
  middleName: middleName ?? _middleName,
  surname: surname ?? _surname,
);
  String? get employeeId => _employeeId;
  String? get firstName => _firstName;
  dynamic get middleName => _middleName;
  String? get surname => _surname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employee_id'] = _employeeId;
    map['first_name'] = _firstName;
    map['middle_name'] = _middleName;
    map['surname'] = _surname;
    return map;
  }

}