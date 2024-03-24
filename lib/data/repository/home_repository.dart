import 'package:dartz/dartz.dart';
import 'package:fluttour/data/datasource/home/home_datasource_type.dart';
import 'package:fluttour/data/translator/base_translator.dart';
import 'package:fluttour/data/translator/home_translator.dart';
import 'package:fluttour/domain/model/failure.dart';
import 'package:fluttour/domain/model/fluttour.dart';
import 'package:fluttour/domain/repository/home_repository_type.dart';
import 'package:fluttour/util/app_mixin.dart';

class HomeRepository with ConnectivityMixin implements HomeRepositoryType {
  HomeRepository({required this.dataSource});

  final HomeDataSourceType dataSource;

  @override
  Future<Either<Failure, Fluttour>> getFluttourDoctor() async {
    if (await isInConnection()) {
      try {
        final response = await dataSource.getFluttourDoctor();
        if (response != null) {
          return Right(HomeTranslator.toModel(response: response));
        } else {
          return Left(BaseTranslator.noData());
        }
      } catch (e) {
        return Left(BaseTranslator.toFailure(e.toString()));
      }
    }
    return Left(BaseTranslator.noInternet());
  }
}
