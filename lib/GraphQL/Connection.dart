import 'package:graphql_flutter/graphql_flutter.dart';
final HttpLink httpLink = HttpLink(
  "https://coral-app-6isbf.ondigitalocean.app/graphql",
);

GraphQLClient clientToQuery() {
  return GraphQLClient(
    // cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    cache: GraphQLCache(),
    link: httpLink,
  );
}