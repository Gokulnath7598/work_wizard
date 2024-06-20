import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../api_repository/api_repository.dart';
import '../../../api_repository/app_service.dart';
import '../../../api_repository/auth_service.dart';
import '../../../base_bloc/base_bloc.dart';
import '../../../models/app_user.dart';
import '../../../models/user_profiling_questions.dart';

part 'app_event.dart';

part 'app_state.dart';

enum OnBoardingStatusEnum { pending, skipped, done }

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  final AuthService authService = AuthService();

  FutureOr<void> _saveCurrentUser(
      SaveCurrentUser event, Emitter<AppState> emit) async {
    ApiRepository.preferencesClient.saveUser(appUser: event.user);
    emit(state.newState(user: event.user));
  }

  @override
  Future<void> eventHandlerMethod(
      AppEvent event, Emitter<AppState> emit) async {
    switch (event.runtimeType) {
      case const (SaveCurrentUser):
        return _saveCurrentUser(event as SaveCurrentUser, emit);
    }
  }

  @override
  AppState getErrorState() {
    return AppError();
  }
}
