import 'package:flutter/foundation.dart';
import 'package:fluttour/data/error_response.dart';
import 'package:fluttour/data/api/graphql_client/graphql_client_type.dart';
import 'package:graphql/client.dart';

class GraphqlClient implements GraphqlClientType {
  late String _endPoint;
  late String _authToken;

  GraphqlClient({
    required String endPoint,
    required String authToken,
  }) {
    _endPoint = endPoint;
    _authToken = authToken;
  }

  GraphQLClient _instance() {
    final HttpLink httpLink = HttpLink(
      _endPoint,
    );
    /// Auth link
    final AuthLink authLink = AuthLink(
      getToken: () => 'Bearer $_authToken',
    );
    /// Link
    final Link link = authLink.concat(httpLink);
    /// Policies
    // - Remove cache
    final policies = Policies(
      fetch: FetchPolicy.networkOnly,
    );
    /// We're using HiveStore for persistence,
    /// so we need to initialize Hive.
    // final store = await HiveStore.open(path: 'my/cache/path');
    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );
  }

  @override
  Future handleException({required QueryResult<Object?> queryResult}) async {
    if (queryResult.exception?.linkException is HttpLinkServerException) {
      HttpLinkServerException httpLink = queryResult
          .exception
          ?.linkException as HttpLinkServerException;
      if (httpLink
          .parsedResponse
          ?.errors?.isNotEmpty == true
      ) {
        final String message = """"${
            httpLink.parsedResponse
                ?.errors
                ?.first.message}
        """;
        if (kDebugMode) {
          print('GraphQL Error: $message');
        }
        throw ErrorResponse(message);
      }
    }
    if (queryResult.exception
        ?.linkException is NetworkException
    ) {
      NetworkException networkException = queryResult
          .exception
          ?.linkException as NetworkException;
      final String message = """"${
          networkException.message}
        """;
      if (kDebugMode) {
        print('GraphQL Error: $message');
      }
      throw ErrorResponse(message);
    }
  }

  @override
  Future<QueryResult<Object?>> mutation({required String queries}) async {
    final MutationOptions options = MutationOptions(
      document: gql(queries),
    );
    return await _instance().mutate(options);
  }

  @override
  Future<QueryResult<Object?>> query({required String queries}) async {
    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(queries),
      pollInterval: const Duration(seconds: 15),
      fetchResults: true,
    );
    return await _instance().query(options);
  }
}