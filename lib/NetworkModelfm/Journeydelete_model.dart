/// status : "200"
/// success : true
/// data : 1

class JourneydeleteModel {
  JourneydeleteModel({
      String? status, 
      bool? success, 
      num? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  JourneydeleteModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _data = json['data'];
  }
  String? _status;
  bool? _success;
  num? _data;
JourneydeleteModel copyWith({  String? status,
  bool? success,
  num? data,
}) => JourneydeleteModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get status => _status;
  bool? get success => _success;
  num? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['data'] = _data;
    return map;
  }

}