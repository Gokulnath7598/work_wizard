class Token {
  Token({
    this.accessToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
    };
  }

  final String? accessToken;
}
