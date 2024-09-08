import 'package:dartz/dartz.dart';
import 'package:fluttour/domain/model/failure.dart';
import 'package:fluttour/domain/model/fluttour.dart';

abstract class HomeRepositoryType {
  Future<Either<Failure, Fluttour>> getFluttourDoctor();
}