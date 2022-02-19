import 'package:talabatcom_driver/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class Loginloading extends LoginState {}

class Loginloaded extends LoginState {
  Usermodel? response;
  Loginloaded(this.response);
}

class Loginerorr extends LoginState {}
