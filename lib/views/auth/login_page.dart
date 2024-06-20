import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:my_macos_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:my_macos_app/core/app_router/app_router.dart';
import 'package:my_macos_app/core/constants/app_assets.dart';
import 'package:my_macos_app/views/home/home_page.dart';

import '../../blocs/app_bloc/app_bloc.dart';

class LoginPage extends StatefulWidget {
  static const routePath = '/auth/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }

  void Function(BuildContext, AuthState) loginUsingMicrosoftListener = (
    BuildContext context,
    AuthState state,
  ) {
    if (state is LoginUsingMicrosoftSuccess) {
      print(state.user?.name);
      print(state.token?.accessToken);
      context.read<AppBloc>().add(
            SaveAppUser(
              user: state.user,
            ),
          );
      AppRouter.navigatorKey.currentContext?.go(
        HomePage.routePath,
      );
    }
  };

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MacosWindow(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Work Wizard',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 25,
                  color: Colors.black),
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 0.03 * size.width,
                    right: 0.02 * size.width,
                  ),
                  child: Image.asset(
                    AppAssets.arrowLeft,
                    width: size.width * 0.11,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'user friendly ET Sheet reminder and tracker',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeig,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 0.03 * size.width,
                    left: 0.02 * size.width,
                  ),
                  child: Image.asset(
                    AppAssets.arrowRight,
                    width: size.width * 0.11,
                  ),
                ),
              ],
            ),
            const Spacer(),
            BlocConsumer<AuthBloc, AuthState>(
              bloc: _authBloc,
              listener: loginUsingMicrosoftListener,
              builder: (context, authState) {
                return Container(
                  width: 280,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: authState is LoginUsingMicrosoftLoading
                      ? const CupertinoActivityIndicator(
                          color: Color(0xFF505050),
                        )
                      : TextButton(
                          onPressed: () {
                            _authBloc.add(LoginUsingMicrosoft());
                          },
                          child: const Text(
                            'Sign in with Microsoft',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
