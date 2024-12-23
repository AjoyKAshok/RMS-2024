/// status : 200
/// success : true
/// Merchandiser : 0
/// MerchandiserPresent : 0
/// MerchandiserAbsent : 0
/// Total_Outlets : 0
/// Total_Completed_Outlets : 0
/// Total_Pending_Outlets : 0
/// Today_Outlets : 0
/// Today_Completed_Outlets : 0
/// Today_Pending_Outlets : 0
/// TotalLeaveReq : 0
/// Attendace : 521
/// AvailableLeave : 0

class DashboardFmModel {
  DashboardFmModel({
      num? status, 
      bool? success, 
      num? merchandiser, 
      num? merchandiserPresent, 
      num? merchandiserAbsent, 
      num? totalOutlets, 
      num? totalCompletedOutlets, 
      num? totalPendingOutlets, 
      num? todayOutlets, 
      num? todayCompletedOutlets, 
      num? todayPendingOutlets, 
      num? totalLeaveReq, 
      num? attendace, 
      num? availableLeave,}){
    _status = status;
    _success = success;
    _merchandiser = merchandiser;
    _merchandiserPresent = merchandiserPresent;
    _merchandiserAbsent = merchandiserAbsent;
    _totalOutlets = totalOutlets;
    _totalCompletedOutlets = totalCompletedOutlets;
    _totalPendingOutlets = totalPendingOutlets;
    _todayOutlets = todayOutlets;
    _todayCompletedOutlets = todayCompletedOutlets;
    _todayPendingOutlets = todayPendingOutlets;
    _totalLeaveReq = totalLeaveReq;
    _attendace = attendace;
    _availableLeave = availableLeave;
}

  DashboardFmModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _merchandiser = json['Merchandiser'];
    _merchandiserPresent = json['MerchandiserPresent'];
    _merchandiserAbsent = json['MerchandiserAbsent'];
    _totalOutlets = json['Total_Outlets'];
    _totalCompletedOutlets = json['Total_Completed_Outlets'];
    _totalPendingOutlets = json['Total_Pending_Outlets'];
    _todayOutlets = json['Today_Outlets'];
    _todayCompletedOutlets = json['Today_Completed_Outlets'];
    _todayPendingOutlets = json['Today_Pending_Outlets'];
    _totalLeaveReq = json['TotalLeaveReq'];
    _attendace = json['Attendace'];
    _availableLeave = json['AvailableLeave'];
  }
  num? _status;
  bool? _success;
  num? _merchandiser;
  num? _merchandiserPresent;
  num? _merchandiserAbsent;
  num? _totalOutlets;
  num? _totalCompletedOutlets;
  num? _totalPendingOutlets;
  num? _todayOutlets;
  num? _todayCompletedOutlets;
  num? _todayPendingOutlets;
  num? _totalLeaveReq;
  num? _attendace;
  num? _availableLeave;
DashboardFmModel copyWith({  num? status,
  bool? success,
  num? merchandiser,
  num? merchandiserPresent,
  num? merchandiserAbsent,
  num? totalOutlets,
  num? totalCompletedOutlets,
  num? totalPendingOutlets,
  num? todayOutlets,
  num? todayCompletedOutlets,
  num? todayPendingOutlets,
  num? totalLeaveReq,
  num? attendace,
  num? availableLeave,
}) => DashboardFmModel(  status: status ?? _status,
  success: success ?? _success,
  merchandiser: merchandiser ?? _merchandiser,
  merchandiserPresent: merchandiserPresent ?? _merchandiserPresent,
  merchandiserAbsent: merchandiserAbsent ?? _merchandiserAbsent,
  totalOutlets: totalOutlets ?? _totalOutlets,
  totalCompletedOutlets: totalCompletedOutlets ?? _totalCompletedOutlets,
  totalPendingOutlets: totalPendingOutlets ?? _totalPendingOutlets,
  todayOutlets: todayOutlets ?? _todayOutlets,
  todayCompletedOutlets: todayCompletedOutlets ?? _todayCompletedOutlets,
  todayPendingOutlets: todayPendingOutlets ?? _todayPendingOutlets,
  totalLeaveReq: totalLeaveReq ?? _totalLeaveReq,
  attendace: attendace ?? _attendace,
  availableLeave: availableLeave ?? _availableLeave,
);
  num? get status => _status;
  bool? get success => _success;
  num? get merchandiser => _merchandiser;
  num? get merchandiserPresent => _merchandiserPresent;
  num? get merchandiserAbsent => _merchandiserAbsent;
  num? get totalOutlets => _totalOutlets;
  num? get totalCompletedOutlets => _totalCompletedOutlets;
  num? get totalPendingOutlets => _totalPendingOutlets;
  num? get todayOutlets => _todayOutlets;
  num? get todayCompletedOutlets => _todayCompletedOutlets;
  num? get todayPendingOutlets => _todayPendingOutlets;
  num? get totalLeaveReq => _totalLeaveReq;
  num? get attendace => _attendace;
  num? get availableLeave => _availableLeave;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['Merchandiser'] = _merchandiser;
    map['MerchandiserPresent'] = _merchandiserPresent;
    map['MerchandiserAbsent'] = _merchandiserAbsent;
    map['Total_Outlets'] = _totalOutlets;
    map['Total_Completed_Outlets'] = _totalCompletedOutlets;
    map['Total_Pending_Outlets'] = _totalPendingOutlets;
    map['Today_Outlets'] = _todayOutlets;
    map['Today_Completed_Outlets'] = _todayCompletedOutlets;
    map['Today_Pending_Outlets'] = _todayPendingOutlets;
    map['TotalLeaveReq'] = _totalLeaveReq;
    map['Attendace'] = _attendace;
    map['AvailableLeave'] = _availableLeave;
    return map;
  }

}