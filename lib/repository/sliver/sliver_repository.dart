import 'package:dartz/dartz.dart';
import 'package:fluttour/data/datasource/sliver/sliver_datasource_type.dart';
import 'package:fluttour/data/error_response.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/request/recommend_dishes_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'package:fluttour/data/api/response/dish_response.dart';
import 'package:fluttour/util/app_mixin.dart';

import 'sliver_repository_type.dart';

class SliverRepository with ConnectivityMixin implements SliverRepositoryType {
  SliverRepository({required this.dataSource});

  final SliverDataSourceType dataSource;

  @override
  Future<Either<ErrorResponse, BrandResponse>> getBrand({required int id}) async {
    if (await isInConnection()) {
      try {
        final response = await dataSource.getBrand(request: BrandRequest(id: id));
        return Right(response);
      } catch (e) {
        return Left(ErrorResponse(e.toString()));
      }
    }
    return const Left(NoConnectionErrorResponse());
  }

  @override
  Future<Either<ErrorResponse, List<DishResponse>>> getRecommendDishes({
    required int id
  }) async {
    if (await isInConnection()) {
      try {
          final response = await dataSource
              .getRecommendDishes(request: RecommendDishesRequest(id: id));
          return Right(response);
        } catch (e) {
          return Left(ErrorResponse(e.toString()));
        }
    }
    return const Left(NoConnectionErrorResponse());
  }
}