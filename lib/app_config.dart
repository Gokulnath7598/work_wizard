enum Flavor { production, staging }

class AppConfig {
  AppConfig(
      {required this.flavor, required this.appLabel, required this.baseUrl});

  factory AppConfig.initiate() {
    return shared = stubConfig;
  }

  Flavor flavor;
  String appLabel;
  String baseUrl;

  static AppConfig shared = AppConfig.initiate();
}

AppConfig stagingConfig = AppConfig(
    flavor: Flavor.staging,
    appLabel: 'Fintuit [STG]',
    baseUrl:
        'https://rnmcp-202-129-198-175.a.free.pinggy.link/api/v1');

AppConfig stubConfig = AppConfig(
    flavor: Flavor.staging,
    appLabel: 'Fintuit [STG]',
    baseUrl:
        'https://rnmcp-202-129-198-175.a.free.pinggy.link/api/v1');
