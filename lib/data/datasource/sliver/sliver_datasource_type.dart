import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/request/recommend_dishes_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'package:fluttour/data/api/response/dish_response.dart';

abstract class SliverDataSourceType {
  // Get brand
  Future<BrandResponse> getBrand({required BrandRequest request});
  // Get recommend dishes
  Future<List<DishResponse>> getRecommendDishes({required RecommendDishesRequest request});
}