import 'package:flutter/material.dart';
import 'package:local_baba/model/categories_model.dart';

import '../model/product_model.dart';
import '../product_screens/products_list_screen.dart';
import '../service/product_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FutureBuilder<List<CategoryModel>>(
            future: _productService.fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No products found",
                      style: TextStyle(color: Colors.white)),
                );
              }

              List<CategoryModel> products = snapshot.data!;
              print("categories $products");

              // 2. Use a single ListView to show categories
              return ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Let the parent screen handle scrolling
                itemCount: products.length,
                itemBuilder: (context, catIndex) {
                  String? categoryName = products[catIndex].categoryName;

                  return InkWell(
                    onTap: () {
                      print("product select ${products[catIndex].id}");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsListScreen(id: products[catIndex].id!,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10),
                      child: Text(
                        categoryName.toString(),
                        style: const TextStyle(
                          color: Color(0xFFC5A08E),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
