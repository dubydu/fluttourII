import 'package:dartz/dartz.dart';
import 'package:fluttour/data/api/error.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/request/recommend_dishes_request.dart';
import 'package:fluttour/data/repository/sliver/sliver_repository_type.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';
import 'package:fluttour/domain/translator/sliver_translator.dart';
import 'package:fluttour/domain/usecase/sliver/sliver_usecase_type.dart';

class SliverUseCase extends SliverUseCaseType {
  SliverUseCase({required this.repository});

  SliverRepositoryType repository;

  @override
  Future<Either<Failure, Tuple2<Brand, List<DishCategory>>>> getBrand({required int id}) async {
    final result = await repository.getBrand(request: BrandRequest(id: id));
    return result.map((response) {
      final brand = SliverTranslator.toBrandModel(response: response);
      final dishCategories = SliverTranslator.toDishCategories(brand: brand);
      return Tuple2(brand, dishCategories);
      }
    );
  }

  @override
  Future<Either<Failure, List<Dish>>> getRecommendDishes({required int id}) async {
    final result = await repository
        .getRecommendDishes(request: RecommendDishesRequest(id: id));
    return result.map((response) {
      return SliverTranslator.toRecommendDishes(dishes: response);
    });
  }
}