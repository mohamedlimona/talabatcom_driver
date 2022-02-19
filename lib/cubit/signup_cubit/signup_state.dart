

import 'package:talabatcom_driver/models/signup_model.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {

  SignUpLoaded();
}

class SignUpError extends SignUpState {}
