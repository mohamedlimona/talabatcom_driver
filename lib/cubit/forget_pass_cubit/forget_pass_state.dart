import 'package:talabatcom_driver/models/forget_pass_model.dart';

abstract class ForgetPassState {}

class ForgetPassInitial extends ForgetPassState {}

class ForgetPassLoading extends ForgetPassState {}

class ForgetPassLoaded extends ForgetPassState {
  ForgetPassResponse forgetPassResponse;
  ForgetPassLoaded(this.forgetPassResponse);
}

class ForgetPassError extends ForgetPassState {}
