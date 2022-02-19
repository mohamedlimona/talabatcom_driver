// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:talabatcom_driver/repositories/changestatus_repo.dart';

import 'changestatus_state.dart';

class ChangestatusCubit extends Cubit<ChangestatusState> {
  ChangestatusCubit() : super(ChangestatusInitial());

  ChangestatusRepo Changestatus = ChangestatusRepo();
  bool? response;
  Future <bool?>? getChangestatus({int? status_id,int? order_id,String? note}) {
    try {
      emit(ChangestatusLoading());
      Changestatus.Changestatus(status_id: status_id,order_id: order_id).then((value) {
        if (value != null) {
          response = value;
          emit(ChangestatusLoaded(value));
          return value;
        } else {
          emit(ChangestatusErorr());
        }
      });
    } catch (e) {
      emit(ChangestatusErorr());
    }
  }
}