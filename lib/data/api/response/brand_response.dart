import 'package:fluttour/data/api/response/dish_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'brand_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BrandResponse {
  BrandResponse({
    this.id,
    this.name,
    this.logo,
    this.image,
    this.tags,
    this.distance,
    this.duration,
    this.kitchenBrandId,
    this.dishes,
  });

  int? id;
  String? name;
  String? logo;
  String? image;
  List<String>? tags;
  String? distance;
  String? duration;
  int? kitchenBrandId;
  @JsonKey(name: 'menu')
  List<DishResponse>? dishes;

  factory BrandResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BrandResponseToJson(this);
}