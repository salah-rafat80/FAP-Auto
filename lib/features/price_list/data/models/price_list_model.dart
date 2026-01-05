import 'package:equatable/equatable.dart';

class PriceListModel extends Equatable {
  final String status;
  final String? messageAr;
  final String? messageEn;
  final List<PriceListItemModel> priceLists;
  final int total;

  const PriceListModel({
    required this.status,
    this.messageAr,
    this.messageEn,
    required this.priceLists,
    required this.total,
  });

  factory PriceListModel.fromJson(Map<String, dynamic> json) {
    return PriceListModel(
      status: json['status'] ?? '',
      messageAr: json['messageAr'],
      messageEn: json['messageEn'],
      priceLists: json['priceLists'] != null
          ? (json['priceLists'] as List)
                .map((e) => PriceListItemModel.fromJson(e))
                .toList()
          : [],
      total: json['total'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [status, messageAr, messageEn, priceLists, total];
}

class PriceListItemModel extends Equatable {
  final int id;
  final String? autoNumber;
  final String? nameAr;
  final String? nameEn;
  final String? messageAr;
  final String? messageEn;
  final String? priceListUrlPdf;
  final String? prefix;
  final String? priceListType;
  final String? status;
  final String? startDate;
  final String? endDate;
  final String? notes;

  const PriceListItemModel({
    required this.id,
    this.autoNumber,
    this.nameAr,
    this.nameEn,
    this.messageAr,
    this.messageEn,
    this.priceListUrlPdf,
    this.prefix,
    this.priceListType,
    this.status,
    this.startDate,
    this.endDate,
    this.notes,
  });

  factory PriceListItemModel.fromJson(Map<String, dynamic> json) {
    return PriceListItemModel(
      id: json['id'] ?? 0,
      autoNumber: json['autoNumber'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      messageAr: json['messageAr'],
      messageEn: json['messageEn'],
      priceListUrlPdf: json['priceListUrlPdf'],
      prefix: json['prefix'],
      priceListType: json['priceListType'],
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      notes: json['notes'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    autoNumber,
    nameAr,
    nameEn,
    messageAr,
    messageEn,
    priceListUrlPdf,
    prefix,
    priceListType,
    status,
    startDate,
    endDate,
    notes,
  ];
}
