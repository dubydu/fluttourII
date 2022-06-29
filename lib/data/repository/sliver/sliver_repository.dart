import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'package:fluttour/data/datasource/sliver/sliver_datasource_type.dart';
import 'package:fluttour/data/repository/sliver/sliver_repository_type.dart';
import 'package:fluttour/util/app_mixin.dart';

class SliverRepository with ConnectivityMixin implements SliverRepositoryType {
  SliverRepository({required this.dataSource});

  final SliverDataSourceType dataSource;

  @override
  Future<Either<Failure, BrandResponse>> getBrand({required BrandRequest request}) async {
    if (await isInConnection()) {
      try {
        final response = await dataSource.getBrand(request: request);
        return Right(response);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    }
    return const Left(NoConnection());
  }
}