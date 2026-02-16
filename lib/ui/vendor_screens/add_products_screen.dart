import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = "Fashion";

  Future<void> _postProduct() async {
    const String url = "http://192.168.1.6:8000/products/add/";

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": _nameController.text,
        "price": double.parse(_priceController.text),
        "description": _descController.text,
        "category": _selectedCategory,
        "vendor_id": 1, // Pass the logged-in user's ID
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Live!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("Post New Product"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildInput(_nameController, "Product Name"),
            const SizedBox(height: 15),
            _buildInput(_priceController, "Price (\$)", isNumber: true),
            const SizedBox(height: 15),
            _buildInput(_descController, "Full Description", maxLines: 3),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _postProduct,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC5A08E),
                  minimumSize: const Size(double.infinity, 50)
              ),
              child: const Text("POST PRODUCT", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}