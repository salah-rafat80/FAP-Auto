import 'package:dartz/dartz.dart';
import 'package:fap/core/error/failures.dart';
import 'package:fap/features/price_list/domain/entities/category.dart';
import 'package:fap/features/price_list/domain/repositories/category_repository.dart';

/// Use case for getting all categories
class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}
