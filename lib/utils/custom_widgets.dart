

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_baba/model/product_model.dart';

Widget productCardWidget(
{
  required BuildContext context,
  required ProductsModel product,
}
    ){
  return Card(
    color: Theme.of(context).cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius:
              const BorderRadius.vertical(
                  top: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(product.product!
                    .productImage ??
                    'https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE='),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                product.product!.productName ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),
              SizedBox(
                width: 150,
                child: Text(
                  product.product!.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
                ),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Text(
                      "\$${product.product!.price}",
                      style: const TextStyle(
                          color: Color(0xFFC5A08E),
                          fontWeight:
                          FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        // Grabs the color from your textTheme or primaryColor
                        color: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.color,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}