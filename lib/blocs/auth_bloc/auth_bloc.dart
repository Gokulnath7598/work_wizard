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
              '''eyJhbGciOiJSUzI1NiIsImtpZCI6ImRmOGIxNTFiY2Q5MGQ1YjMwMjBlNTNhMzYyZTRiMzA3NTYzMzdhNjEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiWWF6aGluaSBNYWxhciBQYXJpIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3dvcm
std2l6YXJkLWJmOTc5IiwiYXVkIjoid29yay13aXphcmQtYmY5NzkiLCJhdXRoX3RpbWUiOjE3MTg4NjcwNjQsInVzZXJfaWQiOiJvRnR2RjZlcUtsWkZwak1UTkd3N0JsTEI2TDgyIiwic3ViIjoib0Z0dkY2ZXFLbFpGcGpNVE5HdzdCbExCNkw4MiIsImlhdCI
6MTcxODg2NzA2NCwiZXhwIjoxNzE4ODcwNjY0LCJlbWFpbCI6InlhemhpbmkubWFsYXJAcm9vdHF1b3RpZW50LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJtaWNyb3NvZnQuY29tIjpbImE1ZDIxMWQ2LWJj
NTgtNDcwOS1iZmIzLTI4MWMwZWU4NzFkMCJdLCJlbWFpbCI6WyJ5YXpoaW5pLm1hbGFyQHJvb3RxdW90aWVudC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJtaWNyb3NvZnQuY29tIn19.aY6WNxH3TzTqW7fhKKB05eq6hAKD3Ig7abRtdIBSbh_QvCt1tog1
nroA-vfQDjM0MAifP8XG64fNtKfYCYuV34eaxW0qcRfrqsVcUY95DQt_U9FqSfbOen5yW3s6RKYZxVbW1EChswJV5BHU8wqzfS8dLyFFGS_4tzHajbMlkMC-KZ0XuJdWU1wcWpwerCyIW01nprjnpamHBPHP-UdBemPBYteG-n0Odw4Jd0tBrdtcSQxKT_4U8gm-W
lqtJ0xuRTZu3HSS5Ksi8Uc7YKlsxzWxKHd1zRpqtoUjUyj6x8bebMZAlS7z5mVPIdAGfu8Tjdu3uofilukcMNIoqFe9Rw''',
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
