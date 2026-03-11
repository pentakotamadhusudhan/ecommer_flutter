import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_baba/model/product_model.dart';
import 'package:local_baba/service/event_service.dart';
import 'package:local_baba/utils/constant_string.dart';

import '../app_style.dart';

Widget productCardWidget({
  required BuildContext context,
  required ProductsModel product,
}) {
  return InkWell(
    onTap: (){
      print("object");
      EventService().logEvent(eventType: ConstantString().PRODUCT_CLICK,
      productId: product.product!.productName,
        categoryId: product.category!.categoryName,
        storeId: product.store!.name,


      );
    },
    child: Container(
      width: 150,

      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Material(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE SECTION
              Stack(
                children: [
                  SizedBox(
                    height: 170,
                    width: double.infinity,
                    child: Image.network(
                      // product.product!.productImage ?? "",
                      "https://picsum.photos/200/300",
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: .35),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// favorite button
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal.withValues(alpha: .9),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                          ),
                          onPressed: () {
                            print("on tap product");
                          },
                        ),
                      ),
                    ),
                  ),

                  /// price badge
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(.7),
                      ),
                      child: Text(
                        "\$${product.product!.price}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// DETAILS
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product!.productName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      product.product!.description ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget customSearchbar({
  required TextEditingController searchController,
  required BuildContext context,
  String? hintText,
  IconData? icon,
  double? height,
  double? width,
  Function(String)? onSubmit, // Defined the type
  Function(String)? onChanged, // Defined the type
}) {
  return Container(
    height: 80,
    padding: EdgeInsets.all(16.0),
    child: TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: hintText ?? "product/store name/category...",
        hintStyle: TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmit,
    ),
  );
}
