import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/price_list/domain/entities/category.dart';
import 'package:fap/features/price_list/domain/entities/product_item.dart';
import 'package:fap/features/price_list/data/models/create_order_request_model.dart';
import 'package:fap/features/price_list/data/models/create_order_response_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<ProductItem>>> getPriceListDetails(
    int priceListId,
  );
  Future<Either<Failure, CreateOrderResponseModel>> createOrder(
    CreateOrderRequestModel request,
  );
}
