import 'dart:convert';
import 'dart:developer';

import 'package:blocproject/productsmodule/models/trending_products_model.dart';
import 'package:http/http.dart' as http;

import '../../utils/static_urls.dart';
import '../models/usermodel.dart';


class TrendingRepo{
  Future<List<TrendingModel>> GetTrendingProducts() async{
    List<TrendingModel> trendingList = [];
    final response = await http.get(Uri.parse(Url.getalltrendingproducts));
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(response.body);
      trendingList = jsonResponse
          .map((json) => TrendingModel.fromJson(json))
          .toList();
      return trendingList;
    }else{
      throw Exception('Failed to get trending products');
    }
  }
}