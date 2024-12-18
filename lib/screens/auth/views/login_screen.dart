import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/api/api_service.dart';
import 'package:shop/api_models/email_otp.dart';
import 'package:shop/api_models/login_request.dart';
import 'package:shop/api_models/login_response.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/route_constants.dart';

import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  //final loginResponse = LoginResponse();
  ApiService apiService = ApiService();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/maha_agro_banner.webp",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to mahaagro mart",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Log in with your data that you entered during your registration.",
                  ),
                  const SizedBox(height: defaultPadding),
                  // isloading
                  //     ? Text("hi")
                  //     :
                  LogInForm(
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  Align(
                    child: TextButton(
                      child: const Text("Forgot password"),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, passwordRecoveryScreenRoute);
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        size.height > 700 ? size.height * 0.1 : defaultPadding,
                  ),
                  isloading
                      ? const Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: Color(0XFF28b414),
                              ),
                            )
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context,
                              //     entryPointScreenRoute,
                              //     ModalRoute.withName(logInScreenRoute));
                              setState(() {
                                isloading = true;
                              });
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();
                              LoginRequest loginRequest = LoginRequest(
                                  emailId: email, password: password);

                              LoginResponse? loginResponse;

                              try {
                                loginResponse =
                                    await apiService.loginUser(loginRequest);
                                if (loginResponse.Code == 200) {
                                  final _storage = const FlutterSecureStorage();
                                  await _storage.write(
                                      key: "JwtToken",
                                      value: loginResponse.token);
                                  Fluttertoast.showToast(
                                      msg: "Login Succesful",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: const Color(0XFF28b414),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {
                                    isloading = false;
                                  });
                                } else if (loginResponse.Code == 401) {
                                  Fluttertoast.showToast(
                                      msg: "User Not Verified",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: const Color(0XFF28b414),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  EmailOtpRequest emailOtpRequest =
                                      EmailOtpRequest(Email: email);

                                  EmailOtpResponse emailOtpResponse =
                                      await apiService
                                          .loginotp(emailOtpRequest);

                                  if (emailOtpResponse.Code == 200) {
                                    setState(() {
                                      isloading = false;
                                      Navigator.pushNamed(
                                          context, emailOtpVerification,
                                          arguments: email);
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: loginResponse.message,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: const Color(0XFF28b414),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              } catch (e) {
                                setState(() {
                                  isloading = false;
                                  Fluttertoast.showToast(
                                      msg: "Network Issue",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: const Color(0XFF28b414),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                });
                                return;
                              } finally {
                                setState(() {
                                  isloading = false;
                                });
                              }
                            }
                          },
                          child: const Text("Log in"),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, signUpScreenRoute);
                        },
                        child: const Text("Sign up"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
