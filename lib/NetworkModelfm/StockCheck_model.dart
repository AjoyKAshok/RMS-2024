

class StockCheckModel {
  final int status;
  final bool success;
  final List<Data> data;

  StockCheckModel({
    required this.status,
    required this.success,
    required this.data,
  });

  factory StockCheckModel.fromJson(Map<String, dynamic> json) {
    return StockCheckModel(
      status: json['status'],
      success: json['success'],
      data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Data {
  final int id;
  final String employeeId;
  final int productId;
  final String refillDate;
  final int outletId;
  final int amount;
  final String productName;

  Data({
    required this.id,
    required this.employeeId,
    required this.productId,
    required this.refillDate,
    required this.outletId,
    required this.amount,
    required this.productName,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      employeeId: json['employee_id'],
      productId: json['product_id'],
      refillDate: json['refill_date'],
      outletId: json['outlet_id'],
      amount: json['amount'],
      productName: json['product_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'product_id': productId,
      'refill_date': refillDate,
      'outlet_id': outletId,
      'amount': amount,
      'product_name': productName,
    };
  }
}

// Usage example:

// void main() {
//   String jsonResponse = '''
//   {
//     "status": 200,
//     "success": true,
//     "data": [
//         {
//             "id": 142,
//             "employee_id": "Emp7325",
//             "product_id": 24,
//             "refill_date": "2024-06-25",
//             "outlet_id": 46,
//             "amount": 24,
//             "product_name": "GALAXY CRISPY"
//         },
//         {
//             "id": 143,
//             "employee_id": "Emp7325",
//             "product_id": 89,
//             "refill_date": "2024-06-25",
//             "outlet_id": 46,
//             "amount": 39,
//             "product_name": "SNICKERS STICK 25G 12X24 GCC NOT FOR SSS"
//         },
//         {
//             "id": 144,
//             "employee_id": "Emp7325",
//             "product_id": 105,
//             "refill_date": "2024-06-25",
//             "outlet_id": 46,
//             "amount": 39,
//             "product_name": "BOUNTY MINI 285G(10PPC)X12 AV1 "
//         },
//         {
//             "id": 145,
//             "employee_id": "Emp7325",
//             "product_id": 908,
//             "refill_date": "2024-06-25",
//             "outlet_id": 46,
//             "amount": 23,
//             "product_name": "Milkybar"
//         },
//         {
//             "id": 146,
//             "employee_id": "Emp7325",
//             "product_id": 125,
//             "refill_date": "2024-06-25",
//             "outlet_id": 46,
//             "amount": 45,
//             "product_name": "WHISKAS FISH MENUS WHOLE SARDINES IN JELLY 400G"
//         },
//         {
//             "id": 147,
//             "employee_id": "Emp7325",
//             "product_id": 149,
//             "refill_date": "2024-06-25",
//             "outlet_id": 46,
//             "amount": 60,
//             "product_name": "WHISKAS TUNA 85GX4 X6 SUPERS ONLY"
//         }
//     ]
//   }
//   ''';

//   Map<String, dynamic> jsonMap = json.decode(jsonResponse);

//   StockCheckModel apiResponse = StockCheckModel.fromJson(jsonMap);
//   print(apiResponse.status);
//   print(apiResponse.success);
//   apiResponse.data.forEach((data) {
//     print(data.productName);
//   });
// }


