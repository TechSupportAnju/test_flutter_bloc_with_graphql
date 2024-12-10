import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc_api/bloc/jobs_bloc.dart';
import 'package:test_bloc_api/bloc/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Repository repository = new Repository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JobsBloc>(
          create: (context)=>JobsBloc(repository: repository)..add(AppStarted()),
        )
      ],
      child:
        MaterialApp(
          title: 'Jobs Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:BlocBuilder<JobsBloc,JobsState>(
            builder: (context,state){
              return Home();
            },
          )
        )
    );

  }
}


class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("All Affiliate"),),
      body: BlocBuilder<JobsBloc,JobsState>(
        builder: (context,state) {
          if(state is Loading){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadJobs){
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: state.jobs.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(state.jobs[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(state.jobs[index].company??""),
                );
              });
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
//
// import 'bloc_row.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// final HttpLink httpLink = HttpLink("https://coral-app-6isbf.ondigitalocean.app/graphql");
// final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//   GraphQLClient(
//     link: httpLink,
//     cache: GraphQLCache(),
//   ),
// );
//
// const query =  """
// query {
//   allAffiliateDetails {
//     affId
//     name
//     mail
//     compId
//     mob
//     allBook
//   }
// }
// """;
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GraphQLProvider(
//       client: client,
//       child: MaterialApp(
//           title: 'GraphQL Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: Scaffold(
//             appBar: AppBar(
//               title: const Text(
//                 "Test",
//               ),
//             ),
//             body: Query(
//                 options: QueryOptions(
//                     document: gql(query)),
//                     // variables: const <String, dynamic>{"variableName": "value"}),
//                 builder: (result, {fetchMore, refetch}) {
//
//                   if (result.isLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (result.data == null) {
//                     return const Center(
//                       child: Text("No article found!"),
//                     );
//                   }
//                   print( result.data!);
//                   final posts = result.data!['allAffiliateDetails'];
//                   print(posts);
//                   return ListView.builder(
//                     itemCount: posts.length,
//                     itemBuilder: (context, index) {
//                       final post = posts[index];
//                       final title = post['affId'];
//                       final excerpt = post['name'];
//                       final comp = post!['compId'];
//                       return BlogRow(
//                         title: title,
//                         excerpt: excerpt,
//                         coverURL: comp,
//                       );
//                     },
//                   );
//                 }),
//           )),
//     );
//   }
// }