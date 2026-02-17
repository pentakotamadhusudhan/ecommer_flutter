import 'package:flutter/material.dart';
import 'package:local_baba/model/stores_models.dart';
import 'package:local_baba/service/product_service.dart';
import 'package:local_baba/ui/product_screens/products_list_screen.dart';
import '../../utils/custom_widgets.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController searchController = TextEditingController();

  bool _isLoading = true;
  List<StoresModel> _allStores = [];      // Master list
  List<StoresModel> _displayedStores = []; // Filtered list

  @override
  void initState() {
    super.initState();
    getStores(); // Initial load
  }

  // 1. Fetch from API (Used for initial load, refresh, and explicit search)
  Future<void> getStores({String? query}) async {
    if (!mounted) return;

    setState(() => _isLoading = true);

    try {
      // Use the query if provided, otherwise use the controller text
      final searchPath = query ?? searchController.text;
      final fetchedStores = await _productService.fetchStoresService(storeName: searchPath);

      if (mounted) {
        setState(() {
          _allStores = fetchedStores;
          _displayedStores = fetchedStores;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
      debugPrint("Error fetching stores: $e");
    }
  }

  // 2. Local Filter (Instant results as user types)
  void _filterStores(String query) {
    if (query.isEmpty) {
      setState(() => _displayedStores = _allStores);
      return;
    }

    setState(() {
      _displayedStores = _allStores
          .where((store) => (store.name ?? "")
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customSearchbar(
              context: context,
              searchController: searchController,
              hintText: "Search Stores...",
              onChanged: (v) => _filterStores(v), // Fast local filter
              onSubmit: (v) => getStores(query: v), // Deep API search
            ),

            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFC5A08E)))
                  : RefreshIndicator(
                color: const Color(0xFFC5A08E),
                onRefresh: () => getStores(), // Pull to refresh
                child: _displayedStores.isEmpty
                    ? _buildEmptyState()
                    : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _displayedStores.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 22,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    final store = _displayedStores[index];
                    return _buildStoreCard(store);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Extracted Card Widget for cleaner code
  Widget _buildStoreCard(StoresModel store) {
    return InkWell(
      onTap: () {
        if (store.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsListScreen(store_id: store.id!),
            ),
          );
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  'assets/images/istockphoto-1314210006-612x612 (1).jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                store.name ?? "Unknown Store",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        const Center(child: Text("No stores found", style: TextStyle(color: Colors.grey))),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}