class EmailOtpRequest {
  final String Email;

  EmailOtpRequest({required this.Email});

  Map<String, dynamic> toJson() {
    return {
      "Email": Email,
    };
  }
}

class EmailVerificationRequest {
  final String? Email;
  final String? Otp;

  EmailVerificationRequest({this.Email, this.Otp});
  Map<String, dynamic> toJson() {
    return {"Email": Email, "Otp": Otp};
  }
}

class EmailOtpResponse {
  final int? Code;
  final String emailId;
  final String? token;
  final String message;
  final String? msg;
  final String? Retval;

  EmailOtpResponse(
      {required this.emailId,
      this.Code,
      this.token,
      required this.message,
      this.msg,
      this.Retval});

  factory EmailOtpResponse.fromJson(Map<String, dynamic> json) {
    return EmailOtpResponse(
      Code: json['Code'] ?? 00,
      message: json['msg'] ?? '',
      Retval: json.containsKey('Retval') ? json['Retval'] as String : "",
      emailId: json.containsKey('EmailId') ? json['EmailId'] as String : "",
      token: json['Token'],
      msg: json.containsKey('msg') ? json['msg'] as String : "",
    );
  }
}
