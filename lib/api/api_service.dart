import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shop/api_models/login_response.dart';
import 'package:shop/api_models/login_request.dart';
import 'api_client.dart';

class ApiService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponse> loginUser(LoginRequest loginRequest) async {
    try {
      final response = await _apiClient.post("/Authentication/Login",
          data: loginRequest.toJson());

      //print(response);
      // LoginResponse loginResponse =
      //     LoginResponse(emailId: "", token: "token", message: "message");

      // return LoginResponse(
      //     emailId: "emailId", token: "token", message: "message");
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
