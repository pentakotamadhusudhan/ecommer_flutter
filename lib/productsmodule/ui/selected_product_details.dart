import 'package:blocproject/productsmodule/models/usermodel.dart';
import 'package:blocproject/productsmodule/orders_bloc.dart';
import 'package:blocproject/productsmodule/repos/liked_list_model.dart';
import 'package:blocproject/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/snackbar_const.dart';

class ProductDetails extends StatefulWidget {
  final OrdersModel product;

  ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<ProductDetails> {
  bool isLiked = false;
  OrdersBloc ordersBloc = OrdersBloc();

  bool description_maxlines = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("product details screen ${widget.product.image}");
    return Scaffold(
      backgroundColor: ColorConst.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConst.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 250,
                  width: 250,
                  child: Image(
                    image: NetworkImage(widget.product.image!),
                    fit: BoxFit.contain,
                  ),
                  decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: NetworkImage(widget.product.image ??
                      //         'https://via.placeholder.com/500'),
                      //     fit: BoxFit.cover,
                      //   ),
                      color: ColorConst.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorConst.grey),
                      boxShadow: [
                        BoxShadow(
                            color: ColorConst.grey,
                            blurRadius: 5,
                            spreadRadius: 2)
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title ?? 'No Title',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            // Print the updated state
                            if (isLiked) {
                              likedList.add(widget.product);
                              print(likedList);
                            } else {
                              int itemIndex = likedList.indexOf(widget.product);
                              likedList.removeAt(itemIndex);

                              print(likedList);
                            }
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '${widget.product.rating?.rate.toString() ?? 0}/5.0',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Text(
                    '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  5.verticalSpace,
                  InkWell(
                    onTap: () {
                      description_maxlines =!description_maxlines;
                      setState(() {});
                    },
                    child: Text(
                      widget.product.description ?? 'No Description',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: description_maxlines?5:3,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        var snackBar = SnackBar(
                            elevation: 0,
                            // margin: EdgeInsets.symmetric(vertical:300),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.white,
                            content: AlertDialog(
                              backgroundColor: Colors.white12,
                              title: Center(
                                child: const Text(
                                  "Added to bucket",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ).animate().tint(
                                    color: Colors.green,
                                    duration: Duration(seconds: 1)),
                              ),
                              content: SizedBox(
                                width: 400,
                                height: 20,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart,
                                      size: 40,
                                    )
                                        .animate()
                                        .moveX(
                                            begin: 0,
                                            end: 200,
                                            duration:
                                                Duration(milliseconds: 900))
                                        .tint(
                                            color: Colors.green,
                                            duration: Duration(seconds: 1))
                                        .animate()
                                        .fadeOut(
                                            delay: Duration(milliseconds: 1300))
                                  ],
                                ),
                              ),
                            ));

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.teal[50],
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Add to basket',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        const snackBar = SnackBar(
                          elevation: 0,
                          margin: EdgeInsets.symmetric(vertical: 0),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Ready to buy',
                            contentType: ContentType.success,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange[200],
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Buy',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
