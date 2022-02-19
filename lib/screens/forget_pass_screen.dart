// ignore: use_key_in_widget_constructors
// ignore_for_file: use_key_in_widget_constructors
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:talabatcom_driver/cubit/forget_pass_cubit/forget_pass_state.dart';
import 'package:talabatcom_driver/helpers/lang/language_constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/forget_pass_model.dart';
import 'package:talabatcom_driver/screens/verify_code_screen.dart';
import 'package:talabatcom_driver/widgets/btn_widget.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';
import 'package:talabatcom_driver/widgets/txtfield_widget.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen>
    with TickerProviderStateMixin {
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  String cCode = '+966';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GlobalAppBar(
        enableBackButton: false,
        height: size.height * 0.3,
        child: SvgPicture.asset("assets/images/Logo Icon.svg",
            height: size.height * 0.21),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: size.height * .05, bottom: 10),
              child: const Center(
                child: Text("Forget Password",
                    style: TextStyle(color: Constants.HINT, fontSize: 28)),
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
            SizedBox(height: size.height * .05),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 30.0, end: 30.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Phone Number",
                        style: TextStyle(color: Constants.HINT, fontSize: 15)),
                  ),
                  TxtFieldWidget(
                    labelTxt: "",
                    textEditingController: phoneTextEditingController,
                    isHasNextFocus: true,
                    textInputType: TextInputType.phone,
                    prefixIcon: SizedBox(
                      width: size.width/3.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountryCodePicker(
                            onChanged: (code)
                            {
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
                ],
              ),
            ),
            SizedBox(height: size.height * 0.06),
            BlocBuilder<ForgetPassCubit, ForgetPassState>(
                builder: (context, state) {
              if (state is ForgetPassLoading) {
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
                      txt: "Next",
                      color: Constants.primaryAppColor,
                      onClicked: () async {
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
                        ForgetPassCubit.context = context;
                        ForgetPassCubit.phone = cCode+phoneTextEditingController.text;
                        BlocProvider.of<ForgetPassCubit>(context).ForgetPass();
                      },
                    ),
                  ],
                );
              }
            }),
          ]),
        ),
      ),
    );
  }

  void onLoaded(ForgetPassResponse forgetPassResponse) {
    if (forgetPassResponse.status == true &&
        forgetPassResponse.message == "done") {
      // ignore: avoid_print
      print("forgetPassResponse====>  success");

      SchedulerBinding.instance!.addPostFrameCallback((_) {
        MyApplication.navigateTo(
            context, VerifyCodeScreen(phoneTextEditingController.text, ''));
      });
    } else {
      // ignore: avoid_print
      print(" failed");
      // ignore: avoid_print
      print("status====> ${forgetPassResponse.status.toString()}");
      // ignore: avoid_print
      print("message====> ${forgetPassResponse.message.toString()}");
    }
  }
}
