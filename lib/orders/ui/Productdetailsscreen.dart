import 'package:blocproject/orders/ui/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../orders_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productid;
   ProductDetailsScreen({super.key, required this.productid});

  @override
  State<ProductDetailsScreen> createState() => _ProductdetailsscreenState();
}

class _ProductdetailsscreenState extends State<ProductDetailsScreen> {
  OrdersBloc ordersBloc = OrdersBloc();

  @override
  void initState() {
    // TODO: implement initState
    ordersBloc.add(SelectedProductEvent(productId:widget.productid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:BlocConsumer<OrdersBloc, OrdersState>(
        bloc: ordersBloc,
        listenWhen: (previous, current) => current is OrdersActionState,
        buildWhen: (p, c) => c is! OrdersActionState,
        listener: (context, state) {
          // Handle side effects based on state changes
        },
        builder: (context, state) {
          print(state);
          if (state is OrdersLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OrdersErrorState) {
            return Text('An error occurred: ${state.error}');
          } else if (state is OrderGetProductSuccess) {
            final successState = state as OrderGetProductSuccess;
            print("success state data ${successState.ordermodel!.title}");
            return ProductDetails(product: successState.ordermodel!);
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      )
    );
  }
}

