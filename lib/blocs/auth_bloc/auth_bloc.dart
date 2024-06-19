import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_macos_app/api_service/user_management/user_management.dart';
import 'package:my_macos_app/core/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Future<void> eventHandlerMethod(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event is LoginUsingMicrosoft) {
      emit(LoginUsingMicrosoftLoading());
      final OAuthProvider provider = OAuthProvider('microsoft.com');
      provider.setCustomParameters(<String, String>{
        'tenant': 'cf77e474-cc9d-443d-9ae3-91c0c0121362',
      });
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithPopup(provider);

      final Map<String, dynamic>? response = await UserManagement.authenticate(
        token: Token(
          accessToken: credential.credential?.accessToken,
        ),
      );

      final AppUser? user = response?['user'];
      final Token? token = response?['token'];

      emit(
        LoginUsingMicrosoftSuccess(
          user: user,
          token: token,
        ),
      );
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}
