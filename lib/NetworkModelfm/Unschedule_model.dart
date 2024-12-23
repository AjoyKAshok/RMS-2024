/// status : "200"
/// success : true
/// data : false

class UnscheduleModel {
  UnscheduleModel({
      String? status, 
      bool? success, 
      bool? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  UnscheduleModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _data = json['data'];
  }
  String? _status;
  bool? _success;
  bool? _data;
UnscheduleModel copyWith({  String? status,
  bool? success,
  bool? data,
}) => UnscheduleModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get status => _status;
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