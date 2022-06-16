import 'package:dio/dio.dart';
import 'api_client.dart';
import 'interceptor/curl_log.dart';
import 'interceptor/query.dart';

abstract class APIClientType {
  late final APIClient _apiClient;
  APIClientType({
        required String baseDomain,
        String? identityBaseDomain,
        bool disableRequestBodyLogging = false,
        bool ignoreToken = false,
        bool ignoreConnection = false
  }) {
    final dio = Dio();
    dio.interceptors.add(CurlLogInterceptor(disableRequestBody: disableRequestBodyLogging));
    dio.interceptors.add(QueryInterceptor(
      identityBaseDomain: identityBaseDomain,
      ignoreConnection: ignoreConnection,
      ignoreToken: ignoreToken,
    ));
    _apiClient = APIClient(dio, baseUrl: baseDomain);
  }

  APIClient get apiClient => _apiClient;
}
