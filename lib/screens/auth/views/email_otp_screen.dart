import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/api/api_client.dart';
import 'package:shop/api/api_service.dart';
import 'package:shop/api_models/email_otp.dart';
import 'package:shop/constants.dart';

class EmailOtpScreen extends StatefulWidget {
  final dynamic emailId;

  const EmailOtpScreen({super.key, this.emailId});

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    email = widget.emailId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    final formkey = GlobalKey<FormState>();
    final _apiRequest = ApiService();

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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Please Enter The Otp ",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    "Otp Sent on ${widget.emailId}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: defaultPadding * 10),
                  Form(
                    child: Column(
                      children: [
                        OtpTextField(
                          alignment: Alignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          enabledBorderColor: Color(0XFFFF16ae00),
                          borderColor: Colors.black,
                          onSubmit: (value) async {
                            EmailVerificationRequest otpRequest =
                                EmailVerificationRequest(
                                    Email: widget.emailId, Otp: value);
                            EmailOtpResponse emailOtpResponse =
                                await _apiRequest.sendotp(otpRequest);
                            if (emailOtpResponse.Code == 200) {
                              Fluttertoast.showToast(
                                  msg: "Email Verified",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color(0XFF28b414),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (emailOtpResponse.Code == 401) {
                              Fluttertoast.showToast(
                                  msg: "Failed to verify otp",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: const Color(0XFF28b414),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
