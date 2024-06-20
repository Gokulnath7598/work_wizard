import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:my_macos_app/api_repository/project_service.dart';
import 'package:my_macos_app/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/projects.dart';
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

    final User? user =
        await ProjectService.updateUser(objToApi: event.objToApi);

    emit(projectAppState..user = user);
  }

  FutureOr<void> _getProjects(
      GetProjects event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    final Projects? projects = await ProjectService.getProjects();

    emit(projectAppState..projects = projects);
  }

  @override
  Future<void> eventHandlerMethod(
      ProjectEvent event, Emitter<ProjectState> emit) async {
    switch (event.runtimeType) {
      case const (GetProfile):
        return _getProfile(event as GetProfile, emit);
      case const (UpdateProfile):
        return _updateProfile(event as UpdateProfile, emit);
      case const (GetProjects):
        return _getProjects(event as GetProjects, emit);
    }
  }

  @override
  ProjectState getErrorState() {
    return ProjectError();
  }
}
