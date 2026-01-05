import 'package:fap/features/price_list/domain/entities/product_item.dart';

class PriceListDetailsResponseModel {
  final String status;
  final String messageAr;
  final String messageEn;
  final int priceListId;
  final List<ProductItemModel> items;

  PriceListDetailsResponseModel({
    required this.status,
    required this.messageAr,
    required this.messageEn,
    required this.priceListId,
    required this.items,
  });

  factory PriceListDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return PriceListDetailsResponseModel(
      status: json['status'] ?? '',
      messageAr: json['messageAr'] ?? '',
      messageEn: json['messageEn'] ?? '',
      priceListId: json['priceListId'] ?? 0,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ProductItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ProductItemModel extends ProductItem {
  const ProductItemModel({
    required super.id,
    required super.itemId,
    required super.priceListId,
    required super.itemCode,
    required super.nameAr,
    required super.nameEn,
    super.itemSide,
    required super.price,
    required super.minQty,
    required super.seq,
    required super.status,
    super.notes,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['id'] ?? 0,
      itemId: json['itemId'] ?? 0,
      priceListId: json['priceListId'] ?? 0,
      itemCode: json['itemCode'] ?? '',
      nameAr: json['nameAr'] ?? '',
      nameEn: json['nameEn'] ?? '',
      itemSide: json['itemSide'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      minQty: json['minQty'] ?? 0,
      seq: json['seq'] ?? 0,
      status: json['status'] ?? '',
      notes: json['notes'],
    );
  }
}
