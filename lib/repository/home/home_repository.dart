import 'package:dartz/dartz.dart';
import 'package:fluttour/data/error_response.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'package:fluttour/data/datasource/home/home_datasource_type.dart';
import 'package:fluttour/util/app_mixin.dart';
import 'home_repository_type.dart';

class HomeRepository with ConnectivityMixin implements HomeRepositoryType  {
  HomeRepository({required this.dataSource});

  final HomeDataSourceType dataSource;

  @override
  Future<Either<ErrorResponse, FluttourResponse>> getFluttourDoctor() async {
    if (await isInConnection()) {
      try {
        final response = await dataSource.getFluttourDoctor();
        if (response != null) {
          return Right(response);
        } else {
          return const Left(NoDataErrorResponse());
        }
      } catch (e) {
        return Left(ErrorResponse(e.toString()));
      }
    }
    return const Left(NoConnectionErrorResponse());
  }
}