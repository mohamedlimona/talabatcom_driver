import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talabatcom_driver/cubit/signup_cubit/signup_state.dart';
import 'package:talabatcom_driver/models/signup_model.dart';
import 'package:talabatcom_driver/repositories/auth.dart';


class SignUpCubit extends Cubit<SignUpState> {
  static BuildContext? context;
  SignUpResponse? response;
  SignUpCubit() : super(SignUpInitial());
  AuthRepo authRepo = AuthRepo();
  signUp(String name, String phone,
      String password, String passwordConfirmation,String idFrontImage
      ,String idBackImage ,String driverFrontImage
       ,String vehicleFrontImage
      ) {
    try {
      emit(SignUpLoading());
      authRepo
          .signUp(name,  phone, password, passwordConfirmation, idFrontImage, idBackImage, driverFrontImage,  vehicleFrontImage,context!)
          .then((value) {
        emit(SignUpLoaded());
 
      });
      return response;
    } catch (e) {
      emit(SignUpError());
    }
  }
}
