import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/price_list/domain/entities/product_item.dart';
import 'package:fap/features/price_list/domain/repositories/category_repository.dart';

class GetPriceListDetails {
  final CategoryRepository repository;

  GetPriceListDetails(this.repository);

  Future<Either<Failure, List<ProductItem>>> call(int priceListId) async {
    return await repository.getPriceListDetails(priceListId);
  }
}
