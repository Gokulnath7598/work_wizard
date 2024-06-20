import 'package:app_links/app_links.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

class OAuth2Client {
  final String clientId;
  final String? clientSecret;
  final Uri authorizationEndpoint;
  final Uri tokenEndpoint;
  final Uri redirectUri;

  static final AppLinks _appLinks = AppLinks();

  OAuth2Client({
    required this.clientId,
    this.clientSecret,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.redirectUri,
  });

  Future<oauth2.Client?> getOAuth2Client() async {
    var grant = oauth2.AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecret,
    );

    var authorizationUrl = grant.getAuthorizationUrl(
      redirectUri,
      scopes: ['openid', 'email'],
    );

    // return await oauth2.clientCredentialsGrant(
    //   authorizationEndpoint,
    //   clientId,
    //   clientSecret,
    //   scopes: [
    //     'openid',
    //     'email',
    //   ],
    //   getParameters: (contentType, body) {
    //     return {
    //       // 'Content-Type': 'application/json',
    //     };
    //   },
    // );
    // print(authorizationUrl);

    await _redirect(authorizationUrl);

    Uri? responseUri = await _listen();
    if (responseUri != null) {
      print(authorizationUrl.queryParameters);
      var client =
          await grant.handleAuthorizationResponse(responseUri.queryParameters);
      return client;
    }
    return null;
  }

  Future<void> _redirect(Uri authorizationUrl) async {
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    } else {
      throw Exception('Could not launch $authorizationUrl');
    }
  }

  Future<Uri?> _listen() async {
    Uri? responseUri;
    // print(redirectUri.toString());
    // print(redirectUri.port);

    // var server =
    //     await HttpServer.bind(authorizationEndpoint, authorizationEndpoint.port);
    // server.listen((request) async {
    //   print(request);
    //   print(request.uri);
    //   await request.response.close();
    //   await server.close();
    // });
    _appLinks.uriLinkStream.listen((Uri uri) async {
      print(uri);
      if (uri.toString().startsWith(redirectUri.toString())) {
        responseUri = uri;
      }
    });

    return responseUri ?? redirectUri;
  }
}
