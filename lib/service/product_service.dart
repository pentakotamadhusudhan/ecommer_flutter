import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_baba/model/categories_model.dart';
import 'package:local_baba/service/user_service.dart';

import '../model/product_model.dart';
import '../model/stores_models.dart';

class ProductService {
  // Use your machine's IP address instead of localhost if testing on a real device
  static const String apiUrl = baseUrl + "/store/addproducts/";
  static const String getCategoriesUrl = baseUrl + "/store/catagory/";
  static const String productsByCategoryUrl =
      baseUrl + "/store/store/products/?";
  static const String storesUrl = baseUrl + "/store/store/stores/";

  Future<List<ProductsModel>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(productsByCategoryUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);

        // Drill down into the 'data' list from your response
        final List<dynamic> productList = decodedBody['data'];

        return productList.map((item) => ProductsModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<ProductsModel>> fetchProductsByCategory({
     int? category_id,
     int? store_id,
  }) async {
    try {
      String param = "";
      if(category_id!=null){param= "category_id=$category_id";} else{ param= "store_id=$store_id";}
      Uri url = Uri.parse("$productsByCategoryUrl${param}");
      print(url);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);

        // Drill down into the 'data' list from your response
        final List<dynamic> productList = decodedBody['data'];

        return productList.map((item) => ProductsModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<StoresModel>> fetchStoresService() async {
    try {
      Uri url = Uri.parse(storesUrl);
      print(url);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);

        // Drill down into the 'data' list from your response
        final List<dynamic> storesList = decodedBody['data'];

        return storesList.map((item) => StoresModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(getCategoriesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);

        // Drill down into the 'data' list from your response
        final List<dynamic> productList = decodedBody['data'];

        return productList.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
