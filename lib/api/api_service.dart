import 'package:dio/dio.dart';
import 'package:shop/api_models/email_otp.dart';
import 'package:shop/api_models/login_response.dart';
import 'package:shop/api_models/login_request.dart';
import 'api_client.dart';

class ApiService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponse> loginUser(LoginRequest loginRequest) async {
    try {
      final response = await _apiClient.post("/Authentication/Login",
          data: loginRequest.toJson());
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<EmailOtpResponse> loginotp(EmailOtpRequest req) async {
    try {
      final response = await _apiClient.post("/Authentication/SendOtpEmail",
          data: req.toJson());
      return EmailOtpResponse.fromJson(response.data);
    } catch (c) {
      rethrow;
    }
  }

  Future<EmailOtpResponse> sendotp(EmailVerificationRequest req) async {
    try {
      final response = await _apiClient.post("/Authentication/VerifyEmail",
          data: req.toJson());
      return EmailOtpResponse.fromJson(response.data);
    } catch (c) {
      rethrow;
    }
  }
}
