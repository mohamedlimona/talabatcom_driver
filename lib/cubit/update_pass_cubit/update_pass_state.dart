

import 'package:talabatcom_driver/models/update_pass_model.dart';

abstract class UpdatePassState {}

class UpdatePassInitial extends UpdatePassState {}

class UpdatePassLoading extends UpdatePassState {}

class UpdatePassLoaded extends UpdatePassState {
  UpdatePassResponse updatePassResponse;
  UpdatePassLoaded(this.updatePassResponse);
}

class UpdatePassError extends UpdatePassState {}
