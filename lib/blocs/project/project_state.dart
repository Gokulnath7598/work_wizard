part of 'project_bloc.dart';

abstract class ProjectState extends ErrorState {}

class ProjectAppState extends ProjectState {
  ProjectAppState({this.user, this.projects});
  User? user;
  Projects? projects;
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectError extends ProjectState {}
class UpdateProfileSuccess extends ProjectState {}
