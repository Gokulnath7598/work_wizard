part of 'auth_bloc.dart';

abstract class AuthState extends ErrorState {}

class AuthInitial extends AuthState {}

class AuthBlocState extends AuthState {}

class AuthError extends AuthState {}

class LoginUsingMicrosoftLoading extends AuthState {}

class LoginUsingMicrosoftSuccess extends AuthState {
  LoginUsingMicrosoftSuccess({
    this.token,
    this.user,
  });
  
  final AppUser? user;
  final Token? token;
}
