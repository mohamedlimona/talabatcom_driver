

abstract class ChangestatusState {}

class ChangestatusInitial extends ChangestatusState {}

class ChangestatusLoading extends ChangestatusState {}

class ChangestatusLoaded extends ChangestatusState {
  bool? response;
  ChangestatusLoaded(this.response);
}

class ChangestatusErorr extends ChangestatusState {}
