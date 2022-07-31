import 'package:graphql/client.dart';

abstract class GraphqlClientType {
  Future<QueryResult> query({required String queries});
  Future<QueryResult> mutation({required String queries});
  Future handleException({required QueryResult queryResult});
}