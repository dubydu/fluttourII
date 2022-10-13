import 'package:dartz/dartz.dart';
import 'package:fluttour/data/error_response.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';

abstract class HomeRepositoryType {
  Future<Either<ErrorResponse, FluttourResponse>> getFluttourDoctor();
}