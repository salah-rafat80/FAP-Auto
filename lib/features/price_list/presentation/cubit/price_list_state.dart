import 'package:equatable/equatable.dart';
import 'package:fap/features/price_list/domain/entities/category.dart';

abstract class PriceListState extends Equatable {
  const PriceListState();

  @override
  List<Object?> get props => [];
}

class PriceListInitial extends PriceListState {}

class PriceListLoading extends PriceListState {}

class PriceListLoaded extends PriceListState {
  final List<Category> categories;

  const PriceListLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class PriceListError extends PriceListState {
  final String message;

  const PriceListError(this.message);

  @override
  List<Object?> get props => [message];
}
