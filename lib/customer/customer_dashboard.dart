import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:local_baba/customer/customer_screen.dart';
import 'package:local_baba/customer/profile_screen.dart';
import 'package:local_baba/product_screens/order_screens.dart';
import 'package:local_baba/product_screens/wishlist_screen.dart';
import 'package:local_baba/utils/constant_string.dart';
import '../app_style.dart';

class CustomerDashBoardScreen extends StatefulWidget {
  const CustomerDashBoardScreen({super.key});

  @override
  State<CustomerDashBoardScreen> createState() =>
      _CustomerDashBoardScreenState();
}

class _CustomerDashBoardScreenState extends State<CustomerDashBoardScreen> {
  int _selectedIndex = 0;

  // Using IndexedStack prevents the screens from re-loading every time you switch tabs
  final List<Widget> _screens = [
    const CustomerScreen(),
    const WishlistScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // 1. Dynamic background from theme
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: const Icon(Icons.shopify_sharp, color: AppColors.primary),
        title: Text(
          ConstantString().APP_TITLE,
          style: theme.textTheme.displayLarge?.copyWith(fontSize: 18),
        ),
        actions: [
          _buildAppBarBadge(
            icon: Icons.shopping_cart_outlined,
            count: '3',
            onTap: () {},
          ),
          const SizedBox(width: 16),
          _buildAppBarBadge(
            icon: Icons.notifications_none_outlined,
            count: '5',
            onTap: () {},
          ),
          const SizedBox(width: 20),
        ],
      ),

      // 2. Body using IndexedStack to preserve scroll state
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // 3. Themed Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: theme.dividerColor, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: theme.hintColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Wishlist"),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: "Orders"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
      ),
    );
  }

  // Helper method for clean Badge code
  Widget _buildAppBarBadge({
    required IconData icon,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: badges.Badge(
        badgeContent: Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.primary, padding: EdgeInsets.all(4)),
        position: badges.BadgePosition.topEnd(top: -5, end: -5),
        child: Icon(icon, color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}