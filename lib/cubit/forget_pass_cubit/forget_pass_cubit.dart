import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talabatcom_driver/helpers/utils/myApplication.dart';
import 'package:talabatcom_driver/models/forget_pass_model.dart';
import 'package:talabatcom_driver/repositories/auth.dart';
import 'package:talabatcom_driver/screens/verify_code_screen.dart';
import 'forget_pass_state.dart';

class ForgetPassCubit extends Cubit<ForgetPassState> {
  static BuildContext? context;
  ForgetPassResponse? response;
  static String? phone;

  ForgetPassCubit() : super(ForgetPassInitial());
  AuthRepo authRepo = AuthRepo();
  ForgetPass() {
    try {
      emit(ForgetPassLoading());
      authRepo.forgetPass(phone!).then((value) {
        if (value != null) {
          response = value;
          MyApplication.navigateTo(
              context!, VerifyCodeScreen(phone!, "forgetpass"));
          emit(ForgetPassLoaded(response!));
        } else {
          emit(ForgetPassError());
        }
      });
      return response;
    } catch (e) {
      emit(ForgetPassError());
    }
  }
}
