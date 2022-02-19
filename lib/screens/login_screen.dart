// ignore_for_file: use_key_in_widget_constructors, avoid_print
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/login_cubit/login_cubit.dart';
import 'package:talabatcom_driver/cubit/login_cubit/login_state.dart';
import 'package:talabatcom_driver/helpers/lang/language_constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/screens/create_otp_regist_screen.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';
import 'package:talabatcom_driver/widgets/txtfield_widget.dart';
import 'forget_pass_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  var check = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cCode = '+966';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          backgroundColor: Constants.whiteAppColor,
          resizeToAvoidBottomInset: false,
          appBar: GlobalAppBar(
              enableBackButton: false,
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 30.0, color: Constants.whiteAppColor),
                      ),
                      const SizedBox(height: 20),
                      SvgPicture.asset(
                        "assets/images/waving-hand.svg",
                        color: Constants.whiteAppColor,
                        height: size.height * 0.08,
                      )
                    ],
                  ),
                ],
              ),
              height: size.height * 0.25),
          body: Padding(
            padding: EdgeInsetsDirectional.only(
                start: 30.0, end: 30.0, bottom: bottom),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: size.height * .05, bottom: 10),
                        child: const Text("Please Sign In",
                            style:
                                TextStyle(color: Constants.HINT, fontSize: 20)),
                      ),
                    ),
                    TxtFieldWidget(
                      labelTxt: "",
                      textEditingController: phoneTextEditingController,
                      isHasNextFocus: true,
                      textInputType: TextInputType.phone,
                      prefixIcon: SizedBox(
                        width: size.width / 3.6,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CountryCodePicker(
                              onChanged: (code) {
                                print(code.dialCode);
                                setState(() {
                                  cCode = code.dialCode!;
                                });
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'SA',
                              padding: const EdgeInsets.all(0.0),
                              textStyle: const TextStyle(color: Colors.grey),
                              //favorite: ['+39', 'FR'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(
                            //           bottom: 8, right: 8, left: 8),
                            //       child: Text(
                            //         "+966",
                            //         style: TextStyle(
                            //             fontSize: 15,
                            //             color: Constants.HINT
                            //                 .withOpacity(0.9)),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    TxtFieldWidget(
                        isHasNextFocus: false,
                        textInputType: TextInputType.visiblePassword,
                        labelTxt: "Password",
                        textEditingController: passwordTextEditingController,
                        suffixIcon: SvgPicture.asset(
                            'assets/images/eye_close.svg',
                            height: 15.0,
                            width: 15.0,
                            fit: BoxFit.fill)),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgetPassScreen();
                          }));
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(
                                color:
                                    Constants.primaryAppColor.withOpacity(0.5),
                                fontSize: 12)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: Checkbox(
                              activeColor: const Color(0xFF43494B),
                              value: check,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (val) {
                                setState(() {
                                  check = val!;
                                });
                              }),
                        ),
                        const SizedBox(width: 10),
                        const Text("Remember me",
                            style:
                                TextStyle(color: Constants.HINT, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: size.height * 0.04),
                    Center(
                      child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                        if (state is Loginloading) {
                          return SpinKitThreeBounce(
                            color: Constants.primaryAppColor,
                            size: size.width * .08,
                          );
                        } else {
                          return BtnWidget(
                            txt: "Login",
                            color: Constants.primaryAppColor,
                            onClicked: () async {
                              MyApplication.checkConnection().then((value) {
                                if (_formKey.currentState!.validate()) {
                                  if (value == true) {
                                    BlocProvider.of<LoginCubit>(context).login(
                                        pass:
                                            passwordTextEditingController.text,
                                        phone: cCode +
                                            phoneTextEditingController.text,
                                        remember: check,
                                        context: context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: getTranslated(
                                            context, 'noInternet')!,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.SNACKBAR,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor:
                                            Constants.primaryAppColor,
                                        textColor: Constants.whiteAppColor,
                                        fontSize: 16.0);
                                  }
                                }
                              });
                            },
                          );
                        }
                      }),
                    ),
                    const SizedBox(height: 25),
                    Text.rich(
                      TextSpan(
                          text: "Don't have an account ? ",
                          style: TextStyle(
                              color: Constants.HINT.withOpacity(0.5),
                              fontSize: 12),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const CreateOTPRegistScreen();
                                    })),
                              style: const TextStyle(
                                  color: Constants.primaryAppColor,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
