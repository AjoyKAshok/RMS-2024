/// status : 200
/// success : true
/// data : [{"id":2086046,"date":"2024-05-23","is_defined":"1","employee_id":"Emp7325","outlet_id":46,"is_present?":null,"checkin_time":"09:29:16","check_in_timestamp":"2024-05-23 09:29:16","checkout_time":null,"check_out_timestamp":null,"scheduled_calls":1,"checkin_location":"X9V2+VP5, Seaport - Airport Rd, Chittethukara, Kakkanad, Kochi, Kerala 682030, India(9.9946436,76.3518396)","checkout_location":null,"salesman_approval":null,"cde_approval":null,"salesman_remarks":null,"salesman_approved_date":null,"client_approval":null,"remarks":null,"is_active":"1","is_completed":"0","status":null,"created_at":"2024-05-09 09:02:22","updated_at":"2024-05-23 09:29:16","created_by":"RMS0081","added_by":null,"checkin_type":"force","reason":null,"not_finish_reason":null,"cde_approve_id":null,"device":"mobile","check_out_in_store":null,"opm":14959,"product_id":12,"p_name":"DIARY MILK CRUNCH","Image_url":"congrats_fop_2.jpg","b_name":"SNICKERS","b_id":1,"zrep_code":"97646","product_categories":8,"c_name":"PET FOOD","is_available":"1"}]

class AvailabilityModel {
  AvailabilityModel({
      num? status, 
      bool? success, 
      List<Data>? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  AvailabilityModel.fromJson(dynamic json) {
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
AvailabilityModel copyWith({  num? status,
  bool? success,
  List<Data>? data,
}) => AvailabilityModel(  status: status ?? _status,
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

/// id : 2086046
/// date : "2024-05-23"
/// is_defined : "1"
/// employee_id : "Emp7325"
/// outlet_id : 46
/// is_present? : null
/// checkin_time : "09:29:16"
/// check_in_timestamp : "2024-05-23 09:29:16"
/// checkout_time : null
/// check_out_timestamp : null
/// scheduled_calls : 1
/// checkin_location : "X9V2+VP5, Seaport - Airport Rd, Chittethukara, Kakkanad, Kochi, Kerala 682030, India(9.9946436,76.3518396)"
/// checkout_location : null
/// salesman_approval : null
/// cde_approval : null
/// salesman_remarks : null
/// salesman_approved_date : null
/// client_approval : null
/// remarks : null
/// is_active : "1"
/// is_completed : "0"
/// status : null
/// created_at : "2024-05-09 09:02:22"
/// updated_at : "2024-05-23 09:29:16"
/// created_by : "RMS0081"
/// added_by : null
/// checkin_type : "force"
/// reason : null
/// not_finish_reason : null
/// cde_approve_id : null
/// device : "mobile"
/// check_out_in_store : null
/// opm : 14959
/// product_id : 12
/// p_name : "DIARY MILK CRUNCH"
/// Image_url : "congrats_fop_2.jpg"
/// b_name : "SNICKERS"
/// b_id : 1
/// zrep_code : "97646"
/// product_categories : 8
/// c_name : "PET FOOD"
/// is_available : "1"

class Data {
  Data({
      num? id, 
      String? date, 
      String? isDefined, 
      String? employeeId, 
      num? outletId, 
      dynamic isPresent, 
      String? checkinTime, 
      String? checkInTimestamp, 
      dynamic checkoutTime, 
      dynamic checkOutTimestamp, 
      num? scheduledCalls, 
      String? checkinLocation, 
      dynamic checkoutLocation, 
      dynamic salesmanApproval, 
      dynamic cdeApproval, 
      dynamic salesmanRemarks, 
      dynamic salesmanApprovedDate, 
      dynamic clientApproval, 
      dynamic remarks, 
      String? isActive, 
      String? isCompleted, 
      dynamic status, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      dynamic addedBy, 
      String? checkinType, 
      dynamic reason, 
      dynamic notFinishReason, 
      dynamic cdeApproveId, 
      String? device, 
      dynamic checkOutInStore, 
      num? opm, 
      num? productId, 
      String? pName, 
      String? imageUrl, 
      String? bName, 
      num? bId, 
      String? zrepCode, 
      num? productCategories, 
      String? cName, 
      String? isAvailable,}){
    _id = id;
    _date = date;
    _isDefined = isDefined;
    _employeeId = employeeId;
    _outletId = outletId;
    _isPresent = isPresent;
    _checkinTime = checkinTime;
    _checkInTimestamp = checkInTimestamp;
    _checkoutTime = checkoutTime;
    _checkOutTimestamp = checkOutTimestamp;
    _scheduledCalls = scheduledCalls;
    _checkinLocation = checkinLocation;
    _checkoutLocation = checkoutLocation;
    _salesmanApproval = salesmanApproval;
    _cdeApproval = cdeApproval;
    _salesmanRemarks = salesmanRemarks;
    _salesmanApprovedDate = salesmanApprovedDate;
    _clientApproval = clientApproval;
    _remarks = remarks;
    _isActive = isActive;
    _isCompleted = isCompleted;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _addedBy = addedBy;
    _checkinType = checkinType;
    _reason = reason;
    _notFinishReason = notFinishReason;
    _cdeApproveId = cdeApproveId;
    _device = device;
    _checkOutInStore = checkOutInStore;
    _opm = opm;
    _productId = productId;
    _pName = pName;
    _imageUrl = imageUrl;
    _bName = bName;
    _bId = bId;
    _zrepCode = zrepCode;
    _productCategories = productCategories;
    _cName = cName;
    _isAvailable = isAvailable;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _isDefined = json['is_defined'];
    _employeeId = json['employee_id'];
    _outletId = json['outlet_id'];
    _isPresent = json['is_present?'];
    _checkinTime = json['checkin_time'];
    _checkInTimestamp = json['check_in_timestamp'];
    _checkoutTime = json['checkout_time'];
    _checkOutTimestamp = json['check_out_timestamp'];
    _scheduledCalls = json['scheduled_calls'];
    _checkinLocation = json['checkin_location'];
    _checkoutLocation = json['checkout_location'];
    _salesmanApproval = json['salesman_approval'];
    _cdeApproval = json['cde_approval'];
    _salesmanRemarks = json['salesman_remarks'];
    _salesmanApprovedDate = json['salesman_approved_date'];
    _clientApproval = json['client_approval'];
    _remarks = json['remarks'];
    _isActive = json['is_active'];
    _isCompleted = json['is_completed'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _addedBy = json['added_by'];
    _checkinType = json['checkin_type'];
    _reason = json['reason'];
    _notFinishReason = json['not_finish_reason'];
    _cdeApproveId = json['cde_approve_id'];
    _device = json['device'];
    _checkOutInStore = json['check_out_in_store'];
    _opm = json['opm'];
    _productId = json['product_id'];
    _pName = json['p_name'];
    _imageUrl = json['Image_url'];
    _bName = json['b_name'];
    _bId = json['b_id'];
    _zrepCode = json['zrep_code'];
    _productCategories = json['product_categories'];
    _cName = json['c_name'];
    _isAvailable = json['is_available'];
  }
  num? _id;
  String? _date;
  String? _isDefined;
  String? _employeeId;
  num? _outletId;
  dynamic _isPresent;
  String? _checkinTime;
  String? _checkInTimestamp;
  dynamic _checkoutTime;
  dynamic _checkOutTimestamp;
  num? _scheduledCalls;
  String? _checkinLocation;
  dynamic _checkoutLocation;
  dynamic _salesmanApproval;
  dynamic _cdeApproval;
  dynamic _salesmanRemarks;
  dynamic _salesmanApprovedDate;
  dynamic _clientApproval;
  dynamic _remarks;
  String? _isActive;
  String? _isCompleted;
  dynamic _status;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  dynamic _addedBy;
  String? _checkinType;
  dynamic _reason;
  dynamic _notFinishReason;
  dynamic _cdeApproveId;
  String? _device;
  dynamic _checkOutInStore;
  num? _opm;
  num? _productId;
  String? _pName;
  String? _imageUrl;
  String? _bName;
  num? _bId;
  String? _zrepCode;
  num? _productCategories;
  String? _cName;
  String? _isAvailable;
Data copyWith({  num? id,
  String? date,
  String? isDefined,
  String? employeeId,
  num? outletId,
  dynamic isPresent,
  String? checkinTime,
  String? checkInTimestamp,
  dynamic checkoutTime,
  dynamic checkOutTimestamp,
  num? scheduledCalls,
  String? checkinLocation,
  dynamic checkoutLocation,
  dynamic salesmanApproval,
  dynamic cdeApproval,
  dynamic salesmanRemarks,
  dynamic salesmanApprovedDate,
  dynamic clientApproval,
  dynamic remarks,
  String? isActive,
  String? isCompleted,
  dynamic status,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  dynamic addedBy,
  String? checkinType,
  dynamic reason,
  dynamic notFinishReason,
  dynamic cdeApproveId,
  String? device,
  dynamic checkOutInStore,
  num? opm,
  num? productId,
  String? pName,
  String? imageUrl,
  String? bName,
  num? bId,
  String? zrepCode,
  num? productCategories,
  String? cName,
  String? isAvailable,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  isDefined: isDefined ?? _isDefined,
  employeeId: employeeId ?? _employeeId,
  outletId: outletId ?? _outletId,
  isPresent: isPresent ?? _isPresent,
  checkinTime: checkinTime ?? _checkinTime,
  checkInTimestamp: checkInTimestamp ?? _checkInTimestamp,
  checkoutTime: checkoutTime ?? _checkoutTime,
  checkOutTimestamp: checkOutTimestamp ?? _checkOutTimestamp,
  scheduledCalls: scheduledCalls ?? _scheduledCalls,
  checkinLocation: checkinLocation ?? _checkinLocation,
  checkoutLocation: checkoutLocation ?? _checkoutLocation,
  salesmanApproval: salesmanApproval ?? _salesmanApproval,
  cdeApproval: cdeApproval ?? _cdeApproval,
  salesmanRemarks: salesmanRemarks ?? _salesmanRemarks,
  salesmanApprovedDate: salesmanApprovedDate ?? _salesmanApprovedDate,
  clientApproval: clientApproval ?? _clientApproval,
  remarks: remarks ?? _remarks,
  isActive: isActive ?? _isActive,
  isCompleted: isCompleted ?? _isCompleted,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  addedBy: addedBy ?? _addedBy,
  checkinType: checkinType ?? _checkinType,
  reason: reason ?? _reason,
  notFinishReason: notFinishReason ?? _notFinishReason,
  cdeApproveId: cdeApproveId ?? _cdeApproveId,
  device: device ?? _device,
  checkOutInStore: checkOutInStore ?? _checkOutInStore,
  opm: opm ?? _opm,
  productId: productId ?? _productId,
  pName: pName ?? _pName,
  imageUrl: imageUrl ?? _imageUrl,
  bName: bName ?? _bName,
  bId: bId ?? _bId,
  zrepCode: zrepCode ?? _zrepCode,
  productCategories: productCategories ?? _productCategories,
  cName: cName ?? _cName,
  isAvailable: isAvailable ?? _isAvailable,
);
  num? get id => _id;
  String? get date => _date;
  String? get isDefined => _isDefined;
  String? get employeeId => _employeeId;
  num? get outletId => _outletId;
  dynamic get isPresent => _isPresent;
  String? get checkinTime => _checkinTime;
  String? get checkInTimestamp => _checkInTimestamp;
  dynamic get checkoutTime => _checkoutTime;
  dynamic get checkOutTimestamp => _checkOutTimestamp;
  num? get scheduledCalls => _scheduledCalls;
  String? get checkinLocation => _checkinLocation;
  dynamic get checkoutLocation => _checkoutLocation;
  dynamic get salesmanApproval => _salesmanApproval;
  dynamic get cdeApproval => _cdeApproval;
  dynamic get salesmanRemarks => _salesmanRemarks;
  dynamic get salesmanApprovedDate => _salesmanApprovedDate;
  dynamic get clientApproval => _clientApproval;
  dynamic get remarks => _remarks;
  String? get isActive => _isActive;
  String? get isCompleted => _isCompleted;
  dynamic get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  dynamic get addedBy => _addedBy;
  String? get checkinType => _checkinType;
  dynamic get reason => _reason;
  dynamic get notFinishReason => _notFinishReason;
  dynamic get cdeApproveId => _cdeApproveId;
  String? get device => _device;
  dynamic get checkOutInStore => _checkOutInStore;
  num? get opm => _opm;
  num? get productId => _productId;
  String? get pName => _pName;
  String? get imageUrl => _imageUrl;
  String? get bName => _bName;
  num? get bId => _bId;
  String? get zrepCode => _zrepCode;
  num? get productCategories => _productCategories;
  String? get cName => _cName;
  String? get isAvailable => _isAvailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['is_defined'] = _isDefined;
    map['employee_id'] = _employeeId;
    map['outlet_id'] = _outletId;
    map['is_present?'] = _isPresent;
    map['checkin_time'] = _checkinTime;
    map['check_in_timestamp'] = _checkInTimestamp;
    map['checkout_time'] = _checkoutTime;
    map['check_out_timestamp'] = _checkOutTimestamp;
    map['scheduled_calls'] = _scheduledCalls;
    map['checkin_location'] = _checkinLocation;
    map['checkout_location'] = _checkoutLocation;
    map['salesman_approval'] = _salesmanApproval;
    map['cde_approval'] = _cdeApproval;
    map['salesman_remarks'] = _salesmanRemarks;
    map['salesman_approved_date'] = _salesmanApprovedDate;
    map['client_approval'] = _clientApproval;
    map['remarks'] = _remarks;
    map['is_active'] = _isActive;
    map['is_completed'] = _isCompleted;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['added_by'] = _addedBy;
    map['checkin_type'] = _checkinType;
    map['reason'] = _reason;
    map['not_finish_reason'] = _notFinishReason;
    map['cde_approve_id'] = _cdeApproveId;
    map['device'] = _device;
    map['check_out_in_store'] = _checkOutInStore;
    map['opm'] = _opm;
    map['product_id'] = _productId;
    map['p_name'] = _pName;
    map['Image_url'] = _imageUrl;
    map['b_name'] = _bName;
    map['b_id'] = _bId;
    map['zrep_code'] = _zrepCode;
    map['product_categories'] = _productCategories;
    map['c_name'] = _cName;
    map['is_available'] = _isAvailable;
    return map;
  }

}