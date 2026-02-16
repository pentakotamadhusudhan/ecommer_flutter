import 'package:flutter/material.dart';
import 'package:local_baba/service/user_service.dart';

import '../../model/product_details_model.dart';
import '../../service/product_service.dart';



class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<ProductsDetailsModel?>(
        future: ProductService().fetchProductDetailsService(products_id: 1),
        builder: (context, snapshot) {
          // 1. Handle Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Handle Error State
          if (snapshot.hasError) {
            return Center(
              child:
                  Text("Error: ${snapshot.error}", textAlign: TextAlign.center),
            );
          }

          // 3. Handle Success State
          if (snapshot.hasData) {
            final data = snapshot.data!;
            final product = data.product;
            print("image ${"$baseUrl${product?.productImage}"}");
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Product Image Section
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          image: DecorationImage(
                            image: NetworkImage(
                                "$baseUrl${product?.productImage}" ??
                                    'https://via.placeholder.com/400'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              color: Colors.redAccent,
                              onPressed: () {},
                            ),
                            const SizedBox(height: 12),
                            IconButton(
                              icon: Icon(Icons.share_outlined),
                              color: Colors.teal,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Product Details Section
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.category?.categoryName?.toUpperCase() ??
                              'COLLECTION',
                          style: textTheme.labelLarge?.copyWith(
                            color: theme.primaryColor,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product?.productName ?? 'Unknown Product',
                          style: textTheme.displayLarge,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '₹${data.discountPrice ?? data.originalPrice}',
                              style: textTheme.headlineSmall?.copyWith(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '₹${data.discountPrice ?? data.originalPrice}',
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white60,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Description',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product?.description ?? 'No description available.',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: (data.qty ?? 0) > 0 ? () {} : null,
                          child: Text(
                              (data.qty ?? 0) > 0 ? 'Buy it' : 'Out of Stock'),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                              'VIEW ${data.store?.name?.toUpperCase() ?? "STORE"}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("No data found"));
        },
      ),
    );
  }
}
