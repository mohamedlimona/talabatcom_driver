import '../../models/device_info_model.dart';

abstract class DriverInfoState {}

class DriverInfoInitial extends DriverInfoState {}

class DriverInfoloading extends DriverInfoState {}

class DriverInfoloaded extends DriverInfoState {
  DriverInfoModel? response;
  DriverInfoloaded(this.response);
}

class DriverInfoerorr extends DriverInfoState {}
