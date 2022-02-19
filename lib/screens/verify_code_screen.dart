import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/verification_cubit/verification_cubit.dart';
import 'package:talabatcom_driver/cubit/verification_cubit/verification_state.dart';
import 'package:talabatcom_driver/helpers/lang/language_constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';
import 'package:talabatcom_driver/widgets/verify_container_widget.dart';



// ignore: use_key_in_widget_constructors
class VerifyCodeScreen extends StatefulWidget {
  final String phone;
  final String type;
  VerifyCodeScreen(this.phone, this.type);
  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen>
    with TickerProviderStateMixin {
  late FocusNode num1;
  late FocusNode num2;
  late FocusNode num3;
  late FocusNode num4;
  TextEditingController code1EditingController = TextEditingController();
  TextEditingController code2EditingController = TextEditingController();
  TextEditingController code3EditingController = TextEditingController();
  TextEditingController code4EditingController = TextEditingController();
  String code = '';
  final TextStyle _textStyle = const TextStyle(
    fontSize: 14.0,
    color: Constants.bord,
  );

  onPressedVerify(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (!await MyApplication.checkConnection()) {
      Fluttertoast.showToast(
          msg: getTranslated(context, "noInternet")!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    var code1 = code1EditingController.text.toString().trim();
    var code2 = code2EditingController.text.toString().trim();
    var code3 = code3EditingController.text.toString().trim();
    var code4 = code4EditingController.text.toString().trim();
    setState(() {
      code = code1 + code2 + code3 + code4;
    });
    VerificationCubit.context = context;
    VerificationCubit.code = code;
    VerificationCubit.type = widget.type;
    VerificationCubit.phone = widget.phone;
    BlocProvider.of<VerificationCubit>(context).Verification();
  }

  @override
  void initState() {
    super.initState();
    num1 = FocusNode();
    num2 = FocusNode();
    num3 = FocusNode();
    num4 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    num1.dispose();
    num2.dispose();
    num3.dispose();
    num4.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.whiteAppColor,
      appBar: GlobalAppBar(
        child: Row(children: [
          // const SizedBox(
          //   width: 10.0,
          // ),
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]),
        enableBackButton: false,
        height: size.height * 0.15,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.05,
                ),
                widget.type == 'signup'
                    ? DotStepper(
                        // direction: Axis.vertical,
                        dotCount: 3,
                        dotRadius: 8.7,
                        lineConnectorsEnabled: true,

                        /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
                        activeStep: 0,
                        shape: Shape.circle,
                        spacing: size.width * 0.3,

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
                            color: Colors.green,
                            strokeWidth: 0.0,
                            strokeColor: Colors.green),
                        lineConnectorDecoration: const LineConnectorDecoration(
                            color: Colors.black, strokeWidth: 1.0),
                      )
                    : Container(),
                widget.type == 'signup'
                    ? SizedBox(
                        height: size.height * 0.01,
                      )
                    : Container(),
                widget.type == 'signup'
                    ? Row(
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
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.only(top: size.height * .05, bottom: 10),
                  child: const Center(
                    child: Text("Verify Code",
                        style: TextStyle(color: Constants.HINT, fontSize: 28)),
                  ),
                ),
                Center(
                  child: Text(
                      "Please enter your phone messages &enter\nthe verification code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Constants.HINT.withOpacity(0.7),
                          fontSize: 16,
                          height: 1.6)),
                ),
                SizedBox(height: size.height * .05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                  child: Row(
                    children: [
                      VerifyContainerWidget(
                        textEditingController: code1EditingController,
                        focusNode: num1,
                        onChanged: (value) {
                          setState(() {});
                          nextField(value, num2);
                        },
                      ),
                      VerifyContainerWidget(
                          textEditingController: code2EditingController,
                          focusNode: num2,
                          onChanged: (value) {
                            setState(() {});
                            nextField(value, num3);
                          }),
                      VerifyContainerWidget(
                          textEditingController: code3EditingController,
                          focusNode: num3,
                          onChanged: (value) {
                            setState(() {});
                            nextField(value, num4);
                          }),
                      VerifyContainerWidget(
                          textEditingController: code4EditingController,
                          focusNode: num4,
                          onChanged: (value) {
                            setState(() {});
                            if (value.length == 1) {
                              num4.unfocus();

                              /// Then you need to check is the code is correct or not
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                BlocBuilder<VerificationCubit, VerificationState>(
                    builder: (context, state) {
                  if (state is VerificationLoading) {
                    return Column(
                      children: [
                        SizedBox(height: size.height * 0.06),
                        SpinKitThreeBounce(
                          color: Constants.primaryAppColor,
                          size: size.width * .08,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: size.height * 0.06),
                        BtnWidget(
                          txt: "Verify",
                          color: isValid()
                              ? Constants.primaryAppColor
                              : Constants.primaryAppColor.withOpacity(0.6),
                          onClicked: () async {
                            if (isValid()) {
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
                              onPressedVerify(context);
                            }
                          },
                        ),
                      ],
                    );
                  }
                }),
                const SizedBox(height: 25),
                Center(
                  child: Text.rich(TextSpan(
                      text: "Haven't received a code ? ",
                      style: TextStyle(
                          color: Constants.HINT.withOpacity(0.5), fontSize: 12),
                      children: const [
                        TextSpan(
                            text: "Send Again",
                            style: TextStyle(
                                color: Constants.primaryAppColor, fontSize: 12))
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*void onLoaded(VerificationResponse verificationResponse) {
    if (verificationResponse.status == true &&
            verificationResponse.message == "done") {
          // ignore: avoid_print
          print("verificationResponse====>  success");
           SchedulerBinding.instance!.addPostFrameCallback((_) {
                   MyApplication.navigateTo(context, CreateNewPassScreen());
                 });
        } else {
          // ignore: avoid_print
          print(" failed");
          // ignore: avoid_print
          print("status====> ${verificationResponse.status.toString()}");
          // ignore: avoid_print
          print("message====> ${verificationResponse.message.toString()}");
        }
  }*/
  bool isValid() {
    return !(code1EditingController.text.trim().isEmpty ||
        code2EditingController.text.trim().isEmpty ||
        code3EditingController.text.trim().isEmpty ||
        code4EditingController.text.trim().isEmpty);
  }
}
