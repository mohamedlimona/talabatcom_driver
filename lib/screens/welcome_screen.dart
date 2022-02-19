// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/screens/create_otp_regist_screen.dart';
import 'package:talabatcom_driver/screens/login_screen.dart';
import 'package:talabatcom_driver/screens/sign_up_data_screen.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: size.height * 0.1),
        color: Constants.whiteAppColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Lottie.asset(
                  'assets/images/delivery.json',
                  width: double.infinity,
                  height: size.height * 0.6,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              BtnWidget(
                txt: "Login",
                onClicked: () {
                  MyApplication.navigateToReplace(context, LoginScreen());
                },
                color: Constants.primaryAppColor,
              ),
              SizedBox(height: size.height * 0.03),
              BtnWidget(
                txt: "Sign Up",
                onClicked: () => MyApplication.navigateToReplace(
                    context, const CreateOTPRegistScreen()),
                color: Constants.primaryAppColor.withOpacity(0.25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
