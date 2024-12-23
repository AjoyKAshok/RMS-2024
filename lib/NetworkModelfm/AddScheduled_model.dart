/// status : "200"
/// success : true
/// data : true

class AddScheduledModel {
  AddScheduledModel({
      String? status, 
      bool? success, 
      // bool? data
      String? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  AddScheduledModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _data = json['data'];
  }
  String? _status;
  bool? _success;
  String? _data;
AddScheduledModel copyWith({  String? status,
  bool? success,
  String? data,
}) => AddScheduledModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get status => _status;
  bool? get success => _success;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['data'] = _data;
    return map;
  }

}