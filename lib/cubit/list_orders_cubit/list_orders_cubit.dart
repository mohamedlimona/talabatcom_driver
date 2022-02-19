import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:talabatcom_driver/repositories/orders.dart';
import '../../models/list_orders_model.dart';
import 'list_orders_state.dart';

class ListOrdersCubit extends Cubit<ListOrdersState> {
  ListOrdersCubit() : super(ListOrdersInitial());

  ListOrdersModel? listOrders({String? token, BuildContext? context}) {
    try {
      emit(ListOrdersLoading());
      getListOrders(token!).then((value) {
        if (value != null) {
          emit(ListOrdersLoaded(value));
        } else {
          emit(ListOrdersError());
        }
      });
    } catch (e) {
      emit(ListOrdersError());
    }
  }
}
