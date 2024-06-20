class Token {
  Token({
    this.accessToken,
    this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'].toString(),
      refreshToken: json['refresh_token'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  String? accessToken;
  String? refreshToken;
}
