/// status : 200
/// success : true
/// SheduleCalls : 23
/// UnSheduleCalls : 1
/// SheduleCallsDone : 11
/// UnSheduleCallsDone : 0
/// Attendance : 11
/// WorkingTime : 5
/// EffectiveTime : 6
/// TravelTime : 1
/// JourneyPlanpercentage : 0
/// LeaveCount : 0

class DashboardDailyModel {
  DashboardDailyModel({
      num? status, 
      bool? success, 
      num? sheduleCalls, 
      num? unSheduleCalls, 
      num? sheduleCallsDone, 
      num? unSheduleCallsDone, 
      num? attendance, 
      num? workingTime, 
      num? effectiveTime, 
      num? travelTime, 
      num? journeyPlanpercentage, 
      num? leaveCount,}){
    _status = status;
    _success = success;
    _sheduleCalls = sheduleCalls;
    _unSheduleCalls = unSheduleCalls;
    _sheduleCallsDone = sheduleCallsDone;
    _unSheduleCallsDone = unSheduleCallsDone;
    _attendance = attendance;
    _workingTime = workingTime;
    _effectiveTime = effectiveTime;
    _travelTime = travelTime;
    _journeyPlanpercentage = journeyPlanpercentage;
    _leaveCount = leaveCount;
}

  DashboardDailyModel.fromJson(dynamic json) {
    _status = json['status'];
    _success = json['success'];
    _sheduleCalls = json['SheduleCalls'];
    _unSheduleCalls = json['UnSheduleCalls'];
    _sheduleCallsDone = json['SheduleCallsDone'];
    _unSheduleCallsDone = json['UnSheduleCallsDone'];
    _attendance = json['Attendance'];
    _workingTime = json['WorkingTime'];
    _effectiveTime = json['EffectiveTime'];
    _travelTime = json['TravelTime'];
    _journeyPlanpercentage = json['JourneyPlanpercentage'];
    _leaveCount = json['LeaveCount'];
  }
  num? _status;
  bool? _success;
  num? _sheduleCalls;
  num? _unSheduleCalls;
  num? _sheduleCallsDone;
  num? _unSheduleCallsDone;
  num? _attendance;
  num? _workingTime;
  num? _effectiveTime;
  num? _travelTime;
  num? _journeyPlanpercentage;
  num? _leaveCount;
DashboardDailyModel copyWith({  num? status,
  bool? success,
  num? sheduleCalls,
  num? unSheduleCalls,
  num? sheduleCallsDone,
  num? unSheduleCallsDone,
  num? attendance,
  num? workingTime,
  num? effectiveTime,
  num? travelTime,
  num? journeyPlanpercentage,
  num? leaveCount,
}) => DashboardDailyModel(  status: status ?? _status,
  success: success ?? _success,
  sheduleCalls: sheduleCalls ?? _sheduleCalls,
  unSheduleCalls: unSheduleCalls ?? _unSheduleCalls,
  sheduleCallsDone: sheduleCallsDone ?? _sheduleCallsDone,
  unSheduleCallsDone: unSheduleCallsDone ?? _unSheduleCallsDone,
  attendance: attendance ?? _attendance,
  workingTime: workingTime ?? _workingTime,
  effectiveTime: effectiveTime ?? _effectiveTime,
  travelTime: travelTime ?? _travelTime,
  journeyPlanpercentage: journeyPlanpercentage ?? _journeyPlanpercentage,
  leaveCount: leaveCount ?? _leaveCount,
);
  num? get status => _status;
  bool? get success => _success;
  num? get sheduleCalls => _sheduleCalls;
  num? get unSheduleCalls => _unSheduleCalls;
  num? get sheduleCallsDone => _sheduleCallsDone;
  num? get unSheduleCallsDone => _unSheduleCallsDone;
  num? get attendance => _attendance;
  num? get workingTime => _workingTime;
  num? get effectiveTime => _effectiveTime;
  num? get travelTime => _travelTime;
  num? get journeyPlanpercentage => _journeyPlanpercentage;
  num? get leaveCount => _leaveCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['success'] = _success;
    map['SheduleCalls'] = _sheduleCalls;
    map['UnSheduleCalls'] = _unSheduleCalls;
    map['SheduleCallsDone'] = _sheduleCallsDone;
    map['UnSheduleCallsDone'] = _unSheduleCallsDone;
    map['Attendance'] = _attendance;
    map['WorkingTime'] = _workingTime;
    map['EffectiveTime'] = _effectiveTime;
    map['TravelTime'] = _travelTime;
    map['JourneyPlanpercentage'] = _journeyPlanpercentage;
    map['LeaveCount'] = _leaveCount;
    return map;
  }

}