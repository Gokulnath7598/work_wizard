import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_macos_app/base_bloc/base_bloc.dart';
import 'package:my_macos_app/models/models.dart';
import 'package:my_macos_app/preferences_client/preferences_client.dart';

import '../../api_service/user_management/user_management.dart';

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
      final Map<String, dynamic>? response = await UserManagement.authenticate(
        token: Token(
          accessToken:
              '''eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcmstd2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4NzY5MTQsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI6MTcxODg3NjkxNCwiZXhwIjoxNzE4ODgwNTE0LCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJjNTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.BhpSVms_pShgRHeG8YKp5cOVvy3BfKp0vyj6ohjZuVJMVngGf8QEyZgN9K1yvo2HeqseYj7yMTxQ1V4B-KqDmvr6P9U-2SxVvPJw3P_sUYE1_otVHQ-5rcKQ5_b1ojbcDHhI7xxbaf9Sit5wvZa6zqlN6lbyFsF2AXcj6VBIs-T3z5RgH_RO10d9Egx_L0C8m1Pd7iv4P4_u9SYOIAqxS9nRP2weem8430bw9TqElsklrgViAjKYhhMP6qJhJ50SGPZQ-5n6Ai0r1hJmNt98xRYDmpMvurcbqCzP-f2I3kl7DEkllnV19xe8u1zuYD3nxO3kcBbs5crh-bbSxJaKpA''',
        ),
      );

      final AppUser? user = response?['user'];
      final Token? token = response?['token'];

      await PreferencesClient.saveToken(
        token: token,
      );

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
