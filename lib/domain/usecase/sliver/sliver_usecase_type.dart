import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/domain/model/brand.dart';

abstract class SliverUseCaseType {
  Future<Either<Failure, Brand>> getBrand({required int id});
}