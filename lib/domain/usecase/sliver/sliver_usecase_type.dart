import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';

abstract class SliverUseCaseType {
  Future<Either<Failure, Tuple2<Brand, List<DishCategory>>>> getBrand({required int id});
}