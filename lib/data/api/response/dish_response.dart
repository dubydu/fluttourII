import 'package:json_annotation/json_annotation.dart';
part 'dish_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DishResponse {
  DishResponse({
    this.id,
    this.kitchenBrandId,
    this.category,
    this.name,
    this.logo,
    this.image,
    this.description,
    this.dietary,
    this.brandId,
    this.price,
    this.available,
  });

  int? id;
  int? kitchenBrandId;
  String? category;
  String? name;
  String? logo;
  String? image;
  String? description;
  String? dietary;
  int? brandId;
  String? price;
  bool? available;

  factory DishResponse.fromJson(Map<String, dynamic> json) =>
      _$DishResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DishResponseToJson(this);
}