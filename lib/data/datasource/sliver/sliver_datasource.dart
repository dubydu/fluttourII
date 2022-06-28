import 'package:fluttour/data/api/api_client/api_client_type.dart';
import 'package:fluttour/data/api/request/brand_request.dart';
import 'package:fluttour/data/api/response/brand_response.dart';
import 'sliver_datasource_type.dart';

class SliverDataSource extends APIClientType implements SliverDataSourceType {
  SliverDataSource({required super.baseDomain});

  @override
  Future<BrandResponse> getBrand({required BrandRequest request}) async {
    return await apiClient.getBrand(id: request.id);
  }
}