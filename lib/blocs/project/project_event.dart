part of 'project_bloc.dart';

abstract class ProjectEvent {}

class GetProfile extends ProjectEvent {}

class UpdateProfile extends ProjectEvent {
  UpdateProfile({this.objToApi});
  Map<String, dynamic>? objToApi;
}
