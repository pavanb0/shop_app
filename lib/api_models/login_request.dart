class LoginRequest {
  final String emailId;
  final String password;

  LoginRequest({required this.emailId, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "EmailId": emailId,
      "Password": password,
    };
  }
}
