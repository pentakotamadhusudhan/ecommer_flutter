import 'package:blocproject/productsmodule/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikedListScrreen extends StatefulWidget {
  const LikedListScrreen({super.key});

  @override
  State<LikedListScrreen> createState() => _LikedListScrreenState();
}

class _LikedListScrreenState extends State<LikedListScrreen> {
  OrdersBloc ordersBloc = OrdersBloc();
  @override
  void initState() {
    ordersBloc.add(LikedListClickedEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked products"),
      ),
      body: Center(
          child: BlocConsumer<OrdersBloc, OrdersState>(
        listenWhen: (previous, current) => current is OrdersActionState,
        buildWhen: (p, c) => c is! OrdersActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case OrdersLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case OrdersErrorState:
              final errorState = state as OrdersErrorState;
              return Center(
                child: Text(errorState.error),
              );
            case OrderLikedProductSuccessState:
              return Center(child: Text("liked data"));
            default:
              return Center(child: Text("liked data"));
          }
        },
      )),
    );
  }
}
