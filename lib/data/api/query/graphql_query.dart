enum GraphQLQuery {
  fluttour;
}

extension GraphQLQueryX on GraphQLQuery {
  String get query {
    switch (this) {
      case GraphQLQuery.fluttour:
        return '''
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
    }
  }
}