import 'package:graphql/client.dart';

abstract class GraphqlClientType {
  Future<QueryResult> query({required String queries});
  Future<QueryResult> mutation({required String queries});
  void handleException({required QueryResult queryResult});
}