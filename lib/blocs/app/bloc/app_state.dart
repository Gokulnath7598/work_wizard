part of 'app_bloc.dart';

class AppState extends ErrorState {
  AppState({
    this.user,
  });

  factory AppState.fromState(AppState state) {
    return AppState(
      user: state.user,
    );
  }

  AppState newState({
    AppUser? user,
  }) {
    return AppState(
      user: user ?? this.user,
    );
  }

  final AppUser? user;
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppError extends AppState {}

class OnBoardingStatusLoading extends AppState {}

class OnBoardingStatusSuccess extends AppState {}
