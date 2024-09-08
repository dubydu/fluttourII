import 'package:dartz/dartz.dart';
import 'package:fluttour/domain/model/failure.dart';
import 'package:fluttour/domain/model/fluttour.dart';

abstract class HomeUseCaseType {
  Future<Either<Failure, Fluttour>> getFluttourDoctor();
}