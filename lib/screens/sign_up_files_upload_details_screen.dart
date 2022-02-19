import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/signup_cubit/signup_cubit.dart';
import 'package:talabatcom_driver/cubit/signup_cubit/signup_state.dart';
import 'package:talabatcom_driver/helpers/lang/language_constants.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/sign_up_data_model.dart';
import 'package:talabatcom_driver/widgets/btn_widget2.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';

class SignUpScreenFilesUploadDetails extends StatefulWidget {
  final String screenType;
  final SignUpDataModel signUpDataModel;
  final List<String> photoPaths;
  const SignUpScreenFilesUploadDetails(
      {Key? key,
      required this.screenType,
      required this.signUpDataModel,
      required this.photoPaths})
      : super(key: key);

  @override
  _SignUpScreenFilesUploadDetailsState createState() =>
      _SignUpScreenFilesUploadDetailsState();
}

class _SignUpScreenFilesUploadDetailsState
    extends State<SignUpScreenFilesUploadDetails>
    with TickerProviderStateMixin {
  int activeStep = 0;
  var check = true;
  final TextStyle _textStyle = const TextStyle(
    fontSize: 14.0,
    color: Constants.bord,
  );
  XFile? _image;
  String path = '';
  final List<String> _screenTypes = [
    'id',
    'id_back',
    'driver',
    'vehicle',

  ];
  List<String> paths = [];

  _imgFromDevide({ImageSource? imageSource}) async {
    XFile? image =
    await ImagePicker().pickImage(source: imageSource!, imageQuality: 50);
    if (image != null) {
      setState(() {
        _image = image;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (paths.isEmpty) {
      paths = widget.photoPaths;
    }
    final size = MediaQuery
        .of(context)
        .size;
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
        padding: const EdgeInsets.only(right: 30.0, left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.04,
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
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(children: [
              widget.screenType == 'id'
                  ? const Text(
                'National ID',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    height: 2),
              )
                  : widget.screenType == 'id_back'
                  ? const Text(
                'National ID',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    height: 2),
              )
                  : widget.screenType == 'driver'
                  ? const Text(
                'Driver License',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    height: 2),
              )
                  : widget.screenType == 'driver_back'
                  ? const Text(
                'Driver License',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    height: 2),
              )
                  : widget.screenType == 'vehicle'
                  ? const Text(
                'Vehicle License',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    height: 2),
              )
                  : const Text(
                'Vehicle License',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    height: 2),
              ),
              const Spacer()
            ]),
            Row(children: [
              SizedBox(
                width: size.width / 1.3,
                child: widget.screenType == 'id'
                    ? const Text(
                  'Take a clear photo of the front of your\n government ID',
                  style: TextStyle(
                      fontSize: 15.0, color: Constants.bord, height: 2),
                )
                    : widget.screenType == 'id_back'
                    ? const Text(
                  'Take a clear photo of the back of your\n government ID',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Constants.bord,
                      height: 2),
                )
                    : widget.screenType == 'driver'
                    ? const Text(
                  'Take a clear photo of the front of your\n license',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Constants.bord,
                      height: 2),
                )
                    : widget.screenType == 'driver_back'
                    ? const Text(
                  'Take a clear photo of the back of your\n license',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Constants.bord,
                      height: 2),
                )
                    : widget.screenType == 'vehicle'
                    ? const Text(
                  'Take a clear photo of the front of your\n vehicle license',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Constants.bord,
                      height: 2),
                )
                    : const Text(
                  'Take a clear photo of the back of your\n vehicle license',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Constants.bord,
                      height: 2),
                ),
              ),
              const Spacer()
            ]),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              child:!kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return SvgPicture.asset("assets/images/icco.svg",
                          width: size.width * 0.16
                          , height: size.width * 0.16);
                    case ConnectionState.done:
                      return _image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_image!.path),
                          width: size.width * 0.76,
                          height: size.height * 0.2,
                          fit: BoxFit.fill,
                        ),
                      )
                          : SvgPicture.asset("assets/images/icco.svg",
                          width: size.width * 0.16
                          , height: size.width * 0.16);

                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return SvgPicture.asset("assets/images/icco.svg",
                            width: size.width * 0.16
                            , height: size.width * 0.16);
                      }
                  }
                },
              ): _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(_image!.path),
                  width: size.width * 0.76,
                  height: size.height * 0.2,
                  fit: BoxFit.fill,
                ),
              )
                  : SvgPicture.asset("assets/images/icco.svg",
                  width: size.width * 0.16
                  , height: size.width * 0.16),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: BtnWidget2(
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                color: Constants.primaryAppColor,
                onClicked: () {
                  _imgFromDevide(imageSource: ImageSource.camera);
                },
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                _imgFromDevide(imageSource: ImageSource.gallery);
              },
              child: const Text(
                'Upload Photo',
                style:
                TextStyle(fontSize: 16.0, color: Constants.primaryAppColor),
              ),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  if (_image != null) {
                    widget.screenType != 'vehicle'
                        ? completeSignUp()
                        : signUp();
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please choose a photo',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Constants.primaryAppColor,
                        textColor: Constants.whiteAppColor,
                        fontSize: 16.0);
                  }
                },
                child: Row(children: [
                  const Spacer(),
                  BlocBuilder<SignUpCubit, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpLoading) {
                          return SpinKitThreeBounce(
                            color: Constants.primaryAppColor,
                            size: size.width * .08,
                          );
                        } else {
                          return const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Constants.primaryAppColor),
                          );
                        }
                      }),
                  const SizedBox(
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

  void completeSignUp() async {
    if (_image != null) {
      setState(() {
        paths[_screenTypes.indexOf(widget.screenType)] = _image!.path;
      });
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
    MyApplication.navigateToWithoutAnim(
        context,
        SignUpScreenFilesUploadDetails(
            signUpDataModel: widget.signUpDataModel,
            photoPaths: paths,
            screenType:
            _screenTypes[_screenTypes.indexOf(widget.screenType) + 1]));
  }

  void signUp() {
    if (_image != null) {
      setState(() {
        paths[_screenTypes.indexOf(widget.screenType)] = _image!.path;
      });
    }
    SignUpCubit.context = context;
    BlocProvider.of<SignUpCubit>(context).signUp(
      widget.signUpDataModel.name!,
      widget.signUpDataModel.phone!,
      widget.signUpDataModel.password!,
      widget.signUpDataModel.confirmPass!,
      widget.photoPaths[0],
      widget.photoPaths[1],
      widget.photoPaths[2],
      widget.photoPaths[3],
    );
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker().retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type != RetrieveType.video) {
        setState(() {
          _image = response.file;
        });
      } else {

      }
    }
  }
}