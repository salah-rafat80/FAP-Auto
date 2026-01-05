import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/price_list/domain/repositories/category_repository.dart';
import 'package:fap/features/price_list/data/models/create_order_request_model.dart';
import 'package:fap/features/price_list/data/models/create_order_response_model.dart';

class CreateOrder {
  final CategoryRepository repository;

  CreateOrder(this.repository);

  Future<Either<Failure, CreateOrderResponseModel>> call(
    CreateOrderRequestModel request,
  ) async {
    return await repository.createOrder(request);
  }
}
