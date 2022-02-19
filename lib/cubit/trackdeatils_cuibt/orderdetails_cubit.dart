import 'package:bloc/bloc.dart';
import 'package:talabatcom_driver/models/tracking_model.dart';
import 'package:talabatcom_driver/repositories/Tracking.dart';
import 'orderdetails_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit() : super(TrackingInitial());
  TrackingRepo Tracking = TrackingRepo();
  Trackingmodel? response;
  Future<Trackingmodel?>? getTracking(int? firsttime, int? order_id ) {
    try {
      if (firsttime == 1) {
        emit(TrackingLoading());
      }
      Tracking.getOrderDetails(order_id).then((value) {
        if (value != null) {
          response = value;
          emit(TrackingLoaded(value));
        } else {
          emit(TrackingErorr());
        }
      });
    } catch (e) {
      emit(TrackingErorr());
    }
  }
}
