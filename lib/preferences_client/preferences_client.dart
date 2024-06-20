import 'dart:async';
import 'dart:convert';

import 'package:my_macos_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesClient {
  static late SharedPreferences _prefsClient;
  static const _tokenKeyString = 'com.employee.work_wizard/token';
  static const _userKeyString = 'com.employee.work_wizard/user';

  static FutureOr<void> initialize() async {
    _prefsClient = await SharedPreferences.getInstance();
  }

  static Token? getToken() {
    final String? encodedToken = _prefsClient.get(_tokenKeyString) as String?;
    if (encodedToken != null && encodedToken.isNotEmpty) {
      return Token.fromJson(
        jsonDecode(encodedToken) as Map<String, dynamic>,
      );
    }
    return null;
  }

  static Future<void> saveToken({
    Token? token,
  }) async {
    await _prefsClient.setString(
      _tokenKeyString,
      token != null
          ? jsonEncode(
              token.toJson(),
            )
          : '',
    );
  }

  static AppUser? getUser() {
    final String? encodedUser = _prefsClient.getString(_userKeyString);
    if (encodedUser != null && encodedUser.isNotEmpty) {
      return AppUser.fromJson(
        jsonDecode(encodedUser) as Map<String, dynamic>,
      );
    }
    return null;
  }

  static Future<void> saveUser(AppUser? user) async {
    await _prefsClient.setString(
      _userKeyString,
      user != null
          ? jsonEncode(
              user.toJson(),
            )
          : '',
    );
  }
}
