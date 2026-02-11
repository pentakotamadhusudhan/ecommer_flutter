import 'package:flutter/material.dart';
import 'package:local_baba/model/stores_models.dart';
import 'package:local_baba/product_screens/products_list_screen.dart';
import 'package:local_baba/service/product_service.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: FutureBuilder<List<StoresModel>>(
        future: _productService.fetchStoresService(),
        builder: (context, snapshot) {
          /// 🔄 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ Error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          /// 📭 No Data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No stores found"));
          }

          final stores = snapshot.data!;

          /// ✅ Grid View
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: stores.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 22,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final store = stores[index];

              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsListScreen(store_id: store.id!,)));

                },
                child: Card(

                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            'assets/images/istockphoto-1314210006-612x612 (1).jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// Store Name
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          store.name ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
