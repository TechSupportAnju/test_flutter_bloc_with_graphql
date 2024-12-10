import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_bloc_api/bloc/jobsModel.dart';
import 'package:test_bloc_api/bloc/repository.dart';
part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  Repository repository;
  JobsBloc({required this.repository}) : super(JobsInitial());
  JobsState get initialState => JobsInitial();

  Stream<JobsState> mapEventToState(
    JobsEvent event,
  ) async* {
  
    if(event is AppStarted)
    {
      yield Loading();
      var jobs = await repository.fetchAllJobs();
      yield LoadJobs(jobs:jobs);
    }
  
  }
}
