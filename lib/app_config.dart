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
        'http://ec2-3-7-3-118.ap-south-1.compute.amazonaws.com:3000/api/v1');

AppConfig stubConfig = AppConfig(
    flavor: Flavor.staging,
    appLabel: 'Fintuit [STG]',
    baseUrl:
        'https://a8683f30-d380-4f57-bc8b-6d890babb8ae.mock.pstmn.io/api/v1');
