class Token {
  static String token;

  Token();

  factory Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    return Token();
  }
}
