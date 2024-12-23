/// message : "You have been successfully logged out!"

class LogoutModel {
  LogoutModel({
      String? message,}){
    _message = message;
}

  LogoutModel.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
LogoutModel copyWith({  String? message,
}) => LogoutModel(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}