import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/domain/model/fluttour.dart';

abstract class HomeUseCaseType {
  Future<Either<Failure, Fluttour>> getFluttourDoctor();
}