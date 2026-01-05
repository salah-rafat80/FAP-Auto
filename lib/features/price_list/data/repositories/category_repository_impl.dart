import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/price_list/data/datasources/price_list_remote_data_source.dart';
import 'package:fap/features/price_list/domain/entities/category.dart';
import 'package:fap/features/price_list/domain/entities/product_item.dart';
import 'package:fap/features/price_list/domain/repositories/category_repository.dart';
import 'package:fap/features/price_list/data/models/create_order_request_model.dart';
import 'package:fap/features/price_list/data/models/create_order_response_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final PriceListRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final priceListModels = await remoteDataSource.getPriceLists();
      final categories = priceListModels
          .map(
            (model) => Category(
              id: model.id,
              name: model.nameAr ?? '',
              pdfAssetPath: model.priceListUrlPdf ?? '',
              message: model.messageAr ?? '',
              startDate: model.startDate ?? '',
              endDate: model.endDate ?? '',
              pageCount: 0,
            ),
          )
          .toList();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductItem>>> getPriceListDetails(
    int priceListId,
  ) async {
    try {
      final productModels = await remoteDataSource.getPriceListDetails(
        priceListId,
      );
      return Right(productModels);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateOrderResponseModel>> createOrder(
    CreateOrderRequestModel request,
  ) async {
    try {
      final response = await remoteDataSource.createOrder(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
