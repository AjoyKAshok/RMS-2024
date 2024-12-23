/// status : 200
/// success : true
/// data : [{"outlet_id":145,"store_name":"SHJ COOP - AL GHARAYN,SHJ","store_code":"10097328","id":2116078,"date":"2024-05-29","is_defined":"1","employee_id":"RMS0361","is_present?":null,"checkin_time":"15:02:31","check_in_timestamp":"2024-05-29 15:02:31","checkout_time":"15:07:12","check_out_timestamp":"2024-05-29 15:07:12","scheduled_calls":1,"checkin_location":"S120 - Sharjah Cooperative Society - القرائن - 5 - الشارقة - United Arab Emirates(25.2912373,55.5008839)","checkout_location":"3 Street No. 2 - Al Qarayen 5 - Sharjah - United Arab Emirates(25.2908594,55.5008949)","salesman_approval":null,"cde_approval":null,"salesman_remarks":null,"salesman_approved_date":null,"client_approval":null,"remarks":null,"is_active":"1","is_completed":"1","status":null,"created_at":"2024-05-29 15:01:57","updated_at":"2024-05-29 15:07:12","created_by":"RMS0081","added_by":"RMS0081","checkin_type":"normal","reason":"normal checkin less than 300m at 15:02:32 from 4.4.20","not_finish_reason":null,"cde_approve_id":null,"device":null,"check_out_in_store":0,"first_name":"MAHMOUD ABDELSALAM","surname":null,"merch_id":2116078,"opm_id":1333},{"outlet_id":2820,"store_name":"RAK NATL MARKET ZAHRA","store_code":"10301500","id":2116066,"date":"2024-05-29","is_defined":"0","employee_id":"RMS0566","is_present?":null,"checkin_time":"13:58:14","check_in_timestamp":"2024-05-29 13:58:14","checkout_time":"15:00:12","check_out_timestamp":"2024-05-29 15:00:12","scheduled_calls":0,"checkin_location":"Sheikh Saqr Bin Khalid Road - RAK National Market - سيح العريبي - رأس الخيمة - United Arab Emirates(25.785622,55.9989278)","checkout_location":"65 Sheikh Muhammed Bin St - Seih Al Uraibi - Ras al Khaimah - United Arab Emirates(25.7854307,55.9992824)","salesman_approval":null,"cde_approval":null,"salesman_remarks":null,"salesman_approved_date":null,"client_approval":null,"remarks":null,"is_active":"1","is_completed":"1","status":null,"created_at":"2024-05-29 13:25:21","updated_at":"2024-05-29 15:00:12","created_by":"RMS0081","added_by":null,"checkin_type":"normal","reason":"normal checkin less than 300m at 13:58:14 from 4.4.20","not_finish_reason":null,"cde_approve_id":null,"device":"mobile","check_out_in_store":0,"first_name":"ASHKAR","surname":"MAHEEN","merch_id":2116066,"opm_id":10212}]

class ReportModel {
  ReportModel({
      num? status, 
      bool? success, 
      List<Data>? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  ReportModel.fromJson(dynamic json) {
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
ReportModel copyWith({  num? status,
  bool? success,
  List<Data>? data,
}) => ReportModel(  status: status ?? _status,
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

/// outlet_id : 145
/// store_name : "SHJ COOP - AL GHARAYN,SHJ"
/// store_code : "10097328"
/// id : 2116078
/// date : "2024-05-29"
/// is_defined : "1"
/// employee_id : "RMS0361"
/// is_present? : null
/// checkin_time : "15:02:31"
/// check_in_timestamp : "2024-05-29 15:02:31"
/// checkout_time : "15:07:12"
/// check_out_timestamp : "2024-05-29 15:07:12"
/// scheduled_calls : 1
/// checkin_location : "S120 - Sharjah Cooperative Society - القرائن - 5 - الشارقة - United Arab Emirates(25.2912373,55.5008839)"
/// checkout_location : "3 Street No. 2 - Al Qarayen 5 - Sharjah - United Arab Emirates(25.2908594,55.5008949)"
/// salesman_approval : null
/// cde_approval : null
/// salesman_remarks : null
/// salesman_approved_date : null
/// client_approval : null
/// remarks : null
/// is_active : "1"
/// is_completed : "1"
/// status : null
/// created_at : "2024-05-29 15:01:57"
/// updated_at : "2024-05-29 15:07:12"
/// created_by : "RMS0081"
/// added_by : "RMS0081"
/// checkin_type : "normal"
/// reason : "normal checkin less than 300m at 15:02:32 from 4.4.20"
/// not_finish_reason : null
/// cde_approve_id : null
/// device : null
/// check_out_in_store : 0
/// first_name : "MAHMOUD ABDELSALAM"
/// surname : null
/// merch_id : 2116078
/// opm_id : 1333

class Data {
  Data({
      num? outletId, 
      String? storeName, 
      String? storeCode, 
      num? id, 
      String? date, 
      String? isDefined, 
      String? employeeId, 
      dynamic isPresent, 
      String? checkinTime, 
      String? checkInTimestamp, 
      String? checkoutTime, 
      String? checkOutTimestamp, 
      num? scheduledCalls, 
      String? checkinLocation, 
      String? checkoutLocation, 
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
      String? addedBy, 
      String? checkinType, 
      String? reason, 
      dynamic notFinishReason, 
      dynamic cdeApproveId, 
      dynamic device, 
      num? checkOutInStore, 
      String? firstName, 
      dynamic surname, 
      num? merchId, 
      num? opmId,}){
    _outletId = outletId;
    _storeName = storeName;
    _storeCode = storeCode;
    _id = id;
    _date = date;
    _isDefined = isDefined;
    _employeeId = employeeId;
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
    _firstName = firstName;
    _surname = surname;
    _merchId = merchId;
    _opmId = opmId;
}

  Data.fromJson(dynamic json) {
    _outletId = json['outlet_id'];
    _storeName = json['store_name'];
    _storeCode = json['store_code'];
    _id = json['id'];
    _date = json['date'];
    _isDefined = json['is_defined'];
    _employeeId = json['employee_id'];
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
    _firstName = json['first_name'];
    _surname = json['surname'];
    _merchId = json['merch_id'];
    _opmId = json['opm_id'];
  }
  num? _outletId;
  String? _storeName;
  String? _storeCode;
  num? _id;
  String? _date;
  String? _isDefined;
  String? _employeeId;
  dynamic _isPresent;
  String? _checkinTime;
  String? _checkInTimestamp;
  String? _checkoutTime;
  String? _checkOutTimestamp;
  num? _scheduledCalls;
  String? _checkinLocation;
  String? _checkoutLocation;
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
  String? _addedBy;
  String? _checkinType;
  String? _reason;
  dynamic _notFinishReason;
  dynamic _cdeApproveId;
  dynamic _device;
  num? _checkOutInStore;
  String? _firstName;
  dynamic _surname;
  num? _merchId;
  num? _opmId;
Data copyWith({  num? outletId,
  String? storeName,
  String? storeCode,
  num? id,
  String? date,
  String? isDefined,
  String? employeeId,
  dynamic isPresent,
  String? checkinTime,
  String? checkInTimestamp,
  String? checkoutTime,
  String? checkOutTimestamp,
  num? scheduledCalls,
  String? checkinLocation,
  String? checkoutLocation,
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
  String? addedBy,
  String? checkinType,
  String? reason,
  dynamic notFinishReason,
  dynamic cdeApproveId,
  dynamic device,
  num? checkOutInStore,
  String? firstName,
  dynamic surname,
  num? merchId,
  num? opmId,
}) => Data(  outletId: outletId ?? _outletId,
  storeName: storeName ?? _storeName,
  storeCode: storeCode ?? _storeCode,
  id: id ?? _id,
  date: date ?? _date,
  isDefined: isDefined ?? _isDefined,
  employeeId: employeeId ?? _employeeId,
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
  firstName: firstName ?? _firstName,
  surname: surname ?? _surname,
  merchId: merchId ?? _merchId,
  opmId: opmId ?? _opmId,
);
  num? get outletId => _outletId;
  String? get storeName => _storeName;
  String? get storeCode => _storeCode;
  num? get id => _id;
  String? get date => _date;
  String? get isDefined => _isDefined;
  String? get employeeId => _employeeId;
  dynamic get isPresent => _isPresent;
  String? get checkinTime => _checkinTime;
  String? get checkInTimestamp => _checkInTimestamp;
  String? get checkoutTime => _checkoutTime;
  String? get checkOutTimestamp => _checkOutTimestamp;
  num? get scheduledCalls => _scheduledCalls;
  String? get checkinLocation => _checkinLocation;
  String? get checkoutLocation => _checkoutLocation;
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
  String? get addedBy => _addedBy;
  String? get checkinType => _checkinType;
  String? get reason => _reason;
  dynamic get notFinishReason => _notFinishReason;
  dynamic get cdeApproveId => _cdeApproveId;
  dynamic get device => _device;
  num? get checkOutInStore => _checkOutInStore;
  String? get firstName => _firstName;
  dynamic get surname => _surname;
  num? get merchId => _merchId;
  num? get opmId => _opmId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['outlet_id'] = _outletId;
    map['store_name'] = _storeName;
    map['store_code'] = _storeCode;
    map['id'] = _id;
    map['date'] = _date;
    map['is_defined'] = _isDefined;
    map['employee_id'] = _employeeId;
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
    map['first_name'] = _firstName;
    map['surname'] = _surname;
    map['merch_id'] = _merchId;
    map['opm_id'] = _opmId;
    return map;
  }

}