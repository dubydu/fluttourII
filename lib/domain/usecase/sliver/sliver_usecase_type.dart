import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/error.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';

abstract class SliverUseCaseType {
  // Get brand
  Future<Either<Failure, Tuple2<Brand, List<DishCategory>>>> getBrand({
    required int id
  });
  // Get recommend dishes
  Future<Either<Failure, List<Dish>>> getRecommendDishes({
    required int id
  });
}