import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/sign_up_data_model.dart';
import 'package:talabatcom_driver/screens/sign_up_files_upload_screen.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';
import 'package:talabatcom_driver/widgets/txtfield_widget.dart';

class SignUpScreenData extends StatefulWidget {
  const SignUpScreenData({Key? key}) : super(key: key);

  @override
  _SignUpScreenDataState createState() => _SignUpScreenDataState();
}

class _SignUpScreenDataState extends State<SignUpScreenData> {
  int activeStep = 0;
  var check = true;
  final TextStyle _textStyle = const TextStyle(
    fontSize: 14.0,
    color: Constants.bord,
  );
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController NationalIdTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController passTextEditingController =
      TextEditingController();
  final TextEditingController confirmPassTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool matching = false;

  @override
  void initState() {
    super.initState();
    confirmPassTextEditingController.addListener(() {
      setState(() {
        matching = passTextEditingController.text.toString().trim() == confirmPassTextEditingController.text.toString().trim();
      });


    });
    passTextEditingController.addListener(() {
      setState(() {
        matching = passTextEditingController.text.toString().trim() == confirmPassTextEditingController.text.toString().trim();
      });


    });
  }

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
              activeStep: 2,
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
                color: Colors.green,
              ),

              indicatorDecoration: const IndicatorDecoration(
                  color: Colors.red, strokeWidth: 0.0, strokeColor: Colors.red),
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
              height: size.height * 0.04,
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(shrinkWrap: true, children: [
                  TxtFieldWidget(
                    labelTxt: "Username",
                    textEditingController: nameTextEditingController,
                    isHasNextFocus: true,
                    textInputType: TextInputType.name,
                  ),
                  TxtFieldWidget(
                    labelTxt: "Password",
                    textEditingController: passTextEditingController,
                    isHasNextFocus: true,
                    textInputType: TextInputType.visiblePassword,
                    type: "signup",
                  ),
                  TxtFieldWidget(
                    labelTxt: "Confirm Password",
                    textEditingController: confirmPassTextEditingController,
                    isHasNextFocus: false,
                    textInputType: TextInputType.visiblePassword,
                    pass: passTextEditingController.text.toString(),
                  ),
                 /* TxtFieldWidget(
                    labelTxt: "National ID",
                    textEditingController: NationalIdTextEditingController,
                    isHasNextFocus: false,
                    textInputType: TextInputType.number,

                  ),*/
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: matching && passTextEditingController.text.toString().isNotEmpty,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/images/valide_phone.svg",
                            fit: BoxFit.fill,
                            height:20.0 ,
                            width: 20.0,
                            color: const Color(0xFF80AF50),
                          ),
                          const SizedBox(width: 10.0,),
                          const Text("Matching Password",
                              style:
                              TextStyle(color: Constants.HINT, fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                       text: "By creating an account you agree\n",
                      style: TextStyle(color: Constants.HINT, fontSize: 14,height: 1.5),
                      children: [
                        TextSpan(
                            text: "to the ",
                            style: TextStyle(color: Constants.HINT, fontSize: 14),
                            children: [
                              TextSpan(
                                  text: "privacy policy ",
                                  style: TextStyle(color: Constants.primaryAppColor, fontSize: 14),
                              ),
                              TextSpan(
                                  text: "and to the ",
                                  style: TextStyle(color: Constants.HINT, fontSize: 14),
                              ),
                              TextSpan(
                                text: "terms of use",
                                style: TextStyle(color: Constants.primaryAppColor, fontSize: 14),
                              ),
                            ]
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: BtnWidget(
                      txt: "Sign Up",
                      color: Constants.primaryAppColor,
                      onClicked: () {
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          if (check) {
                            SignUpDataModel signUpDataModel = SignUpDataModel(
                                name: nameTextEditingController.text,
                                nationalId: NationalIdTextEditingController.text,
                                password: passTextEditingController.text,
                                confirmPass:
                                    confirmPassTextEditingController.text,
                                phone: Constants.phoneNumber);
                            MyApplication.navigateTo(
                                context,
                                SignUpScreenFilesUpload(
                                    signUpDataModel: signUpDataModel));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'please accept terms',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Constants.primaryAppColor,
                                textColor: Constants.whiteAppColor,
                                fontSize: 16.0);
                          }
                        }
                      },
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
