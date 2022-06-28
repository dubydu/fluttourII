import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'package:fluttour/data/api/response/dish_response.dart';
import 'package:fluttour/domain/model/brand.dart';
import 'package:fluttour/domain/model/dish.dart';

class SliverTranslator {
  /// To Request
  static BrandRequest toBrandRequest({required int id}) {
    return BrandRequest(id: id);
  }

  /// To Models
  static Brand toBrandModel({required BrandResponse response}) {
    return Brand(
        id: response.id,
        name: response.name,
        logo: response.logo,
        image: response.image,
        tags: response.tags,
        distance: response.distance,
        duration: response.duration,
        kitchenBrandId: response.kitchenBrandId,
        dishes: response.dishes?.map(
                (dish) => SliverTranslator.toDishModel(response: dish)
        ).toList()
    );
  }

  static Dish toDishModel({required DishResponse response}) {
    return Dish(id: response.id,
        kitchenBrandId: response.kitchenBrandId,
        category: response.category,
        name: response.name,
        image: response.image,
        description: response.description,
        brandId: response.brandId,
        price: response.price,
        available: response.available
    );
  }
}