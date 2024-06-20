import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_macos_app/core/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/app_user/app_user.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());
  AppBlocState blocState = AppBlocState();

  FutureOr<void> _saveAppUser(
    SaveAppUser event,
    Emitter<AppState> emit,
  ) async {
    PreferencesClient.saveUser(event.user);
    blocState.user = event.user;
    emit(
      blocState.copyWith(
        user: event.user,
      ),
    );
  }

  @override
  Future<void> eventHandlerMethod(
    AppEvent event,
    Emitter<AppState> emit,
  ) async {
    if (event is SaveAppUser) {
      return _saveAppUser(event, emit);
    }
  }

  @override
  AppState getErrorState() {
    return AppError();
  }
}
