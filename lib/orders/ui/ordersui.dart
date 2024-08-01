import 'package:blocproject/orders/orders_bloc.dart';
import 'package:blocproject/utils/color_const.dart';
import 'package:blocproject/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Productdetailsscreen.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
        title: Text('Orders'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
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
                                EdgeInsets.only(left: 20, top: 5, bottom: 10),
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
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        successState.usermodel[index].image
                                            .toString(),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    SizedBox(
                                      height: 170,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                                                0.35,
                                            height: 30,
                                            child: Text(
                                              successState
                                                  .usermodel[index].title
                                                  .toString(),
                                              style: TextStyleConst.heading,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            height: 80,
                                            child: Text(
                                              successState
                                                  .usermodel[index].description
                                                  .toString(),
                                              style: TextStyleConst.body
                                                  .copyWith(fontSize: 12),
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Text(
                                                  "\u{20B9} ${successState.usermodel[index].price.toString()}.00",
                                                  maxLines: 3,
                                                  style: TextStyleConst.heading,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: SizedBox(
                                                    width: 200,
                                                    height: 40,
                                                    child: Column(
                                                      children: [
                                                        // Text(
                                                        //   "Rating  ${successState.usermodel[index].rating!.rate!.toString()}",
                                                        //   maxLines: 3,
                                                        //   style: TextStyleConst
                                                        //       .heading
                                                        //       .copyWith(
                                                        //           fontSize: 15),
                                                        //   overflow:
                                                        //       TextOverflow.fade,
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 10,
                                                        //   child:
                                                        //       LinearProgressIndicator(
                                                        //     value: successState
                                                        //             .usermodel[
                                                        //                 index]
                                                        //             .rating!
                                                        //             .rate! /
                                                        //         10,
                                                        //     borderRadius:
                                                        //         BorderRadius
                                                        //             .circular(
                                                        //                 10),
                                                        //     valueColor:
                                                        //         AlwaysStoppedAnimation<
                                                        //                 Color>(
                                                        //             Colors
                                                        //                 .blueAccent),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    )),
                                              )
                                            ],
                                          ),
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
                                        productid: index)));
                          },
                        ),
                      );
                    }),
              );
            case OrdersLoadingState:
              return Center(
                child: CircularProgressIndicator(),
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
