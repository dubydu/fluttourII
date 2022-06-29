// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishResponse _$DishResponseFromJson(Map<String, dynamic> json) => DishResponse(
      id: json['id'] as int?,
      kitchenBrandId: json['kitchenBrandId'] as int?,
      category: json['category'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      dietary: json['dietary'] as String?,
      brandId: json['brandId'] as int?,
      price: json['price'] as String?,
      available: json['available'] as bool?,
    );

Map<String, dynamic> _$DishResponseToJson(DishResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kitchenBrandId': instance.kitchenBrandId,
      'category': instance.category,
      'name': instance.name,
      'logo': instance.logo,
      'image': instance.image,
      'description': instance.description,
      'dietary': instance.dietary,
      'brandId': instance.brandId,
      'price': instance.price,
      'available': instance.available,
    };
