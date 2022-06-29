// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandResponse _$BrandResponseFromJson(Map<String, dynamic> json) =>
    BrandResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      image: json['image'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      distance: json['distance'] as String?,
      duration: json['duration'] as String?,
      kitchenBrandId: json['kitchenBrandId'] as int?,
      dishes: (json['menu'] as List<dynamic>?)
          ?.map((e) => DishResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandResponseToJson(BrandResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'image': instance.image,
      'tags': instance.tags,
      'distance': instance.distance,
      'duration': instance.duration,
      'kitchenBrandId': instance.kitchenBrandId,
      'menu': instance.dishes?.map((e) => e.toJson()).toList(),
    };
