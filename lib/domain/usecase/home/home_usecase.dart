import 'package:dartz/dartz.dart';
import 'package:fluttour/domain/model/failure.dart';
import 'package:fluttour/domain/model/fluttour.dart';
import 'package:fluttour/domain/usecase/home/home_usecase_type.dart';
import 'package:fluttour/domain/repository/home_repository_type.dart';

class HomeUseCase implements HomeUseCaseType {
  HomeUseCase({required this.repository});

  final HomeRepositoryType repository;

  @override
  Future<Either<Failure, Fluttour>> getFluttourDoctor() async {
    final result = await repository.getFluttourDoctor();
    return result.fold((errorResponse) {
      return Left(errorResponse);
    }, (response) {
      return Right(response);
    });
  }
}