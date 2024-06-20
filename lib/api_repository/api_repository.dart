import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:rq_network_flutter/api_manager.dart';
import 'package:rq_network_flutter/helpers/preferences.dart';
import 'package:rq_network_flutter/local/path_provider_service.dart';
import 'package:rq_network_flutter/networking/api_endpoint.dart';
import 'package:rq_network_flutter/networking/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_config.dart';
import '../preference_client/preference_client.dart';

class ApiRepository {
  static String baseUrlConfig = AppConfig.shared.baseUrl;

  static late ApiManager apiManager;
  static late ApiService apiService;
  static late SharedPreferences _prefs;
  static late PreferencesClient preferencesClient;

  static Future<void> init({
    Dio? dioArg,
    String? baseUrl,
    PathProviderService? pathProviderServiceArg,
    HiveCacheStore? hiveCacheStore,
  }) async {
    _prefs = await SharedPreferences.getInstance();
    preferencesClient = PreferencesClient(prefs: ApiRepository._prefs);

    ApiEndpoint.baseUrl = baseUrl ?? baseUrlConfig;
    ApiEndpoint.refreshTokenUrl = '/auth/refresh-access-token';
    ApiEndpoint.refreshTokenReqBody = () async {
      final Map<String, dynamic>? token = await Preference.getUserAccessToken();

      return <String, dynamic>{
        'refresh_token': token?[ApiEndpoint.refreshTokenKey],
        'grant_type': 'refresh_token'
      };
    };
    ApiEndpoint.enableRefreshToken = true;
    if (pathProviderServiceArg == null) {
      pathProviderServiceArg = PathProviderService();
      await pathProviderServiceArg.init();
    }
    apiManager = ApiManager(
        dioArg: dioArg ??
            Dio(BaseOptions(
                baseUrl: ApiEndpoint.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10))),
        diowithoutBaseUrl: Dio(BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10))),
        pathProviderServiceArg: pathProviderServiceArg,
        hiveCacheStore:
            hiveCacheStore ?? HiveCacheStore(pathProviderServiceArg.path));
    apiService = apiManager.apiService;
  }
}
