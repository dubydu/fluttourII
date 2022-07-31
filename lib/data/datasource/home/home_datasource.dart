import 'package:fluttour/data/api/api_client/api_client_type.dart';
import 'package:fluttour/data/api/graphql_client/graphql_client_type.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'home_datasource_type.dart';

class HomeDataSource implements HomeDataSourceType {
  HomeDataSource({required this.graphqlClient});

  final GraphqlClientType graphqlClient;

  @override
  Future<FluttourResponse?> getFluttourDoctor() async {
    const String query = '''
    query MyQuery {
      fluttours {
        createdAt
        cocoapodsVersion
        dartVersion
        devToolsVersion
        flutterVersion
        frameworkRevision
      }
    }
    ''';
    final result = await graphqlClient.query(queries: query);
    if (result.hasException) {
      graphqlClient.handleException(queryResult: result);
      return null;
    }
    final Map<String, dynamic>? data = result.data;
    final response = (data?['fluttours'] as List<dynamic>)
        .map((e) => FluttourResponse.fromJson(e as Map<String, dynamic>))
        .toList();
    return response.first;
  }
}