class LoginResponse {
  final int? Code;
  final String emailId;
  final String? token;
  final String message;
  final String? msg;
  final String? Retval;

  LoginResponse(
      {required this.emailId,
      this.Code,
      this.token,
      required this.message,
      this.msg,
      this.Retval});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      Code: json['Code'] ?? 00,
      message: json['msg'] ?? '',
      Retval: json.containsKey('Retval') ? json['Retval'] as String : "",
      emailId: json.containsKey('EmailId') ? json['EmailId'] as String : "",
      token: json['Token'],
      msg: json.containsKey('msg') ? json['msg'] as String : "",
    );
  }
}
