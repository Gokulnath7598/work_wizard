import 'dart:async';
import 'dart:convert';

import 'package:my_macos_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesClient {
  static late SharedPreferences _prefsClient;
  static const _tokenKeyString = 'com.work_wizard.my_macos_app/token';
  static FutureOr<void> initialize() async {
    _prefsClient = await SharedPreferences.getInstance();
  }

  static Token? getToken() {
    final String? encodedToken = _prefsClient.get(_tokenKeyString) as String?;
    if (encodedToken != null) {
      return Token.fromJson(
        jsonDecode(encodedToken) as Map<String, dynamic>,
      );
    }
    return null;
  }

  static FutureOr<void> saveToken({
    required Token token,
  }) async {
    await _prefsClient.setString(
      _tokenKeyString,
      jsonEncode(
        token.toJson(),
      ),
    );
  }
}
