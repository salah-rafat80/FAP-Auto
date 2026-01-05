import 'package:equatable/equatable.dart';

class PriceListItem extends Equatable {
  final int id;
  final int itemId;
  final int priceListId;
  final String itemCode;
  final String nameAr;
  final String nameEn;
  final String? itemSide;
  final double price;
  final int minQty;
  final int seq;
  final String status;
  final String? notes;

  const PriceListItem({
    required this.id,
    required this.itemId,
    required this.priceListId,
    required this.itemCode,
    required this.nameAr,
    required this.nameEn,
    this.itemSide,
    required this.price,
    required this.minQty,
    required this.seq,
    required this.status,
    this.notes,
  });

  @override
  List<Object?> get props => [
    id,
    itemId,
    priceListId,
    itemCode,
    nameAr,
    nameEn,
    itemSide,
    price,
    minQty,
    seq,
    status,
    notes,
  ];
}
