import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_macos_app/api_repository/project_service.dart';
import 'package:my_macos_app/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/user.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends BaseBloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial());

  ProjectAppState projectAppState = ProjectAppState();

  FutureOr<void> _getProfile(
      GetProfile event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    final User? user = await ProjectService.getUserDetails();

    emit(projectAppState..user = user);
  }

  FutureOr<void> _updateProfile(
      UpdateProfile event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());

    // Map<String, dynamic> data = <String, dynamic>{
    //   "user": {
    //     "working_project_ids": [1, 2, 3],
    //     "working_hours": {"start_time": "11:00 AM", "end_time": "05:00 PM"}
    //   }
    // };
    final User? user =
        await ProjectService.updateUser(objToApi: event.objToApi);

    emit(projectAppState..user = user);
  }

  @override
  Future<void> eventHandlerMethod(
      ProjectEvent event, Emitter<ProjectState> emit) async {
    switch (event.runtimeType) {
      case const (GetProfile):
        return _getProfile(event as GetProfile, emit);
      case const (UpdateProfile):
        return _updateProfile(event as UpdateProfile, emit);
    }
  }

  @override
  ProjectState getErrorState() {
    return ProjectError();
  }
}
