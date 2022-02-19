import 'package:talabatcom_driver/models/tracking_model.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  Trackingmodel? response;
  TrackingLoaded(this.response);
}

class TrackingErorr extends TrackingState {}
