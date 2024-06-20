import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_repository/api_repository.dart';
import '../../../api_repository/auth_service.dart';
import '../../../base_bloc/base_bloc.dart';
import '../../../models/app_user.dart';
import '../../../models/token.dart';
import '../../../preference_client/preference_client.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final AuthService authService = AuthService();

  LoginWithPasswordSuccess loginWithPasswordSuccess =
      LoginWithPasswordSuccess();
  CheckForPreferenceSuccess checkForPreferenceSuccess =
      CheckForPreferenceSuccess();

  FutureOr<void> _checkForPreference(
      CheckForPreference event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // final AppUser? user = await AuthService.getUserDetails();
    final AppUser? user = await ApiRepository.preferencesClient.getUser();
    emit(checkForPreferenceSuccess..user = user);
  }

  FutureOr<void> _loginWithPassword(
      LoginWithPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Map<String, dynamic> objToApi = <String, dynamic>{
      'employee': <String, Object>{
        'email': event.mobile ?? '',
        'password': event.password ?? '',
        'build_number': 100,
        'is_mobile': true,
        'grant_type': 'password'
      }
    };
    final Map<String, dynamic>? response =
        await authService.loginWithPassword(objToApi: objToApi);
    final AppUser? user = response?['customer'] as AppUser?;
    final Token? token = response?['token'] as Token?;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    PreferencesClient(prefs: prefs).saveUser(appUser: user);
    PreferencesClient(prefs: prefs).setUserAccessToken(token: token);
    emit(loginWithPasswordSuccess..user = user);
  }

  @override
  Future<void> eventHandlerMethod(
      AuthEvent event, Emitter<AuthState> emit) async {
    switch (event.runtimeType) {
      case const (CheckForPreference):
        return _checkForPreference(event as CheckForPreference, emit);
      case const (LoginWithPassword):
        return _loginWithPassword(event as LoginWithPassword, emit);
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}
