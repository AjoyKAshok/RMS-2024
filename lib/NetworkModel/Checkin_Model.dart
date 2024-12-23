/// status : 200
/// success : true

class CheckinModel {
  CheckinModel({
      num? status, 
      bool? success,}){
    _status = status;
    _success = success;
}

  CheckinModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
  }
  num? _status;
  bool? _success;
CheckinModel copyWith({  num? status,
  bool? success,
}) => CheckinModel(  status: status ?? _status,
  success: success ?? _success,
);
  num? get status => _status;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    return map;
  }

}