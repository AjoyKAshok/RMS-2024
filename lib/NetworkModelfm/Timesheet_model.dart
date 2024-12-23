/// status : "200"
/// success : true
/// data : [{"id":1973448,"date":"2024-04-08","is_defined":"1","employee_id":"RMS0029","outlet_id":226,"is_present?":null,"checkin_time":"01:32:59","check_in_timestamp":"2024-04-08 01:32:59","checkout_time":"04:45:02","check_out_timestamp":"2024-04-08 04:45:02","scheduled_calls":1,"checkin_location":"Samarqand Street, Sharjah, United Arab Emirates(25.3032362,55.3764316)","checkout_location":"Sector, Dubai, United Arab Emirates(25.171166,55.4246143)","salesman_approval":null,"cde_approval":null,"salesman_remarks":null,"salesman_approved_date":null,"client_approval":null,"remarks":null,"is_active":"1","is_completed":"1","status":null,"created_at":null,"updated_at":"2021-04-29 18:13:19","created_by":"Emp2784","added_by":"RMS0081","checkin_type":"normal","reason":"normal checkin less than 300m at 01:32:58 from 4.4.13","not_finish_reason":null,"cde_approve_id":null,"device":null,"check_out_in_store":0,"store_code":"10277582","store_name":"LULU HYPER -AL NAHDA","contact_number":44387026,"address":"AL NAHDA,SHJ"},{"id":1973572,"date":"2024-04-08","is_defined":"1","employee_id":"RMS0029","outlet_id":229,"is_present?":null,"checkin_time":"06:54:13","check_in_timestamp":"2024-04-08 06:54:13","checkout_time":"09:03:38","check_out_timestamp":"2024-04-08 09:03:38","scheduled_calls":1,"checkin_location":"Lulu Hypermarket, Al Entifada 10/1, Sharjah, United Arab Emirates(25.322254919338892,55.381784531708526)","checkout_location":"Sector, Dubai, United Arab Emirates(25.171166,55.4246143)","salesman_approval":null,"cde_approval":null,"salesman_remarks":null,"salesman_approved_date":null,"client_approval":null,"remarks":null,"is_active":"1","is_completed":"1","status":null,"created_at":null,"updated_at":"2021-04-29 18:13:20","created_by":"Emp2784","added_by":"RMS0081","checkin_type":"normal","reason":"normal checkin less than 300m at 06:54:02 from 4.4.13","not_finish_reason":null,"cde_approve_id":null,"device":null,"check_out_in_store":0,"store_code":"10403271","store_name":"LULU HYPER BUHAIRA","contact_number":44387026,"address":"BUHAIRAH,SHJ"},{"id":1973696,"date":"2024-04-08","is_defined":"1","employee_id":"RMS0029","outlet_id":233,"is_present?":null,"checkin_time":"05:04:39","check_in_timestamp":"2024-04-08 05:04:39","checkout_time":"06:41:12","check_out_timestamp":"2024-04-08 06:41:12","scheduled_calls":1,"checkin_location":"Al Nahda Street 4/2, Sharjah, United Arab Emirates(25.301000301887797,55.3828389923511)","checkout_location":"Sector, Dubai, United Arab Emirates(25.171166,55.4246143)","salesman_approval":null,"cde_approval":null,"salesman_remarks":null,"salesman_approved_date":null,"client_approval":null,"remarks":null,"is_active":"1","is_completed":"1","status":null,"created_at":null,"updated_at":"2021-04-29 18:13:20","created_by":"Emp2784","added_by":"RMS0081","checkin_type":"normal","reason":"normal checkin less than 300m at 05:04:10 from 4.4.13","not_finish_reason":null,"cde_approve_id":null,"device":null,"check_out_in_store":0,"store_code":"10439629","store_name":"LULU HYPER AL RAYAN","contact_number":44387026,"address":"AL NAHDA,SHJ"}]

class TimesheetModel {
  TimesheetModel({
      String? status, 
      bool? success, 
      List<Data>? data,}){
    _status = status;
    _success = success;
    _data = data;
}

  TimesheetModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  bool? _success;
  List<Data>? _data;
TimesheetModel copyWith({  String? status,
  bool? success,
  List<Data>? data,
}) => TimesheetModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
);
  String? get status => _status;
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

/// id : 1973448
/// date : "2024-04-08"
/// is_defined : "1"
/// employee_id : "RMS0029"
/// outlet_id : 226
/// is_present? : null
/// checkin_time : "01:32:59"
/// check_in_timestamp : "2024-04-08 01:32:59"
/// checkout_time : "04:45:02"
/// check_out_timestamp : "2024-04-08 04:45:02"
/// scheduled_calls : 1
/// checkin_location : "Samarqand Street, Sharjah, United Arab Emirates(25.3032362,55.3764316)"
/// checkout_location : "Sector, Dubai, United Arab Emirates(25.171166,55.4246143)"
/// salesman_approval : null
/// cde_approval : null
/// salesman_remarks : null
/// salesman_approved_date : null
/// client_approval : null
/// remarks : null
/// is_active : "1"
/// is_completed : "1"
/// status : null
/// created_at : null
/// updated_at : "2021-04-29 18:13:19"
/// created_by : "Emp2784"
/// added_by : "RMS0081"
/// checkin_type : "normal"
/// reason : "normal checkin less than 300m at 01:32:58 from 4.4.13"
/// not_finish_reason : null
/// cde_approve_id : null
/// device : null
/// check_out_in_store : 0
/// store_code : "10277582"
/// store_name : "LULU HYPER -AL NAHDA"
/// contact_number : 44387026
/// address : "AL NAHDA,SHJ"

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
      dynamic createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? addedBy, 
      String? checkinType, 
      String? reason, 
      dynamic notFinishReason, 
      dynamic cdeApproveId, 
      dynamic device, 
      num? checkOutInStore, 
      String? storeCode, 
      String? storeName, 
      num? contactNumber, 
      String? address,}){
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
    _storeCode = storeCode;
    _storeName = storeName;
    _contactNumber = contactNumber;
    _address = address;
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
    _storeCode = json['store_code'];
    _storeName = json['store_name'];
    _contactNumber = json['contact_number'];
    _address = json['address'];
  }
  num? _id;
  String? _date;
  String? _isDefined;
  String? _employeeId;
  num? _outletId;
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
  dynamic _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _addedBy;
  String? _checkinType;
  String? _reason;
  dynamic _notFinishReason;
  dynamic _cdeApproveId;
  dynamic _device;
  num? _checkOutInStore;
  String? _storeCode;
  String? _storeName;
  num? _contactNumber;
  String? _address;
Data copyWith({  num? id,
  String? date,
  String? isDefined,
  String? employeeId,
  num? outletId,
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
  dynamic createdAt,
  String? updatedAt,
  String? createdBy,
  String? addedBy,
  String? checkinType,
  String? reason,
  dynamic notFinishReason,
  dynamic cdeApproveId,
  dynamic device,
  num? checkOutInStore,
  String? storeCode,
  String? storeName,
  num? contactNumber,
  String? address,
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
  storeCode: storeCode ?? _storeCode,
  storeName: storeName ?? _storeName,
  contactNumber: contactNumber ?? _contactNumber,
  address: address ?? _address,
);
  num? get id => _id;
  String? get date => _date;
  String? get isDefined => _isDefined;
  String? get employeeId => _employeeId;
  num? get outletId => _outletId;
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
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get addedBy => _addedBy;
  String? get checkinType => _checkinType;
  String? get reason => _reason;
  dynamic get notFinishReason => _notFinishReason;
  dynamic get cdeApproveId => _cdeApproveId;
  dynamic get device => _device;
  num? get checkOutInStore => _checkOutInStore;
  String? get storeCode => _storeCode;
  String? get storeName => _storeName;
  num? get contactNumber => _contactNumber;
  String? get address => _address;

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
    map['store_code'] = _storeCode;
    map['store_name'] = _storeName;
    map['contact_number'] = _contactNumber;
    map['address'] = _address;
    return map;
  }

}