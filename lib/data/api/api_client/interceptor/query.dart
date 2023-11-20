import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/router/gen_route.dart';

class QueryInterceptor extends InterceptorsWrapper {
  static const _contentType = 'content-type';
  static const _applicationJson = 'application/json';
  static const _authorization = 'Authorization';

  final String? identityBaseDomain;
  final bool expectResponseJson;
  final bool ignoreToken;
  final Connectivity connectivity = Connectivity();
  final bool ignoreConnection;
  final String authToken;

  QueryInterceptor({
    this.expectResponseJson = false,
    required this.identityBaseDomain,
    this.ignoreConnection = false,
    this.ignoreToken = false,
    required this.authToken,
  });

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!ignoreConnection) {
      final result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return _validateConnection(options, handler);
      }
    }
    if (!ignoreToken) {
      options.headers.addAll(<String, String>{_authorization: authToken});
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    final isInValidAuthenticationResponse =
        await _isInValidAuthenticationResponse(response);
    if (isInValidAuthenticationResponse) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error:
            'Invalid token or current token is expired. Please try logging in again!',
      );
    }
    if (!isResponseOkButNoContent(response) && expectResponseJson) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'Response format is not a json response',
      );
    }

    return super.onResponse(response, handler);
  }

  Future<bool> _isInValidAuthenticationResponse(Response? response) async {
    return response?.statusCode == 401;
  }

  bool isResponseOkButNoContent(Response response) =>
      response.statusCode == 204;

  bool? isResponseHeaderTypeJson(Map<String, List<String>> headerMap) {
    return headerMap[_contentType]
        ?.firstWhere((element) => element.contains(_applicationJson),
            orElse: () => '')
        .contains(_applicationJson);
  }

  Future _validateConnection(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (rootNavigatorKey.currentContext == null) {
      return;
    }
    return showDialog(
        context: rootNavigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) {
          return Container();
        }).then((_) {
      return onRequest(options, handler);
    });
  }
}
