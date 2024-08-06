import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocproject/productsmodule/models/trending_products_model.dart';
import 'package:blocproject/productsmodule/repos/liked_list_model.dart';
import 'package:blocproject/productsmodule/repos/orderfetchrepo.dart';
import 'package:blocproject/productsmodule/repos/trending_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'models/usermodel.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<PostInitialEvent>(postInitialEvent);
    on<SelectedProductEvent>(selectedProductEvent);
    on<LikedListClickedEvent>(likedListClickedEvent);
    on<TrendButtonClickedEvent>(trendButtonClickedEvent);
  }

  FutureOr<void> selectedProductEvent(event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoadingState());
      OrdersModel? orderdata =
          await OrdersRepo().fetchOrderByID(event.productId);
      print("bloc get datat ${orderdata!.title}");
      emit(OrderGetProductSuccess(ordermodel: orderdata));
    } catch (e) {
      emit(OrdersErrorState(error: "Order not found"));
    }
  }

  FutureOr<void> postInitialEvent(
      PostInitialEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoadingState());
      List<OrdersModel> userdata = await OrdersRepo().fetchOrders();
      emit(OrdersFetchingSuccessfull(usermodel: userdata));
    } catch (e) {
      emit(OrdersErrorState(error: 'Something went wrong'));
      log(e.toString());
    }
  }

  FutureOr<void> likedListClickedEvent(
      LikedListClickedEvent event, Emitter<OrdersState> emit) {
    if (likedList.isEmpty) {
      emit(OrdersErrorState(error: "Please add some Items"));
    } else {
      emit(OrderLikedProductSuccessState(likeddata: likedList));
    }
  }

  FutureOr<void> trendButtonClickedEvent(
      TrendButtonClickedEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(OrdersLoadingState());
      List<TrendingModel> trendData =
          await TrendingRepo().GetTrendingProducts();
      emit(TrendingSuccessState(trendingModel: trendData));
    } catch (e) {
      emit(OrdersErrorState(error: 'Something went wrong'));
      log(e.toString());
    }
  }
}
