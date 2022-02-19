import 'package:talabatcom_driver/models/list_orders_model.dart';

abstract class ListOrdersState {}

class ListOrdersInitial extends ListOrdersState {}

class ListOrdersLoading extends ListOrdersState {}

class ListOrdersLoaded extends ListOrdersState {
  ListOrdersModel listOrdersModel;
  ListOrdersLoaded(this.listOrdersModel);
}

class ListOrdersError extends ListOrdersState {}
