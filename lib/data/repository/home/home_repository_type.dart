import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/error/error.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';

abstract class HomeRepositoryType {
  Future<Either<Failure, FluttourResponse>> getFluttourDoctor();
}