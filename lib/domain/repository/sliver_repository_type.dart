import 'package:dartz/dartz.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/domain/model/failure.dart';

abstract class SliverRepositoryType {
  // Get brand
  Future<Either<Failure, Brand>> getBrand({required int id});
  // Get recommend dishes
  Future<Either<Failure, List<Dish>>> getRecommendDishes({
    required int id
  });
}