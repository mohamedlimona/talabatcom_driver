import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im_stepper/stepper.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/sign_up_data_model.dart';
import 'package:talabatcom_driver/screens/sign_up_files_upload_details_screen.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';

class SignUpScreenFilesUpload extends StatefulWidget {
  final SignUpDataModel signUpDataModel;
  const SignUpScreenFilesUpload({Key? key, required this.signUpDataModel})
      : super(key: key);

  @override
  _SignUpScreenFilesUploadState createState() =>
      _SignUpScreenFilesUploadState();
}

class _SignUpScreenFilesUploadState extends State<SignUpScreenFilesUpload> {
  int activeStep = 0;
  var check = true;
  final TextStyle _textStyle = const TextStyle(
    fontSize: 14.0,
    color: Constants.bord,
  );
  String path = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
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
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 0.0),
              child: Column(
                children: [
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
                        color: Colors.green,
                        strokeWidth: 0.0,
                        strokeColor: Colors.green),
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
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(children:  [
              Text(
                  "welcome, ${widget.signUpDataModel.name}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 20.0, height: 2),
              ),
              const Spacer()
            ]),
            Row(children: [
              SizedBox(
                  width: size.width / 1.3,
                  child: const Text(
                    'Here\'s what you need to do to set up your account',
                    style: TextStyle(
                        fontSize: 15.0, color: Constants.bord, height: 1.5),
                  )),
              const Spacer()
            ]),
            SizedBox(
              height: size.height * 0.035,
            ),
            Row(children: [
              SvgPicture.asset(
                'assets/images/icco.svg',
                height: 15.0,
                width: 15,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                'National ID',
                style: TextStyle(color: Constants.bord, fontSize: 13.0),
              ),
            ]),
            SizedBox(
              height: size.height * 0.035,
            ),
            Row(children: [
              SvgPicture.asset(
                'assets/images/icco.svg',
                height: 15.0,
                width: 15,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                'Driver License',
                style: TextStyle(color: Constants.bord, fontSize: 13.0),
              ),
            ]),
            SizedBox(
              height: size.height * 0.035,
            ),
            Row(children: [
              SvgPicture.asset(
                'assets/images/icco.svg',
                height: 15.0,
                width: 15,
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                'Vehicle License',
                style: TextStyle(color: Constants.bord, fontSize: 13.0),
              ),
            ]),
            const Spacer(),
            InkWell(
                onTap: () {
                  MyApplication.navigateTo(
                      context,
                      SignUpScreenFilesUploadDetails(
                          screenType: 'id',
                          signUpDataModel: widget.signUpDataModel,
                          photoPaths: List.generate(6, (index) => '')));
                },
                child: Row(children: const [
                  Spacer(),
                  Text(
                    'Start',
                    style: TextStyle(
                        fontSize: 18.0, color: Constants.primaryAppColor),
                  ),
                  SizedBox(
                    width: 20.0,
                  )
                ])),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
