part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}



class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {

}

class ErrorHomeState extends HomeState {
  final String error;

  ErrorHomeState({required this.error});
}
