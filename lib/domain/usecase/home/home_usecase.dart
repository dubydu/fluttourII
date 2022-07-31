import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/error/error.dart';
import 'package:fluttour/data/repository/home/home_repository_type.dart';
import 'package:fluttour/domain/model/fluttour.dart';
import 'package:fluttour/domain/translator/home_translator.dart';
import 'package:fluttour/domain/usecase/home/home_usecase_type.dart';

class HomeUseCase implements HomeUseCaseType {
  HomeUseCase({required this.repository});

  final HomeRepositoryType repository;

  @override
  Future<Either<Failure, Fluttour>> getFluttourDoctor() async {
    final result = await repository.getFluttourDoctor();
    return result.map((response) => HomeTranslator.toModel(response: response));
  }
}