part of 'app_bloc.dart';

abstract class AppState extends ErrorState {}

class AppInitial extends AppState {}

class AppError extends AppState {}

class AppBlocState extends AppState {
  AppBlocState({
    this.user,
  });
  
  AppBlocState copyWith({
    AppUser? user,
  }) {
    return AppBlocState(
      user: user ?? this.user,
    );
  }

  AppUser? user;
}
