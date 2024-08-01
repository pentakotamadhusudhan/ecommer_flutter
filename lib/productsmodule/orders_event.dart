// orders_event.dart
part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class PostInitialEvent extends OrdersEvent {}
class OrderPostEvent extends OrdersEvent {}

class SelectedProductEvent extends OrdersEvent{
  int? productId;
  SelectedProductEvent({required this.productId});
}

class LikedListClickedEvent extends OrdersEvent{


}