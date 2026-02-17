import 'package:flutter/material.dart';

import 'package:local_baba/service/product_service.dart';
import 'package:local_baba/user_registraion.dart';

import '../../app_style.dart';
import '../../model/product_model.dart';
import '../../utils/custom_widgets.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController searchController = TextEditingController();
  final ProductService _productService = ProductService();
  Widget _buildCategoryItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.surface,
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2. Search Bar
          customSearchbar(searchController: searchController, context: context),
          // 3. Category horizontal list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Categories",
                style: Theme.of(context).textTheme.titleMedium),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: [
                _buildCategoryItem("Jewelry", Icons.diamond),
                _buildCategoryItem("Watches", Icons.watch),
                _buildCategoryItem("Fashion", Icons.checkroom),
                _buildCategoryItem("Beauty", Icons.auto_awesome),
                _buildCategoryItem("Bags", Icons.work_outline),
              ],
            ),
          ),

          // 4. Promo Banner
          Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            // Removed fixed height to allow for text scaling, added constraints instead
            constraints: const BoxConstraints(minHeight: 160),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(20), // Slightly more modern curve
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, Color(0xFF8E6E5E)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              // Clips the decorative circle
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Background Decorative Circle
                  Positioned(
                    right: -50,
                    top: -50,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Summer Collection",
                          style: TextStyle(
                            fontSize: 24, // Increased size
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Ensure high contrast
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Get 20% off with code MODA26",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Shop Now",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. Product Grid Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("New Arrivals",
                style: Theme.of(context).textTheme.titleMedium),
          ),

          // 6. Product Grid (Mock)

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FutureBuilder<List<ProductsModel>>(
              future: _productService.fetchProducts(),
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

                final products = snapshot.data!;

                // 1. Grouping Logic (Keep this)
                final Map<String, List<ProductsModel>> groupedProducts = {};
                for (var product in products) {
                  final String catName =
                      product.category?.categoryName ?? "Other";
                  if (!groupedProducts.containsKey(catName)) {
                    groupedProducts[catName] = [];
                  }
                  groupedProducts[catName]!.add(product);
                }

                final categories = groupedProducts.keys.toList();

                // 2. Use a single ListView to show categories
                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Let the parent screen handle scrolling
                  itemCount: categories.length,
                  itemBuilder: (context, catIndex) {
                    String categoryName = categories[catIndex];
                    List<ProductsModel> categoryItems =
                        groupedProducts[categoryName]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Header
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            categoryName.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFFC5A08E),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // stores and products

                        // 3. GridView for products in this category
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryItems.length,

                            itemBuilder: (context, index) {
                              final product = categoryItems[index];

                              return productCardWidget(
                                  context: context, product: product);
                            },
                          ),
                        ),
                        const SizedBox(height: 20), // Space between categories
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
