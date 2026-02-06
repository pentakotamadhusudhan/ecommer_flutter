import 'package:flutter/material.dart';
import '../app_style.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cache theme data for cleaner code
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      // 1. Dynamic background based on theme
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Automatically uses correct color for back arrow
        leading: const BackButton(),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. Product Image Section with Actions
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45, // Responsive height
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://www.iphotography.com/wp-content/uploads/2023/06/Best-Cameras-for-Professional-Photography-6.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Action Buttons on Image
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Column(
                    children: [
                      _ImageActionButton(
                        icon: Icons.favorite_border,
                        color: Colors.redAccent,
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _ImageActionButton(
                        icon: Icons.share_outlined,
                        color: theme.primaryColor,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 3. Product Details Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PREMIUM COLLECTION',
                    style: textTheme.labelLarge?.copyWith(
                      color: theme.primaryColor,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rose Gold Minimalist Watch',
                    style: textTheme.displayLarge, // Uses your themed heading
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '\$249.00',
                    style: textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Description',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Experience the perfect blend of luxury and functionality. This timepiece features a brushed copper casing, sapphire crystal glass, and a premium leather strap designed for lasting comfort.',
                    style: textTheme.bodyMedium, // Uses your themed body text
                  ),

                  const SizedBox(height: 40),

                  // 4. Action Buttons
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('ADD TO CART'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('VIEW STORE'), // Updated for multi-vendor context
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

// Helper Widget for Floating Image Buttons
class _ImageActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ImageActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}