// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:talabatcom_driver/app/constants.dart';
import 'package:talabatcom_driver/cubit/driverinfo_cubit/driverinfo_cubit.dart';
import 'package:talabatcom_driver/cubit/driverinfo_cubit/driverinfo_state.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/helpers/utils/sharedPreferenceClass.dart';
import 'package:talabatcom_driver/models/disdur_model.dart';
import 'package:talabatcom_driver/widgets/global_appbar_widget.dart';

import '../helpers/lang/language_constants.dart';
import '../widgets/btn_widget.dart';

class PendingScreen extends StatefulWidget {
  final String token;
  const PendingScreen({Key? key, required this.token}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("token===> ${widget.token}");
    sharedPrefs.settoken(widget.token);
    BlocProvider.of<DriverInfoCubit>(context).driverInfo(token: widget.token,context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.primaryAppColor,
      appBar: GlobalAppBar(
        color: Constants.whiteAppColor,
        enableBackButton: false,
        height: size.height * 0.4,
        child: SvgPicture.asset("assets/images/Logo Icon.svg",
            color: Constants.primaryAppColor, height: size.height * 0.22),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          MyApplication.checkConnection().then((value) {
            if (!value) {
              Fluttertoast.showToast(
                  msg: 'No Internet Connection',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              BlocProvider.of<DriverInfoCubit>(context).driverInfo(token: widget.token,context: context);
            }
          });
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(30),
            child: Column(
              children: [
                BlocBuilder<DriverInfoCubit, DriverInfoState>(
                    builder: (context, state) {
                  if (state is DriverInfoloading) {
                    return SizedBox(
                        height: size.height * 0.15,
                        width: size.width * 0.3,
                        child: Lottie.asset("assets/images/loading.json"));
                  } else {
                    return BtnWidget(
                      txt: "See request status",
                      color: Constants.whiteAppColor,
                      onClicked: () async {
                        MyApplication.checkConnection().then((value) {
                          if (value == true) {
                            BlocProvider.of<DriverInfoCubit>(context).driverInfo(token: widget.token,context: context);
                          } else {
                            Fluttertoast.showToast(
                                msg: getTranslated(context, 'noInternet')!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Constants.primaryAppColor,
                                textColor: Constants.whiteAppColor,
                                fontSize: 16.0);
                          }
                        });
                      },
                    );
                  }
                }),
                SizedBox(height: size.height * 0.07),
                const Text("Thank You",
                    style: TextStyle(
                        color: Constants.whiteAppColor, fontSize: 35)),
                SizedBox(height: size.height * 0.01),
                const Center(
                  child: Text("Your request is pending\nto approve!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Constants.whiteAppColor,
                          fontSize: 25,
                          height: 1.5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
