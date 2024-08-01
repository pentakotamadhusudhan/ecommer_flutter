import 'package:blocproject/orders/models/usermodel.dart';
import 'package:blocproject/orders/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("product details screen ${widget.product.image}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product.image ??
                      'https://via.placeholder.com/500'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
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
                            print(isLiked); // Print the updated state
                          });
                        },
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '${widget.product.rating?.toString() ?? '0'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    widget.product.description ?? 'No Description',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: Text(
                                  "Added to buckets",
                                  style: TextStyle(
                                      fontSize: 24,
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
                                    Icon(
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
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Add to bucket',
                        style: TextStyle(fontSize: 16.0),
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
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
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
