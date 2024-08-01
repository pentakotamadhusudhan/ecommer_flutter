part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}
class HomeLoadingEvent extends HomeEvent{}
class HomeLoadedEvent  extends  HomeEvent{}
class HomeErrorEvent extends HomeEvent{}