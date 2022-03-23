class AuthModel {
  String? expiresAt;
  String? requestToken;

  AuthModel(this.expiresAt, this.requestToken);

  AuthModel.fromJson(Map<String, dynamic> json) {
    expiresAt = json['expires_at'];
    requestToken = json['request_token'];
  }
}
