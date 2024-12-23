/// status : 200
/// success : true
/// data : 1974234

class SplitShiftModel {
  SplitShiftModel({
      var status,
      bool? success, 
      num? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  SplitShiftModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _data = json['data'];
  }
  var _status;
  bool? _success;
  num? _data;
SplitShiftModel copyWith({  var status,
  bool? success,
  num? data,
}) => SplitShiftModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  num? get status => _status;
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