import 'package:dartz/dartz.dart';
import 'package:fluttour/data/translator/sliver_translator.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/domain/model/failure.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase_type.dart';
import 'package:fluttour/domain/repository/sliver_repository_type.dart';

class SliverUseCase extends SliverUseCaseType {
  SliverUseCase({required this.repository});

  SliverRepositoryType repository;

  @override
  Future<Either<Failure, Tuple2<Brand, List<DishCategory>>>> getBrand({
    required int id,
  }) async {
    final result = await repository.getBrand(id: id);
    return result.fold((errorResponse) {
      return Left(Failure(message: errorResponse.message));
    }, (response) {
      final dishCategories = SliverTranslator.toDishCategories(brand: response);
      return Right(Tuple2(response, dishCategories));
    });
  }

  @override
  Future<Either<Failure, List<Dish>>> getRecommendDishes({
    required int id,
  }) async {
    final result = await repository.getRecommendDishes(id: id);
    return result.fold((errorResponse) {
      return Left(Failure(message: errorResponse.message));
    }, (response) {
      return Right(response);
    });
  }
}
