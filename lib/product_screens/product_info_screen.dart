import 'package:flutter/material.dart';

import '../app_style.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.textMain),
        actions: [],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Container
            Stack(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.iphotography.com/wp-content/uploads/2023/06/Best-Cameras-for-Professional-Photography-6.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: 10,
                  child: Transform.rotate(
                    angle: 310 * 3.14159 / 180,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.yellow.withValues(alpha: 0.6),
                          shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.send),
                          color: AppColors.textMain),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.6),
                        shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        color: AppColors.textMain),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PREMIUM COLLECTION',
                      style: TextStyle(
                          color: AppColors.primary,
                          letterSpacing: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Rose Gold Minimalist Watch',
                      style: AppTextStyles.heading),
                  const SizedBox(height: 12),
                  const Text('\$249.00',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),

                  const Text('Description',
                      style: TextStyle(
                          color: AppColors.textMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text(
                    'Experience the perfect blend of luxury and functionality. This timepiece features a brushed copper casing, sapphire crystal glass, and a premium leather strap designed for lasting comfort.',
                    style: AppTextStyles.body,
                  ),

                  const SizedBox(height: 32),

                  // Action Buttons
                  ElevatedButton(
                    onPressed: () {},
                    style: AppButtons.primaryAction,
                    child: const Text('ADD TO CART'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: AppButtons.socialAction,
                    child: const Text('SHARE PRODUCT'),
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
