class StoreData {
  final String storeName;
  final String storeCode;
  final String productName;
  final String brandName;
  final String categoryName;
  final String brandId;
  final String empId;
  final String empName;
  final String checkIn;
  final String checkOut;
  final String sku;
  final String amount;
  final String category;

  StoreData({
    required this.storeName,
    required this.storeCode,
    required this.productName,
    required this.brandName,
    required this.categoryName,
    required this.brandId,
    required this.empId,
    required this.empName,
    required this.checkIn,
    required this.checkOut,
    required this.sku,
    required this.amount,
    required this.category,
  });

  factory StoreData.fromMap(Map<String, dynamic> map) {
    return StoreData(
      storeName: map['store_name']?.toString().trim() ?? '',
      storeCode: map['store_code']?.toString() ?? '',
      productName: map['product_name'] ?? '',
      brandName: map['brand_name'] ?? '',
      categoryName: map['category_name'] ?? '',
      brandId: map['brand_id']?.toString() ?? '',
      empId: map['emp_id'] ?? '',
      empName: map['emp_name'] ?? '',
      checkIn: map['check_in'] ?? '',
      checkOut: map['check_out'] ?? '',
      sku: map['sku'] ?? '',
      amount: map['amount'] ?? '',
      category: map['category'] ?? '',
    );
  }
}
