/// status : 200
/// success : true

class CheckoutModel {
  CheckoutModel({
      num? status, 
      bool? success,}){
    _status = status;
    _success = success;
}

  CheckoutModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
  }
  num? _status;
  bool? _success;
CheckoutModel copyWith({  num? status,
  bool? success,
}) => CheckoutModel(  status: status ?? _status,
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