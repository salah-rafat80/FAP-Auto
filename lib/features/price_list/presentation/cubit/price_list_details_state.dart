part of 'price_list_details_cubit.dart';

abstract class PriceListDetailsState extends Equatable {
  const PriceListDetailsState();

  @override
  List<Object> get props => [];
}

class PriceListDetailsInitial extends PriceListDetailsState {}

class PriceListDetailsLoading extends PriceListDetailsState {}

class PriceListDetailsLoaded extends PriceListDetailsState {
  final List<ProductItem> items;

  const PriceListDetailsLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class PriceListDetailsError extends PriceListDetailsState {
  final String message;

  const PriceListDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

// Order Creation States
class OrderCreating extends PriceListDetailsState {}

class OrderCreated extends PriceListDetailsState {
  final CreateOrderResponseModel response;

  const OrderCreated(this.response);

  @override
  List<Object> get props => [response];
}

class OrderError extends PriceListDetailsState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}
