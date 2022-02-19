





import 'package:talabatcom_driver/models/check_phone_model.dart';

abstract class CheckPhoneState {}

class CheckPhoneInitial extends CheckPhoneState {}

class CheckPhoneLoading extends CheckPhoneState {}

class CheckPhoneLoaded extends CheckPhoneState {
  CheckPhoneResponse checkPhoneResponse;
  CheckPhoneLoaded(this.checkPhoneResponse);
}

class CheckPhoneError extends CheckPhoneState {}
