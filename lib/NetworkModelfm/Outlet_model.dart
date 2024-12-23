/// status : 200
/// success : true
/// data : [{"outlet_id":43,"outlet_name":99,"outlet_lat":"25.21865900","outlet_long":"55.40766810","outlet_area":"mirdiff","outlet_city":"Dubai","outlet_state":"Dubai","outlet_country":"UAE","is_defined":null,"is_active":1,"created_by":"Emp2784","is_assigned":"0","created_at":"2021-04-23T22:14:24.000000Z","updated_at":"2021-07-08T16:40:14.000000Z","account":null,"geo_distance":300,"store":[{"id":99,"store_code":"10275659","store_name":"CARREFOUR MIRDIF CITY CENTRE, DUBAI","contact_number":44387026,"address":"MIRDIF, DUBAI","is_active":"1","created_by":"Emp2784","created_at":"2021-06-24T21:02:38.000000Z","updated_at":"2021-06-24T21:02:38.000000Z"}]},{"outlet_id":44,"outlet_name":100,"outlet_lat":"25.26959554","outlet_long":"55.31685599","outlet_area":"al rigga","outlet_city":"Dubai","outlet_state":"Dubai","outlet_country":"UAE","is_defined":null,"is_active":1,"created_by":"Emp2784","is_assigned":"0","created_at":"2021-04-23T22:14:24.000000Z","updated_at":"2021-07-08T16:40:14.000000Z","account":null,"geo_distance":300,"store":[{"id":100,"store_code":"10346279","store_name":"C4 AL GHURAIR,DXB","contact_number":44387026,"address":"AL RIGGA, DXB","is_active":"1","created_by":"Emp2784","created_at":"2021-04-23T22:14:24.000000Z","updated_at":"2021-04-29T14:12:50.000000Z"}]},null]

class OutletModel {
  OutletModel({
      num? status, 
      bool? success, 
      List<Data>? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  OutletModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  bool? _success;
  List<Data>? _data;
OutletModel copyWith({  num? status,
  bool? success,
  List<Data>? data,
}) => OutletModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  num? get status => _status;
  bool? get success => _success;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// outlet_id : 43
/// outlet_name : 99
/// outlet_lat : "25.21865900"
/// outlet_long : "55.40766810"
/// outlet_area : "mirdiff"
/// outlet_city : "Dubai"
/// outlet_state : "Dubai"
/// outlet_country : "UAE"
/// is_defined : null
/// is_active : 1
/// created_by : "Emp2784"
/// is_assigned : "0"
/// created_at : "2021-04-23T22:14:24.000000Z"
/// updated_at : "2021-07-08T16:40:14.000000Z"
/// account : null
/// geo_distance : 300
/// store : [{"id":99,"store_code":"10275659","store_name":"CARREFOUR MIRDIF CITY CENTRE, DUBAI","contact_number":44387026,"address":"MIRDIF, DUBAI","is_active":"1","created_by":"Emp2784","created_at":"2021-06-24T21:02:38.000000Z","updated_at":"2021-06-24T21:02:38.000000Z"}]

class Data {
  Data({
      num? outletId, 
      num? outletName, 
      String? outletLat, 
      String? outletLong, 
      String? outletArea, 
      String? outletCity, 
      String? outletState, 
      String? outletCountry, 
      dynamic isDefined, 
      num? isActive, 
      String? createdBy, 
      String? isAssigned, 
      String? createdAt, 
      String? updatedAt, 
      dynamic account, 
      num? geoDistance, 
      List<Store>? store,}){
    _outletId = outletId;
    _outletName = outletName;
    _outletLat = outletLat;
    _outletLong = outletLong;
    _outletArea = outletArea;
    _outletCity = outletCity;
    _outletState = outletState;
    _outletCountry = outletCountry;
    _isDefined = isDefined;
    _isActive = isActive;
    _createdBy = createdBy;
    _isAssigned = isAssigned;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _account = account;
    _geoDistance = geoDistance;
    _store = store;
}

  Data.fromJson(dynamic json) {
    _outletId = json['outlet_id'];
    _outletName = json['outlet_name'];
    _outletLat = json['outlet_lat'];
    _outletLong = json['outlet_long'];
    _outletArea = json['outlet_area'];
    _outletCity = json['outlet_city'];
    _outletState = json['outlet_state'];
    _outletCountry = json['outlet_country'];
    _isDefined = json['is_defined'];
    _isActive = json['is_active'];
    _createdBy = json['created_by'];
    _isAssigned = json['is_assigned'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _account = json['account'];
    _geoDistance = json['geo_distance'];
    if (json['store'] != null) {
      _store = [];
      json['store'].forEach((v) {
        _store?.add(Store.fromJson(v));
      });
    }
  }
  num? _outletId;
  num? _outletName;
  String? _outletLat;
  String? _outletLong;
  String? _outletArea;
  String? _outletCity;
  String? _outletState;
  String? _outletCountry;
  dynamic _isDefined;
  num? _isActive;
  String? _createdBy;
  String? _isAssigned;
  String? _createdAt;
  String? _updatedAt;
  dynamic _account;
  num? _geoDistance;
  List<Store>? _store;
Data copyWith({  num? outletId,
  num? outletName,
  String? outletLat,
  String? outletLong,
  String? outletArea,
  String? outletCity,
  String? outletState,
  String? outletCountry,
  dynamic isDefined,
  num? isActive,
  String? createdBy,
  String? isAssigned,
  String? createdAt,
  String? updatedAt,
  dynamic account,
  num? geoDistance,
  List<Store>? store,
}) => Data(  outletId: outletId ?? _outletId,
  outletName: outletName ?? _outletName,
  outletLat: outletLat ?? _outletLat,
  outletLong: outletLong ?? _outletLong,
  outletArea: outletArea ?? _outletArea,
  outletCity: outletCity ?? _outletCity,
  outletState: outletState ?? _outletState,
  outletCountry: outletCountry ?? _outletCountry,
  isDefined: isDefined ?? _isDefined,
  isActive: isActive ?? _isActive,
  createdBy: createdBy ?? _createdBy,
  isAssigned: isAssigned ?? _isAssigned,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  account: account ?? _account,
  geoDistance: geoDistance ?? _geoDistance,
  store: store ?? _store,
);
  num? get outletId => _outletId;
  num? get outletName => _outletName;
  String? get outletLat => _outletLat;
  String? get outletLong => _outletLong;
  String? get outletArea => _outletArea;
  String? get outletCity => _outletCity;
  String? get outletState => _outletState;
  String? get outletCountry => _outletCountry;
  dynamic get isDefined => _isDefined;
  num? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get isAssigned => _isAssigned;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get account => _account;
  num? get geoDistance => _geoDistance;
  List<Store>? get store => _store;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['outlet_id'] = _outletId;
    map['outlet_name'] = _outletName;
    map['outlet_lat'] = _outletLat;
    map['outlet_long'] = _outletLong;
    map['outlet_area'] = _outletArea;
    map['outlet_city'] = _outletCity;
    map['outlet_state'] = _outletState;
    map['outlet_country'] = _outletCountry;
    map['is_defined'] = _isDefined;
    map['is_active'] = _isActive;
    map['created_by'] = _createdBy;
    map['is_assigned'] = _isAssigned;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['account'] = _account;
    map['geo_distance'] = _geoDistance;
    if (_store != null) {
      map['store'] = _store?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 99
/// store_code : "10275659"
/// store_name : "CARREFOUR MIRDIF CITY CENTRE, DUBAI"
/// contact_number : 44387026
/// address : "MIRDIF, DUBAI"
/// is_active : "1"
/// created_by : "Emp2784"
/// created_at : "2021-06-24T21:02:38.000000Z"
/// updated_at : "2021-06-24T21:02:38.000000Z"

class Store {
  Store({
      num? id, 
      String? storeCode, 
      String? storeName, 
      num? contactNumber, 
      String? address, 
      String? isActive, 
      String? createdBy, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _storeCode = storeCode;
    _storeName = storeName;
    _contactNumber = contactNumber;
    _address = address;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Store.fromJson(dynamic json) {
    _id = json['id'];
    _storeCode = json['store_code'];
    _storeName = json['store_name'];
    _contactNumber = json['contact_number'];
    _address = json['address'];
    _isActive = json['is_active'];
    _createdBy = json['created_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _storeCode;
  String? _storeName;
  num? _contactNumber;
  String? _address;
  String? _isActive;
  String? _createdBy;
  String? _createdAt;
  String? _updatedAt;
Store copyWith({  num? id,
  String? storeCode,
  String? storeName,
  num? contactNumber,
  String? address,
  String? isActive,
  String? createdBy,
  String? createdAt,
  String? updatedAt,
}) => Store(  id: id ?? _id,
  storeCode: storeCode ?? _storeCode,
  storeName: storeName ?? _storeName,
  contactNumber: contactNumber ?? _contactNumber,
  address: address ?? _address,
  isActive: isActive ?? _isActive,
  createdBy: createdBy ?? _createdBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get storeCode => _storeCode;
  String? get storeName => _storeName;
  num? get contactNumber => _contactNumber;
  String? get address => _address;
  String? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['store_code'] = _storeCode;
    map['store_name'] = _storeName;
    map['contact_number'] = _contactNumber;
    map['address'] = _address;
    map['is_active'] = _isActive;
    map['created_by'] = _createdBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}