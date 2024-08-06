import 'package:blocproject/productsmodule/orders_bloc.dart';
import 'package:blocproject/utils/color_const.dart';
import 'package:blocproject/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slider_button/slider_button.dart';

class LikedListScrreen extends StatefulWidget {
  const LikedListScrreen({super.key});

  @override
  State<LikedListScrreen> createState() => _LikedListScrreenState();
}

class _LikedListScrreenState extends State<LikedListScrreen> {
  OrdersBloc ordersBloc = OrdersBloc();
  double cardheight = 240;
  bool isVisible = false;

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
        bloc: ordersBloc,
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
              final likeddata = state as OrderLikedProductSuccessState;
              return Center(
                  child: ListView.builder(
                      itemCount: likeddata.likeddata.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (cardheight == 240) {
                                cardheight += 50;
                                isVisible = true;
                              } else {
                                cardheight -= 50;
                                isVisible = false;
                              }
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: cardheight,
                              decoration: BoxDecoration(
                                  color: ColorConst.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                        color: ColorConst.grey,
                                        offset: Offset(2, 5))
                                  ]),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 220,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 180,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Image(
                                            image: NetworkImage(
                                              likeddata.likeddata[index].image
                                                  .toString(),
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            // color: Colors.white,
                                            child: Column(
                                              children: [
                                                Text(
                                                  likeddata
                                                      .likeddata[index].title
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyleConst.heading
                                                      .copyWith(fontSize: 14),
                                                ),
                                                5.verticalSpace,
                                                Text(
                                                  likeddata.likeddata[index]
                                                      .description
                                                      .toString(),
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                10.verticalSpace,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(" \u{20B9} " +
                                                        likeddata
                                                            .likeddata[index]
                                                            .price
                                                            .toString()),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.star),
                                                        Text(likeddata
                                                            .likeddata[index]
                                                            .rating!
                                                            .rate
                                                            .toString()),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: isVisible,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:SizedBox(
                                        height: 32,
                                        width: MediaQuery.of(context).size.width,
                                        child:  SliderButton(
                                          action: () async {
                                            ///Do something here
                                            print("object");
                                            return false;
                                          },
                                          label: Text(
                                            "Slide to cancel Event",
                                            style: TextStyle(
                                                color: Color(0xff4a4a4a),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          icon: Center(
                                              child: Icon(
                                                CupertinoIcons.bag,
                                                color: Colors.redAccent,
                                                size: 30.0,
                                                semanticLabel: 'Text to announce in accessibility modes',
                                              )),
                                          boxShadow: BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 4,
                                          ),
                                        )),
                                      )
                                    ),

                                ],
                              ),
                            ),
                          ),
                        );
                      }));
            default:
              return Center(child: Text("Something went wrong"));
          }
        },
      )),
    );
  }
}
