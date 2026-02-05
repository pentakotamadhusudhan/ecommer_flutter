import 'package:flutter/material.dart';
import 'package:local_baba/customer/customer_screen.dart';
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
