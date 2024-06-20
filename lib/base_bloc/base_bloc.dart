import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rq_network_flutter/networking/api_endpoint.dart';
import 'package:rq_network_flutter/networking/custom_exception.dart';
import '../core/utils/utils.dart';

abstract class BaseBloc<E, S extends ErrorState> extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    on<E>(
      _eventHandler,
    );
  }

  FutureOr<void> _eventHandler(E event, Emitter<S> emit) async {
    try {
      await eventHandlerMethod(event, emit);
    } on CustomException catch (dioError) {
      debugPrint(
          '============ eventHandler CustomException: ${dioError.response?.data}');
      try {
        if (dioError.response?.statusCode == 400) {
          final Map<String, dynamic> err =
              dioError.response?.data as Map<String, dynamic>;
          emit(getErrorState()
            ..errorCode = dioError.response?.statusCode ?? 0
            ..errorMsg = (err['message'] as String?) != null
                ? err['message'].toString()
                : ''
            ..response = dioError.response
            ..status = err['status'] as bool?);
        } else if (dioError.response?.statusCode == 401) {
          if (dioError.response?.realUri.path
                  .contains(ApiEndpoint.refreshTokenUrl) ??
              false) {
            // ApiRepository.preferencesClient.saveUser();

            // ScaffoldMessenger.of(AppRouter
            //         .router.routerDelegate.navigatorKey.currentContext!)
            //     .showSnackBar(SnackBar(
            //   content: Text(dioError.message),
            // ));
            // AppRouter.router.go(InitPage.routePath);
          }
          emit(getErrorState()
            ..errorCode = dioError.statusCode ?? 0
            ..errorMsg = Utils.nullOrEmpty(dioError.message)
                ? 'Unauthorized'
                : dioError.message
            ..forceLogout = true);
        } else {
          emit(getErrorState()
            ..errorCode = dioError.response?.statusCode ?? 0
            ..errorMsg = dioError.message
            ..response = dioError.response);
        }
      } catch (err) {
        debugPrint('============ eventHandler catch block: $err');
        emit(getErrorState()
          ..errorCode = 0
          ..errorMsg = err.toString()
          ..response = dioError.response);
      }
    } catch (err) {
      debugPrint('============ eventHandler catch block: $err');
      emit(getErrorState()
        ..errorCode = 0
        ..errorMsg = err.toString());
    }
  }

  Future<void> eventHandlerMethod(E event, Emitter<S> emit);

  S getErrorState();
}

abstract class ErrorState {
  int errorCode = 0;
  String errorMsg = '';
  Response<dynamic>? response;
  bool? status;
  bool forceLogout = false;
}

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    debugPrint('CREATE: $bloc');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    debugPrint('CHANGE: $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    debugPrint('TRANSITION: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('TRANSITION: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    debugPrint('CLOSE: $bloc');
    super.onClose(bloc);
  }
}
