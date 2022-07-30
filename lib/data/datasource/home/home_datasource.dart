import 'package:fluttour/data/api/api_client/api_client_type.dart';
import 'package:fluttour/data/api/api_client/graphql_client_type.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'home_datasource_type.dart';

class HomeDataSource implements HomeDataSourceType {
  HomeDataSource({required this.apiClient, required this.graphqlClient});

  final APIClientType apiClient;

  final GraphqlClientType graphqlClient;

  @override
  Future<FluttourResponse> getFluttourDoctor() async {
    return await apiClient.getFluttourDoctor();
  }
}