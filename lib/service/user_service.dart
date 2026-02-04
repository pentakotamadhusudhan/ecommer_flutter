import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:local_baba/model/user_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.6:8000/";
  static const String loginUrl = "$baseUrl/user/login/";
  static const String registrationUrl = "$baseUrl/user/register/";

  Future<User?> login(String email, String password) async {
    print(email);
    print(password);
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return User.fromJson(data['data']); // Returns the first user in the list
        }
      }
      return null;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }


  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String mobile,
    required String gender,
    required String firstName,
    required String lastName,
}) async {
    try {
      final response = await http.post(
        Uri.parse(registrationUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "mobile": mobile,
          "gender": gender,
          "role": "VENDOR",
          "password": "Madhu@12"
        }),
      );
      print(response.statusCode);
      print(response.body);
      // Assuming 201 Created or 200 OK for successful registration
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      debugPrint("Registration Error: $e");
      return false;
    }
  }
}
