import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/repository/sliver/sliver_repository.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/translator/sliver_translator.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase_type.dart';

class SliverUseCase extends SliverUseCaseType {
  SliverUseCase({required this.repository});
  SliverRepository repository;

  @override
  Future<Either<Failure, Brand>> getBrand({required int id}) async {
    final result = await repository.getBrand(request: BrandRequest(id: id));
    return result.map((response) => SliverTranslator.toBrandModel(response: response));
  }
}