/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYWM2NWZkOGRkYTA5NmY3Y2M5YjQ3Yjg1YWNmN2ViZDZjNzc0YWE0ZGNiZjBhMTEyYmNkYTUwZDRjZmYzZDcwMjFkNmM0ZmE0YzUyNzMwNmEiLCJpYXQiOiIxNzA5NzI4NzIyLjA1NjcyMSIsIm5iZiI6IjE3MDk3Mjg3MjIuMDU2NzI0IiwiZXhwIjoiMTc0MTI2NDcyMi4wNTI0NzUiLCJzdWIiOiIxMDAiLCJzY29wZXMiOltdfQ.WI_C1GPzaFFaBpRoLkJMoWn3ZuP_weyZA96uB73wMK6mqb-LOiLuhWMFREtcjoLXNUzUW2VL_Tk0AjjBrRGhLMbvr8eexOPXMNljjdQPKDZqGUGXxE8jI3A5prA6oay6ytQNCQ086AuUcNJLJvT4qeccU96DrAyIR0w4zM-YqfsqBTdcEsjYN7l24k1tGn5fIZJa69P_MucfSkccV562T48jGAYZhDPUPLpaTd2W93U2vcFub5-yaYIRfjnAu7PYM5-g-5DyMj0l52VopT_0i0nYX9vlfoLsnD2f9Izcr8ld013BUQ7wWHnm_dMHSXiutxZo1nhynia9OGcsOn2waQYBzKVk__9Nhtv6YSRYgGDwWnKUzkL9BMZhwcTk5MOU65wZXakms94Z0kvZgqP-kJmy5EjQoDnzX95aZWvFAH6cfLj6uPKqzUpg9y_ckKzjy2cFOJGr_DsrA1UIPrkFVv2UyGjrzUIgVunXHz1bZMZX8h8u5EIjdDf4VV0WvCtFaA7rbCGM98IezIjMtkctBr973RTxpCEKj8OMHXVBNrFcQHEf2cMbaFOpzsiBE1Yqf9M2jyTL0GIA1KnSSEJ4AcUHtvRAY5BsHmR_dimGciYL5VWxwD2r9bVq-14lNxDMR5FTYEy7SnH7zqVwUMYrWWoVNyKi-p0KH4Db1pkd7aI"
/// user : {"id":100,"emp_id":"Emp7325","name":"Roja Ramanan","email":"vilvaroja@gmail.com","email_verified_at":null,"role_id":6,"picture":null,"is_active":"1","created_at":"2021-05-05T15:58:00.000000Z","updated_at":"2023-12-07T09:09:12.000000Z","client_id":null}
/// status : 200
/// client : "Mars GCC"

class LoginModel {
  LoginModel({
      String? token, 
      User? user, 
      num? status, 
      String? client,}){
    _token = token;
    _user = user;
    _status = status;
    _client = client;
}

  LoginModel.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _status = json['status'];
    _client = json['client'];
  }
  String? _token;
  User? _user;
  num? _status;
  String? _client;
LoginModel copyWith({  String? token,
  User? user,
  num? status,
  String? client,
}) => LoginModel(  token: token ?? _token,
  user: user ?? _user,
  status: status ?? _status,
  client: client ?? _client,
);
  String? get token => _token;
  User? get user => _user;
  num? get status => _status;
  String? get client => _client;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['status'] = _status;
    map['client'] = _client;
    return map;
  }

}

/// id : 100
/// emp_id : "Emp7325"
/// name : "Roja Ramanan"
/// email : "vilvaroja@gmail.com"
/// email_verified_at : null
/// role_id : 6
/// picture : null
/// is_active : "1"
/// created_at : "2021-05-05T15:58:00.000000Z"
/// updated_at : "2023-12-07T09:09:12.000000Z"
/// client_id : null

class User {
  User({
      num? id, 
      String? empId, 
      String? name, 
      String? email, 
      dynamic emailVerifiedAt, 
      num? roleId, 
      dynamic picture, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      dynamic clientId,}){
    _id = id;
    _empId = empId;
    _name = name;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _roleId = roleId;
    _picture = picture;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _clientId = clientId;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _empId = json['emp_id'];
    _name = json['name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _roleId = json['role_id'];
    _picture = json['picture'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _clientId = json['client_id'];
  }
  num? _id;
  String? _empId;
  String? _name;
  String? _email;
  dynamic _emailVerifiedAt;
  num? _roleId;
  dynamic _picture;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  dynamic _clientId;
User copyWith({  num? id,
  String? empId,
  String? name,
  String? email,
  dynamic emailVerifiedAt,
  num? roleId,
  dynamic picture,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  dynamic clientId,
}) => User(  id: id ?? _id,
  empId: empId ?? _empId,
  name: name ?? _name,
  email: email ?? _email,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  roleId: roleId ?? _roleId,
  picture: picture ?? _picture,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  clientId: clientId ?? _clientId,
);
  num? get id => _id;
  String? get empId => _empId;
  String? get name => _name;
  String? get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  num? get roleId => _roleId;
  dynamic get picture => _picture;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get clientId => _clientId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['emp_id'] = _empId;
    map['name'] = _name;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['role_id'] = _roleId;
    map['picture'] = _picture;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['client_id'] = _clientId;
    return map;
  }

}