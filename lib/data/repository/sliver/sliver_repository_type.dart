import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';

abstract class SliverRepositoryType {
  Future<Either<Failure, BrandResponse>> getBrand({required BrandRequest request});
}