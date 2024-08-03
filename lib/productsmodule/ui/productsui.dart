import 'package:blocproject/customewidgets/custome_loaders.dart';
import 'package:blocproject/productsmodule/models/liked_list_products_model.dart';
import 'package:blocproject/productsmodule/orders_bloc.dart';
import 'package:blocproject/productsmodule/ui/liked_list_screen.dart';
import 'package:blocproject/utils/color_const.dart';
import 'package:blocproject/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Productdetailsscreen.dart';

class Productsui extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<Productsui> {
  OrdersBloc ordersBloc = OrdersBloc();

  // Add your state variables and methods here
  @override
  void initState() {
    ordersBloc.add(PostInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ordersBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LikedListScrreen()));
            },
            icon: const Icon(Icons.favorite_border_outlined),
          ),
        ],
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        bloc: ordersBloc,
        listenWhen: (previous, current) => current is OrdersActionState,
        buildWhen: (p, c) => c is! OrdersActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case OrdersFetchingSuccessfull:
              final successState = state as OrdersFetchingSuccessfull;
              print(successState.usermodel.length);
              return Container(
                child: ListView.builder(
                    itemCount: successState.usermodel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            padding:
                                const EdgeInsets.only(left: 20, top: 5, bottom: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorConst.selectedcolor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      width: 110,
                                      child: Image.network(
                                        successState.usermodel[index].image
                                            .toString(),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    SizedBox(
                                      height: 160,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            height: 40,
                                            child: Text(
                                              successState
                                                  .usermodel[index].title
                                                  .toString(),
                                              style: TextStyleConst.heading
                                                  .copyWith(fontSize: 16),
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: 60,
                                            child: Text(
                                              successState
                                                  .usermodel[index].description
                                                  .toString(),
                                              style: TextStyleConst.body
                                                  .copyWith(fontSize: 12),
                                              overflow: TextOverflow.fade,
                                              maxLines: 3,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 70,
                                                child: Text(
                                                  '\u{20B9}${successState.usermodel[index].price}',
                                                  style: TextStyleConst.body,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 70,
                                                height: 22,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    LinearProgressIndicator(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      value: (successState
                                                                  .usermodel[
                                                                      index]
                                                                  .rating
                                                                  ?.rate ??
                                                              0) /
                                                          10,
                                                      minHeight: 8,
                                                      valueColor:
                                                          const AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors
                                                                  .blueAccent),
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                    ),
                                                    Text(
                                                      "Rating ${successState.usermodel[index].rating?.rate ?? 0}/5",
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            // ordersBloc.add(SelectedProductEvent(productId: index));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        productid: successState
                                            .usermodel[index].id!)));
                          },
                        ),
                      );
                    }),
              );
            case OrdersLoadingState:
              return const Center(
                child: CustomeLoaders(),
              );
            case OrdersErrorState:
              final errorstate = state as OrdersErrorState;
              return Center(
                  child: Text(
                errorstate.error,
                style: TextStyleConst.error,
              ));
            default:
              return Container(
                  // Add UI components here

                  );
          }
        },
      ),
    );
  }
}
