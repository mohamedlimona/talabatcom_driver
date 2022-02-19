import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talabatcom_driver/helpers/utils/sharedPreferenceClass.dart';
import 'package:talabatcom_driver/models/device_info_model.dart';
import 'package:talabatcom_driver/screens/assigned_orders_screen.dart';
import 'package:talabatcom_driver/screens/pending_screen.dart';
import 'package:talabatcom_driver/screens/welcome_screen.dart';
import '../../helpers/utils/myApplication.dart';
import '../../repositories/auth.dart';
import '../../screens/tracking_map_screen.dart';
import 'driverinfo_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit() : super(DriverInfoInitial());
  AuthRepo authRepo = AuthRepo();
  DriverInfoModel? driverInfo({String? token, BuildContext? context}) {
    try {
      emit(DriverInfoloading());
      authRepo.getDriverInfo(token!).then((value) {
        if (value != null) {
          emit(DriverInfoloaded(value));
          if (value.data.driver.available == true){
            sharedPrefs.settoken(value.data.apiToken);
            MyApplication.navigateToReplace(context!, AssignedOrdersScreen());
          }
        } else {
          emit(DriverInfoerorr());
        }
      });
    } catch (e) {
      emit(DriverInfoerorr());
    }
  }
}
