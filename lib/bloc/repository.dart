import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_bloc_api/GraphQL/Connection.dart';
import 'package:test_bloc_api/GraphQL/Queries.dart';
import 'jobsModel.dart';

class Repository{
  final GraphQLClient _client = clientToQuery();

  Future<List<JobsModel>> fetchAllJobs() async{
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getAllJobsQuery),
      )
    );
    List<JobsModel> jobs =[];
    if(!result.hasException) {
      List data = result.data!["allAffiliateDetails"];
      data.forEach((e){
        jobs.add(
          JobsModel(
            id: e["affId"],
            title: e["name"],
            company: e["compId"]
            )
        );
      });
      return jobs;
    }
    return jobs;
  }
}
