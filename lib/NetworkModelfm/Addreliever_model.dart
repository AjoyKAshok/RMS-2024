/// status : 200
/// success : true
/// data : true

class AddrelieverModel {
  AddrelieverModel({
      num? status, 
      bool? success, 
      bool? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  AddrelieverModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _data = json['data'];
  }
  num? _status;
  bool? _success;
  bool? _data;
AddrelieverModel copyWith({  num? status,
  bool? success,
  bool? data,
}) => AddrelieverModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  num? get status => _status;
  bool? get success => _success;
  bool? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['data'] = _data;
    return map;
  }

}