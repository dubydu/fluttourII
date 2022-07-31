import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/error.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'package:fluttour/data/datasource/home/home_datasource_type.dart';
import 'package:fluttour/util/app_mixin.dart';
import 'home_repository_type.dart';

class HomeRepository with ConnectivityMixin implements HomeRepositoryType  {
  HomeRepository({required this.dataSource});

  final HomeDataSourceType dataSource;

  @override
  Future<Either<Failure, FluttourResponse>> getFluttourDoctor() async {
    if (await isInConnection()) {
      try {
        final response = await dataSource.getFluttourDoctor();
        if (response != null) {
          return Right(response);
        } else {
          return const Left(NoData());
        }
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    }
    return const Left(NoConnection());
  }
}