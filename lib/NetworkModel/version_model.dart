/// message : "app is not up to date"
/// data : {"ios_link":"https://apps.apple.com/ae/app/rhapsody-merchandising/id1570126675","android_link":"https://play.google.com/store/apps/details?id=rameolic.merchandising"}

class VersionModel {
  VersionModel({
      String? message, 
      Data? data,}){
    _message = message;
    _data = data;
}

  VersionModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  Data? _data;
VersionModel copyWith({  String? message,
  Data? data,
}) => VersionModel(  message: message ?? _message,
  data: data ?? _data,
);
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// ios_link : "https://apps.apple.com/ae/app/rhapsody-merchandising/id1570126675"
/// android_link : "https://play.google.com/store/apps/details?id=rameolic.merchandising"

class Data {
  Data({
      String? iosLink, 
      String? androidLink,}){
    _iosLink = iosLink;
    _androidLink = androidLink;
}

  Data.fromJson(dynamic json) {
    _iosLink = json['ios_link'];
    _androidLink = json['android_link'];
  }
  String? _iosLink;
  String? _androidLink;
Data copyWith({  String? iosLink,
  String? androidLink,
}) => Data(  iosLink: iosLink ?? _iosLink,
  androidLink: androidLink ?? _androidLink,
);
  String? get iosLink => _iosLink;
  String? get androidLink => _androidLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ios_link'] = _iosLink;
    map['android_link'] = _androidLink;
    return map;
  }

}