class ReplenishDetailModel {
  late int status;
  late bool success;
  List<Data> data = [];

  ReplenishDetailModel(
      {required this.status, required this.success, required this.data});

  ReplenishDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  int? id;
  String? employeeId;
  String? employeeName;
  int? outletId;
  String? date;
  String? checkInTimestamp;
  String? checkOutTimestamp;
  int? scheduledCalls;
  String? isActive;
  String? isCompleted;
  String? storeCode;
  String? storeName;
  int? outletName;
  String? outletArea;
  int? opm;
  String? sku;
  int? productId;
  String? pName;
  String? bName;
  int? bId;
  String? zrepCode;
  int? productCategories;
  String? cName;
  int? amount;
  String? category;

  Data(
      {this.id,
      this.employeeId,
      this.employeeName,
      this.outletId,
      this.date,
      this.checkInTimestamp,
      this.checkOutTimestamp,
      this.scheduledCalls,
      this.isActive,
      this.isCompleted,
      this.storeCode,
      this.storeName,
      this.outletName,
      this.outletArea,
      this.opm,
      this.sku,
      this.productId,
      this.pName,
      this.bName,
      this.bId,
      this.zrepCode,
      this.productCategories,
      this.cName,
      this.amount,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    outletId = json['outlet_id'];
    date = json['date'];
    checkInTimestamp = json['check_in_timestamp'];
    checkOutTimestamp = json['check_out_timestamp'];
    scheduledCalls = json['scheduled_calls'];
    isActive = json['is_active'];
    isCompleted = json['is_completed'];
    storeCode = json['store_code'];
    storeName = json['store_name'];
    outletName = json['outlet_name'];
    outletArea = json['outlet_area'];
    opm = json['opm'];
    sku = json['sku'];
    productId = json['product_id'];
    pName = json['p_name'];
    bName = json['b_name'];
    bId = json['b_id'];
    zrepCode = json['zrep_code'];
    productCategories = json['product_categories'];
    cName = json['c_name'];
    amount = json['amount'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['outlet_id'] = outletId;
    data['date'] = date;
    data['check_in_timestamp'] = checkInTimestamp;
    data['check_out_timestamp'] = checkOutTimestamp;
    data['scheduled_calls'] = scheduledCalls;
    data['is_active'] = isActive;
    data['is_completed'] = isCompleted;
    data['store_code'] = storeCode;
    data['store_name'] = storeName;
    data['outlet_name'] = outletName;
    data['outlet_area'] = outletArea;
    data['opm'] = opm;
    data['sku'] = sku;
    data['product_id'] = productId;
    data['p_name'] = pName;
    data['b_name'] = bName;
    data['b_id'] = bId;
    data['zrep_code'] = zrepCode;
    data['product_categories'] = productCategories;
    data['c_name'] = cName;
    data['amount'] = amount;
    data['category'] = category;
    return data;
  }
}
