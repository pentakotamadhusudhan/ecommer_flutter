import 'package:flutter/material.dart';
import 'package:local_baba/model/product_model.dart';
import 'package:local_baba/product_screens/product_info_screen.dart';
import 'package:local_baba/service/product_service.dart';
import '../utils/custom_widgets.dart';

class ProductsListScreen extends StatefulWidget {
  final int id;
  ProductsListScreen({super.key, required this.id});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local BABA Products"),
        backgroundColor: const Color(0xFFC5A08E), // Branding: Rose Gold
      ),
      body: FutureBuilder<List<ProductsModel>>(
        future: _productService.fetchProductsByCategory(id: widget.id),
        builder: (context, snapdata) {
          if (snapdata.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapdata.hasError) {
            return Center(child: Text("Error: ${snapdata.error}"));
          }

          if (!snapdata.hasData || snapdata.data!.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final products = snapdata.data!;

          return InkWell(
            onTap: () {
              print("ydgdggjdcsd");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductInfoScreen()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Better Header UI
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      products.first.category?.categoryName ??
                          "General Products",
                      style: Theme.of(context).textTheme.headlineLarge),
                ),

                // 2. Wrap GridView in Expanded to fill remaining space
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: products.length, // Don't forget this!
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          0.75, // Adjust this to fit your card height
                    ),
                    itemBuilder: (context, index) {
                      return productCardWidget(
                          context: context, product: products[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
