class AuthError {
  String? statusMessage;
  int? statusCode;

  AuthError({
    this.statusMessage,
    this.statusCode,
  });

  AuthError.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    statusCode = json['status_code'];
  }
}
