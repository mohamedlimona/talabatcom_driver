import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talabatcom_driver/models/user_model.dart';
import 'package:talabatcom_driver/screens/tracking_map_screen.dart';
import '../../helpers/utils/myApplication.dart';
import '../../repositories/auth.dart';
import '../../screens/assigned_orders_screen.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  AuthRepo auth = AuthRepo();
  Usermodel? login(
      {String? phone,
      String? pass,
      BuildContext? context,
      required bool remember}) {
    try {
      emit(Loginloading());
      auth.login(phone: phone, pass: pass, rememberme: remember).then((value) {
        if (value != null) {
          emit(Loginloaded(value));
          MyApplication.navigateToReplace(context!, AssignedOrdersScreen());
        } else {
          emit(Loginerorr());
        }
      });
    } catch (e) {
      emit(Loginerorr());
    }
  }
}
