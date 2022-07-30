import 'package:fluttour/data/api/api_client/api_client.dart';
import 'package:fluttour/data/api/api_client/api_client_type.dart';
import 'package:fluttour/data/api/api_client/graphql_client.dart';
import 'package:fluttour/data/api/api_client/graphql_client_type.dart';
import 'package:fluttour/di/config_module.dart';

mixin ClientModule on ConfigModule {
  /// API Client
  APIClientType get apiClient {
    return APIClient.apiClient(
        baseDomain: appConfig.baseDomain,
        authToken: appSecureConfig.authToken
    );
  }
  // GraphQL Client
  GraphqlClientType get graphqlClient {
    return GraphqlClient(
        endPoint: appConfig.graphqlEndPoint,
        authToken: appSecureConfig.graphqlAuthToken
    );
  }
}