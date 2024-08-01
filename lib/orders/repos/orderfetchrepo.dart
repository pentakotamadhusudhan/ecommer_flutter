import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../utils/static_urls.dart';
import '../models/usermodel.dart';

class OrdersRepo {
  Future<List<OrdersModel>> fetchOrders() async {
    List<OrdersModel> userModel = [];
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse(Url.getallproducts),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        userModel = data
            .map((user) => OrdersModel.fromJson(user))
            .toList(); // Correct usage of toList()
        // print(userModel);
        return userModel;
      } else {
        // throw Exception('Failed to load users');
        return userModel;
      }
    } catch (e) {
      log(e.toString());
      return userModel;
    }
  }

  Future<OrdersModel?> fetchOrderByID(int productId) async {
    OrdersModel? userModel;
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse(Url.getallproducts + '/$productId'),
      );
      print("response------ ");
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userModel = OrdersModel.fromJson(data); // Correct usage of toList()
        return userModel;
      } else {
        return userModel;
      }
    } catch (e) {
      log(e.toString());
      return userModel;
    }
  }
}
