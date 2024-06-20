import 'dart:async';
import 'package:rq_network_flutter/networking/response_model.dart';
import '../models/app_user.dart';
import '../models/token.dart';
import 'api_repository.dart';

class AuthService extends ApiRepository {
  //************************************ generate-sign-up-otp *********************************//
  static Future<Map<String, dynamic>?> generateSignUpOtp(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user/signup/generate-otp',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return <String, dynamic>{
            'status': response.body?['status'] as bool?,
            'message': response.body?['message'] as String?,
          };
        });
    return res;
  }

  //************************************ verify-otp *********************************//
  static Future<Map<String, dynamic>?> verifyOtp(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user/signup/verify-otp',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return <String, dynamic>{
            'status': response.body?['status'] as bool?,
            'message': response.body?['message'] as String?,
            'token':
                Token.fromJson(response.body?['token'] as Map<String, dynamic>)
          };
        });
    return res;
  }

  //************************************ MPin-setup *********************************//
  static Future<Map<String, dynamic>?> mPinSetup(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user/signup/mpin-setup',
        requiresAuthToken: true,
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return <String, dynamic>{
            'status': response.body?['status'] as bool?,
            'message': response.body?['message'] as String?,
          };
        });
    return res;
  }

//************************************ log-in *********************************//
  Future<Map<String, dynamic>?> loginWithPassword(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user_management/customer/auth/login',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return response.body;
        });
    return <String, dynamic>{
      'customer': AppUser.fromJson(res?['contact'] as Map<String, dynamic>),
      'token': Token.fromJson(res?['token'] as Map<String, dynamic>)
    };
  }

  //************************************ get-user-details *********************************//
  static Future<AppUser?> getUserDetails() async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.get(
        endpoint: '/user',
        converter: (Map<String, dynamic>? response) {
          return <String, dynamic>{
            'app_user':
                AppUser.fromJson(response?['data'] as Map<String, dynamic>)
          };
        });
    return res?['app_user'] as AppUser;
  }

//************************************ log-out *********************************//
  static Future<Map<String, dynamic>?> logOut() async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.delete(
        requiresAuthToken: true,
        endpoint: '/auth/logout',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return response.body;
        });
    return res;
  }

  //************************************ generate-pin-reset-otp *********************************//
  static Future<Map<String, dynamic>?> generatePinResetOtp(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user/reset/mpin/generate-otp',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return <String, dynamic>{
            'status': response.body?['status'] as bool?,
            'message': response.body?['message'] as String?,
          };
        });
    return res;
  }

  //************************************ verify-pin-reset-otp *********************************//
  static Future<Token?> verifyPinResetOtp(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user/reset/mpin/verify-otp',
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return <String, dynamic>{
            'status': response.body?['status'] as bool?,
            'message': response.body?['message'] as String?,
            'token':
                Token.fromJson(response.body?['token'] as Map<String, dynamic>)
          };
        });
    return res?['token'] as Token?;
  }

  static Future<Map<String, dynamic>?> resetPinSetup(
      {Map<String, dynamic>? objToApi}) async {
    final Map<String, dynamic>? res = await ApiRepository.apiService.post(
        data: objToApi,
        endpoint: '/user/reset/mpin',
        requiresAuthToken: true,
        converter: (ResponseModel<Map<String, dynamic>?> response) {
          return <String, dynamic>{
            'status': response.body?['status'] as bool?,
            'message': response.body?['message'] as String?,
          };
        });
    return res;
  }
}
