import 'package:dio/dio.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'package:fluttour/data/api/response/dish_response.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

part 'api_client_type.g.dart';

@retrofit.RestApi()
abstract class APIClientType {
  factory APIClientType(Dio dio, {String baseUrl}) = _APIClientType;

  @retrofit.GET('/fluttour-doctor')
  Future<FluttourResponse> getFluttourDoctor();

  @retrofit.GET('/brand/{id}')
  Future<BrandResponse> getBrand({
    @retrofit.Path('id') required int id
  });

  @retrofit.GET('/recommend-dishes/{id}')
  Future<List<DishResponse>> getRecommendDishes({
    @retrofit.Path('id') required int id
  });
}
