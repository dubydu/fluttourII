import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';

abstract class SliverDataSourceType {
  Future<BrandResponse> getBrand({required BrandRequest request});
}