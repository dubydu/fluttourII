import 'package:fluttour/config/app_config.dart';
import 'package:fluttour/data/api/api_client/api_client.dart';
import 'package:fluttour/data/api/api_client/api_client_type.dart';

class ClientModule {
  /// API Client
  APIClientType get apiClient {
    return APIClient.apiClient(baseDomain: AppConfig.shared.baseDomain);
  }
}