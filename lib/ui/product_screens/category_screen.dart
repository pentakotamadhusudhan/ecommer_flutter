import 'package:flutter/material.dart';
import 'package:local_baba/model/categories_model.dart';

import '../../service/product_service.dart';

import 'products_list_screen.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductService _productService = ProductService();
  bool isLoading = true;
  List<CategoryModel> categories = [];
  Future fetchCategories() async {
    categories= await _productService.fetchCategories();
    setState(() {
      isLoading= false;
      categories;
    });
    print(categories);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 50,
          padding: EdgeInsets.all(5),
          child: SearchBar(
            leading: const Icon(Icons.search),
            hintText: "Search collections...",
            onChanged: (v){
              print(v);
            },
          ),),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height-220,
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(), // Let the parent screen handle scrolling
                itemCount: categories.length,
                itemBuilder: (context, catIndex) {
                  String? categoryName = categories[catIndex].categoryName;

                  return InkWell(
                    onTap: () {
                      print("product select ${categories[catIndex].id}");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsListScreen(category_id: categories[catIndex].id!,)));
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
