class CreateOrderRequestModel {
  final int priceListId;
  final String? notes;
  final List<OrderItemModel> items;

  CreateOrderRequestModel({
    required this.priceListId,
    this.notes,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'priceListId': priceListId,
      'notes': notes ?? '',
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItemModel {
  final int itemId;
  final int qty;

  OrderItemModel({required this.itemId, required this.qty});

  Map<String, dynamic> toJson() {
    return {'itemId': itemId, 'qty': qty};
  }
}
