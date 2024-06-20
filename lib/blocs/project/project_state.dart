part of 'project_bloc.dart';

abstract class ProjectState extends ErrorState {}

class ProjectAppState extends ProjectState {
  ProjectAppState({this.user});
  User? user;
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectError extends ProjectState {}
