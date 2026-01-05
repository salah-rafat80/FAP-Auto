import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fap/features/price_list/domain/entities/product_item.dart';
import 'package:fap/features/price_list/domain/usecases/get_price_list_details.dart';
import 'package:fap/features/price_list/domain/usecases/create_order.dart';
import 'package:fap/features/price_list/data/models/create_order_request_model.dart';
import 'package:fap/features/price_list/data/models/create_order_response_model.dart';

part 'price_list_details_state.dart';

class PriceListDetailsCubit extends Cubit<PriceListDetailsState> {
  final GetPriceListDetails getPriceListDetails;
  final CreateOrder createOrderUseCase;

  PriceListDetailsCubit({
    required this.getPriceListDetails,
    required this.createOrderUseCase,
  }) : super(PriceListDetailsInitial());

  Future<void> loadPriceListDetails(int priceListId) async {
    emit(PriceListDetailsLoading());
    final result = await getPriceListDetails(priceListId);
    result.fold(
      (failure) => emit(PriceListDetailsError(failure.message)),
      (items) => emit(PriceListDetailsLoaded(items)),
    );
  }

  Future<void> createOrder({
    required int priceListId,
    required Map<int, int> selectedItems,
    String? notes,
  }) async {
    emit(OrderCreating());

    final items = selectedItems.entries
        .map((e) => OrderItemModel(itemId: e.key, qty: e.value))
        .toList();

    final request = CreateOrderRequestModel(
      priceListId: priceListId,
      notes: notes,
      items: items,
    );

    final result = await createOrderUseCase(request);
    result.fold((failure) => emit(OrderError(failure.message)), (response) {
      if (response.isSuccess) {
        emit(OrderCreated(response));
      } else {
        emit(OrderError(response.messageAr));
      }
    });
  }
}
