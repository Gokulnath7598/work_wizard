import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_macos_app/core/base_bloc/base_bloc.dart';
import 'package:my_macos_app/core/oauth2_client/oauth2_client.dart';
import 'package:my_macos_app/models/models.dart';
import 'package:oauth2/oauth2.dart';

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
      // // final OAuthProvider provider = OAuthProvider('microsoft.com');
      // // provider.setCustomParameters(<String, String>{
      // //   'tenant': 'cf77e474-cc9d-443d-9ae3-91c0c0121362',
      // // });

      // // final UserCredential credential =
      // //     await FirebaseAuth.instance.signInWithProvider(provider);
      // // await FirebaseAuth.instance.signInWithProvider(provider);
      // // const MethodChannel channel = MethodChannel('com.employee.work_wizard');

      // // final Map<String, dynamic>? response = await UserManagement.authenticate(
      // //   token: Token(
      // //     accessToken: credential.credential?.accessToken,
      // //   ),
      // // );

      // // final AppUser? user = response?['user'];
      // // final Token? token = response?['token'];

      // const String secretVal = 'jnw8Q~b_PAkmqlyfkfoPvEMR~Y1RU7aN4CpcraIa';
      // // const String secretId = '1a0f816a-ae0f-4343-8d04-b82f287c82a9';
      // final OAuth2Client oAuth2Client = OAuth2Client(
      //   clientId: 'a3340139-0bc6-44f8-96e6-03985e3761aa',
      //   clientSecret: secretVal,
      //   authorizationEndpoint: Uri.parse(
      //     'https://login.microsoftonline.com/cf77e474-cc9d-443d-9ae3-91c0c0121362/oauth2/v2.0/authorize',
      //   ),
      //   tokenEndpoint: Uri.parse(
      //     'https://login.microsoftonline.com/cf77e474-cc9d-443d-9ae3-91c0c0121362/oauth2/v2.0/token',
      //   ),
      //   redirectUri: Uri.parse(
      //     'https://work-wizard-bf979.firebaseapp.com/__/auth/handler',
      //   ),
      // );

      // print('Oauth start');
      // final Client? client = await oAuth2Client.getOAuth2Client();
      // print('Oauth end');
      // print(client?.credentials.accessToken);

      emit(
        LoginUsingMicrosoftSuccess(
            // user: user,
            // token: token,
            ),
      );
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}
