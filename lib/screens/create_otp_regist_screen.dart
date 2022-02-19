import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/check_phone_cubit/check_phone_cubit.dart';
import 'package:talabatcom_driver/cubit/check_phone_cubit/check_phone_state.dart';
import 'package:talabatcom_driver/helpers/lang/language_constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/sign_up_data_model.dart';
import 'package:talabatcom_driver/screens/sign_up_files_upload_screen.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';
import 'package:talabatcom_driver/widgets/txtfield_widget.dart';
import 'login_screen.dart';

class CreateOTPRegistScreen extends StatefulWidget {
  const CreateOTPRegistScreen({Key? key}) : super(key: key);

  @override
  _CreateOTPRegistScreenState createState() => _CreateOTPRegistScreenState();
}

class _CreateOTPRegistScreenState extends State<CreateOTPRegistScreen> {
  int activeStep = 0;
  var check = true;
  String cCode = '+966';
  final TextStyle _textStyle = const TextStyle(
    fontSize: 14.0,
    color: Constants.bord,
  );
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.whiteAppColor,
      appBar: GlobalAppBar(
        child: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 25.0, color: Constants.whiteAppColor),
        ),
        enableBackButton: false,
        height: size.height * 0.15,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.05,
            ),
            DotStepper(
              // direction: Axis.vertical,
              dotCount: 3,
              dotRadius: 8.7,
              lineConnectorsEnabled: true,

              /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
              activeStep: activeStep,
              shape: Shape.circle,
              spacing: size.width * 0.3,
              indicator: Indicator.shift,

              /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
              onDotTapped: (tappedDotIndex) {
                /* setState(() {
                  activeStep = tappedDotIndex;
                });*/
              },

              // DOT-STEPPER DECORATIONS
              fixedDotDecoration: const FixedDotDecoration(
                color: Colors.red,
              ),

              indicatorDecoration: const IndicatorDecoration(
                  color: Colors.green, strokeWidth: 0.0, strokeColor: Colors.green),
              lineConnectorDecoration: const LineConnectorDecoration(
                  color: Colors.black, strokeWidth: 1.0),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  child: Text(
                    'Account Verification',
                    textAlign: TextAlign.center,
                    style: _textStyle,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                  child: Text(
                    'Basic Data',
                    textAlign: TextAlign.center,
                    style: _textStyle,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.2,
                  child: Text(
                    'Upload Attachments',
                    textAlign: TextAlign.center,
                    style: _textStyle,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.0,
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(shrinkWrap: true, children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * .05, bottom: 10),
                    child: const Center(
                      child: Text("Create Account",
                          style:
                              TextStyle(color: Constants.HINT, fontSize: 32)),
                    ),
                  ),
                  Center(
                    child: Text(
                        "Please enter your phone number to\nreceive the verification code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Constants.HINT.withOpacity(0.7),
                            fontSize: 16,
                            height: 1.6)),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone Number",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Constants.HINT, fontSize: 16),
                      )),
                  TxtFieldWidget(
                    labelTxt: "",
                    textEditingController: phoneTextEditingController,
                    isHasNextFocus: false,
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  BlocBuilder<CheckPhoneCubit, CheckPhoneState>(
                      builder: (context, state) {
                    if (state is CheckPhoneLoading) {
                      return Column(
                        children: [
                          SizedBox(height: size.height * 0.036),
                          SpinKitThreeBounce(
                            color: Constants.primaryAppColor,
                            size: size.width * .08,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: size.height * 0.036),
                          BtnWidget(
                              txt: "Send OTP",
                              color: Constants.primaryAppColor,
                              onClicked: () => onPressedCreateAccount(context)),
                        ],
                      );
                    }
                  }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                          text: "Already have an account ? ",
                          style: TextStyle(
                              color: Constants.HINT.withOpacity(0.5),
                              fontSize: 15),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    })),
                              style: const TextStyle(
                                  color: Constants.primaryAppColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  onPressedCreateAccount(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (!await MyApplication.checkConnection()) {
      Fluttertoast.showToast(
          msg: getTranslated(context, 'noInternet')!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    FormState form = _formKey.currentState!;
    if (form.validate()) {
      BlocProvider.of<CheckPhoneCubit>(context).CheckPhone(
          context: context,
          phone: cCode + phoneTextEditingController.text.toString().trim(),
          widgetType: 'signup');
      Constants.phoneNumber =
          cCode + phoneTextEditingController.text.toString().trim();
    }
  }
}
