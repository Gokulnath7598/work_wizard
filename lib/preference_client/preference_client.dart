import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';
import '../models/token.dart';

class PreferencesClient {
  PreferencesClient({required this.prefs});

  final SharedPreferences prefs;

  Future<AppUser?> getUser() async {
    final String? userString = prefs.getString('appUser');
    if (userString == null || userString == '') {
      return null;
    }
    final Map<String, dynamic> user =
        json.decode(userString) as Map<String, dynamic>;
    final AppUser appUser = AppUser.fromJson(user);
    return (appUser.mobileNumber == null ||
            appUser.id == null ||
            appUser.biometric == null)
        ? null
        : appUser;
  }

  Future<void> saveUser({AppUser? appUser}) async {
    if (appUser == null) {
      prefs.setString('appUser', '');
      return;
    }
    final String userString = json.encode(appUser);
    await prefs.setString('appUser', userString);
  }

  //****************************** user-access-token **************************//
  Future<Token?> getUserAccessToken() async {
    final String? tokenString = prefs.getString('token');
    if (tokenString == null || tokenString == '') {
      return null;
    }
    final Map<String, dynamic> accessToken =
        json.decode(tokenString) as Map<String, dynamic>;
    return Token.fromJson(accessToken);
  }

  Future<void> setUserAccessToken({Token? token}) async {
    if (token == null) {
      prefs.setString('token', '');
      return;
    }
    final String tokenString = json.encode(token);
    await prefs.setString('token', tokenString);
  }
}
