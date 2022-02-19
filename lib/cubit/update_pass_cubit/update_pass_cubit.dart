import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabatcom_driver/app/constants.dart';

import 'package:talabatcom_driver/cubit/update_pass_cubit/update_pass_state.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';

import 'package:talabatcom_driver/models/update_pass_model.dart';

import 'package:talabatcom_driver/repositories/auth.dart';
import 'package:talabatcom_driver/screens/login_screen.dart';


class UpdatePassCubit extends Cubit<UpdatePassState> {
  static BuildContext? context;
  UpdatePassResponse? response;

  static String? newPassword;
  static String? passwordConfirmation;
  static String? token;
  UpdatePassCubit() : super(UpdatePassInitial());
  AuthRepo authRepo = AuthRepo();
  UpdatePass() {
    try {
      emit(UpdatePassLoading());
      authRepo
          .updatePass( newPassword!, passwordConfirmation!,token!)
          .then((value) {
        if (value != null) {
          response = value;
          emit(UpdatePassLoaded(response!));
          Fluttertoast.showToast(
              msg: 'your password update success',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Constants.primaryAppColor,
              textColor: Constants.whiteAppColor,
              fontSize: 16.0);
          MyApplication.navigateTo(context!, LoginScreen());
        } else {
          emit(UpdatePassError());
        }
      });
      return response;
    } catch (e) {
      emit(UpdatePassError());
    }
  }
}
