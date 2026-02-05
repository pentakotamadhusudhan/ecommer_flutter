import 'package:flutter/material.dart';
import 'package:local_baba/customer/profile_screen.dart';
import 'package:local_baba/product_screens/order_screens.dart';
import 'package:local_baba/product_screens/product_info_screen.dart';
import 'package:local_baba/product_screens/wishlist_screen.dart';
import 'package:local_baba/utils/constant_string.dart';

import 'package:badges/badges.dart' as badges;
import '../app_style.dart';
import '../service/product_service.dart';

class CustomerDashBoardScreen extends StatefulWidget {
  const CustomerDashBoardScreen({super.key});

  @override
  State<CustomerDashBoardScreen> createState() =>
      _CustomerDashBoardScreenState();
}

class _CustomerDashBoardScreenState extends State<CustomerDashBoardScreen> {
  int _selectedIndex = 0;
  // Inside your _CustomerDashBoardScreenState
  final ProductService _productService = ProductService();

  final List<Widget> _screens = [
    const CustomerScreen(), // Move your existing SingleChildScrollView content here
    const WishlistScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // 1. Custom App Bar
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
        leading: Icon(Icons.shopify_sharp),
        title: Text(ConstantString().APP_TITLE,
            style: TextStyle(
                letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          badges.Badge(
            badgeContent:
                Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.primary),
            position: badges.BadgePosition.topEnd(top: -10, end: -10),
            child: Icon(Icons.shopping_cart, color: AppColors.textMain),
          ),
          SizedBox(
            width: 10,
          ),
          badges.Badge(
            badgeContent:
                Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
            badgeStyle: badges.BadgeStyle(badgeColor: AppColors.primary),
            position: badges.BadgePosition.topEnd(top: -10, end: -10),
            child: Icon(Icons.notifications, color: AppColors.textMain),
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),

      body: _screens[_selectedIndex],
      // 7. Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Wishlist"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

//
// Padding(
// padding: const EdgeInsets.all(16.0),
// child:// Replace your GridView.builder with this:
// FutureBuilder<List<Product>>(
// future: _productService.fetchProducts(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const Center(child: CircularProgressIndicator());
// } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
// return const Center(child: Text("No products found", style: TextStyle(color: Colors.white)));
// }
//
// final products = snapshot.data!;
//
// return GridView.builder(
// shrinkWrap: true,
// physics: const NeverScrollableScrollPhysics(),
// itemCount: products.length,
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// childAspectRatio: 0.8,
// mainAxisSpacing: 10,
// crossAxisSpacing: 10,
// ),
// itemBuilder: (context, index) {
// final product = products[index];
// return Card(
// color: const Color(0xFF1E1E1E),
// child: Column(
// children: [
// Text(product.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// Text("${product.brand}", style: const TextStyle(color: Colors.grey)),
// Text("\$${product.price}", style: const TextStyle(color: Color(0xFFC5A08E))),
// Text("Stock: ${product.stock}", style: const TextStyle(color: Colors.white70, fontSize: 10)),
// ],
// ),
// );
// },
// );
// },
// )
// ),

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
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

  Widget _buildProductCard() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductInfoScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey, // Placeholder for Image.network
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: const Center(
                    child: Icon(Icons.image, color: Colors.white24)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Name",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("\$120.00", style: TextStyle(color: AppColors.primary)),
                ],
              ),
            )
          ],
        ),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search collections...",
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 3. Category horizontal list
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Categories",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
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
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFF8E6E5E)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Summer Collection",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text("Get 20% off with code MODA26",
                          style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: const Text("Shop Now",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // 5. Product Grid Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("New Arrivals",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),

          // 6. Product Grid (Mock)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildProductCard();
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}
