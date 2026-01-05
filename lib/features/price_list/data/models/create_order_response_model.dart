class CreateOrderResponseModel {
  final String status;
  final String messageAr;
  final String messageEn;
  final OrderModel? order;

  CreateOrderResponseModel({
    required this.status,
    required this.messageAr,
    required this.messageEn,
    this.order,
  });

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderResponseModel(
      status: json['status'] ?? '',
      messageAr: json['messageAr'] ?? '',
      messageEn: json['messageEn'] ?? '',
      order: json['order'] != null ? OrderModel.fromJson(json['order']) : null,
    );
  }

  bool get isSuccess => status == 'success';
}

class OrderModel {
  final int id;
  final String autoNumber;
  final String autoNumberBra;
  final int priceListId;
  final int customerId;
  final String invDate;
  final String status;
  final String? notes;
  final int itemsCount;
  final double totalValue;

  OrderModel({
    required this.id,
    required this.autoNumber,
    required this.autoNumberBra,
    required this.priceListId,
    required this.customerId,
    required this.invDate,
    required this.status,
    this.notes,
    required this.itemsCount,
    required this.totalValue,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      autoNumber: json['autoNumber'] ?? '',
      autoNumberBra: json['autoNumberBra'] ?? '',
      priceListId: json['priceListId'] ?? 0,
      customerId: json['customerId'] ?? 0,
      invDate: json['invDate'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'],
      itemsCount: json['itemsCount'] ?? 0,
      totalValue: (json['totalValue'] ?? 0).toDouble(),
    );
  }
}
