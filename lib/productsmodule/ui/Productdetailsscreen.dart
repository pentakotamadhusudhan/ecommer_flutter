import 'package:blocproject/productsmodule/ui/selected_product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../customewidgets/custome_loaders.dart';
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

          if (state is OrdersLoadingState) {
            return Center(child: CustomeLoaders());
          } else if (state is OrdersErrorState) {
            return Center(child: Text('An error occurred: ${state.error}'));
          } else if (state is OrderGetProductSuccess) {
            final successState = state as OrderGetProductSuccess;

            return ProductDetails(product: successState.ordermodel!);
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      )
    );
  }
}


