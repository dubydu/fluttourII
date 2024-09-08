import 'package:dartz/dartz.dart';
import 'package:fluttour/data/datasource/sliver/sliver_datasource_type.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/request/recommend_dishes_request.dart';
import 'package:fluttour/data/translator/base_translator.dart';
import 'package:fluttour/data/translator/sliver_translator.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/domain/model/failure.dart';
import 'package:fluttour/domain/repository/sliver_repository_type.dart';
import 'package:fluttour/util/app_mixin.dart';

class SliverRepository with ConnectivityMixin implements SliverRepositoryType {
  SliverRepository({required this.dataSource});

  final SliverDataSourceType dataSource;

  @override
  Future<Either<Failure, Brand>> getBrand({
    required int id,
  }) async {
    if (await isInConnection()) {
      try {
        final response =
            await dataSource.getBrand(request: BrandRequest(id: id));
        return Right(SliverTranslator.toBrandModel(response: response));
      } catch (e) {
        return Left(BaseTranslator.toFailure(e.toString()));
      }
    }
    return Left(BaseTranslator.noInternet());
  }

  @override
  Future<Either<Failure, List<Dish>>> getRecommendDishes({
    required int id,
  }) async {
    if (await isInConnection()) {
      try {
        final response = await dataSource.getRecommendDishes(
            request: RecommendDishesRequest(id: id));
        return Right(SliverTranslator.toRecommendDishes(dishes: response));
      } catch (e) {
        return Left(BaseTranslator.toFailure(e.toString()));
      }
    }
    return Left(BaseTranslator.noInternet());
  }
}
