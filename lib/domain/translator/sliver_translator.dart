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
                (dish) => SliverTranslator.toDishModel(response: dish)).toList()
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

  static List<DishCategory> toDishCategories({required Brand brand}) {
    // Init dish categories
    List<DishCategory> dishCategories = [];
    // Group by category
    int dishesLength = brand.dishes?.length ?? 0;
    Iterable<int>.generate(dishesLength).toList().forEach((index) {
      Dish dish = brand.dishes![index];
      DishCategory dishCategory = DishCategory(
          id: index,
          name: dish.category,
          dishes: [dish],
          isSelected: false
      );
      if (dishCategories.where((category)
      => category.name == dishCategory.name).toList().isEmpty) {
        dishCategories.add(dishCategory);
      } else {
        final dishCategoryIndex = dishCategories.indexWhere((category)
        => category.name == dishCategory.name);
        dishCategories[dishCategoryIndex].dishes!.add(dish);
      }
    });
    // Make the first category status is selected
    dishCategories = dishCategories.map((category) {
      if (category.id == 0) {
        return category.copyWith(isSelected: true);
      }
      return category;
    }).toList();
    return dishCategories;
  }
}