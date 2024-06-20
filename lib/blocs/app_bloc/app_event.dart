part of 'app_bloc.dart';

@immutable
class AppEvent {}

class SaveAppUser extends AppEvent {
  SaveAppUser({
    this.user,
  });

  final AppUser? user;
}
