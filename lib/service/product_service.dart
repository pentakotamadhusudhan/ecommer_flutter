import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_baba/service/user_service.dart';

import '../model/product_model.dart';


class ProductService {
  // Use your machine's IP address instead of localhost if testing on a real device
  static const String apiUrl = baseUrl+"/store/addproducts/";

  Future<List<ProductsModel>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
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
}