import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/request/recommend_dishes_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'package:fluttour/data/api/response/dish_response.dart';

abstract class SliverRepositoryType {
  // Get brand
  Future<Either<Failure, BrandResponse>> getBrand({required BrandRequest request});
  // Get recommend dishes
  Future<Either<Failure, List<DishResponse>>> getRecommendDishes({
    required RecommendDishesRequest request
  });
}