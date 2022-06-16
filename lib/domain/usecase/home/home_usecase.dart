import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/data/repository/home/home_repository.dart';
import 'package:fluttour/domain/model/fluttour_doctor.dart';
import 'package:fluttour/domain/translator/home_translator.dart';
import 'package:fluttour/domain/usecase/home/home_usecase_type.dart';

class HomeUseCase implements HomeUseCaseType {
  HomeUseCase({required this.repository});

  final HomeRepository repository;

  @override
  Future<Either<Failure, FluttourDoctor>> getFluttourDoctor() async {
    final result = await repository.getFluttourDoctor();
    return result.map((response) => HomeTranslator.toModel(response: response));
  }
}