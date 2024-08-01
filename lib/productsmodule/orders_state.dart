// orders_state.dart
part of 'orders_bloc.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

abstract class OrdersActionState extends OrdersState {}


class OrdersFetchingSuccessfull extends OrdersState {
  final List<OrdersModel>usermodel;

  OrdersFetchingSuccessfull({required this.usermodel});
}

class OrdersLoadingState extends OrdersState {

}

class OrdersLoadedState extends OrdersState {
final dynamic data;

OrdersLoadedState({required this.data});
}

@immutable
class OrderGetProductSuccess extends OrdersState {
  OrdersModel? ordermodel;
  OrderGetProductSuccess({required this.ordermodel});
}


class OrdersErrorState extends OrdersState {
final String error;

OrdersErrorState({required this.error});
}



