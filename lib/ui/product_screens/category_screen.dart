import 'package:flutter/material.dart';
import 'package:local_baba/model/categories_model.dart';
import 'package:local_baba/utils/custom_widgets.dart';
import '../../service/product_service.dart';
import 'products_list_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  List<CategoryModel> allCategories = []; // The "Master" list
  List<CategoryModel> displayedCategories = []; // The list visible in UI

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // Fetches data from API
  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await _productService.fetchCategories();
      if (mounted) {
        setState(() {
          allCategories = fetchedCategories;
          displayedCategories = fetchedCategories; // Initialize both lists
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
      debugPrint("Error fetching categories: $e");
    }
  }

  // Filters the list based on search input
  void _runFilter(String enteredKeyword) {
    List<CategoryModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = allCategories; // If search is empty, show everything
    } else {
      results = allCategories
          .where((category) => (category.categoryName ?? "")
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    print("search keyword: $enteredKeyword");
    setState(() {
      displayedCategories = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Searchbar
            customSearchbar(
                searchController: searchController,
                context: context,
                onChanged: (v) {
                  _runFilter(v);
                }),

            Expanded(
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFFC5A08E)))
                  : RefreshIndicator(
                      color: const Color(0xFFC5A08E),
                      backgroundColor: Colors.white,
                      onRefresh: fetchCategories,
                      child: displayedCategories.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemCount: displayedCategories.length,
                              itemBuilder: (context, catIndex) {
                                final category = displayedCategories[catIndex];

                                return InkWell(
                                  onTap: () {
                                    if (category.id != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductsListScreen(
                                            category_id: category.id!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 20),
                                    child: Text(
                                      category.categoryName ?? "Unnamed",
                                      style: const TextStyle(
                                        color: Color(0xFFC5A08E),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to show when no results are found (wrapped in ListView to enable pull-to-refresh)
  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 100),
        Center(
          child: Text(
            "No categories found",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose(); // Always dispose controllers to save memory
    super.dispose();
  }
}
