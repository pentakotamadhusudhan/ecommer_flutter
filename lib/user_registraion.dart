import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_baba/service/user_service.dart';

import 'app_style.dart';

// --- STYLES SECTION (The "CSS") ---


// --- UI SCREEN SECTION ---
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for API fields
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String _selectedGender = "MALE";
  bool _isLoading = false;

  // Registration Logic
  Future<void> _handleRegister() async {
    setState(() => _isLoading = true);

    const String url = "http://192.168.1.6:8000/user/register/";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": _usernameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "mobile": _mobileController.text,
          "gender": _selectedGender,
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        _showSnackBar("Registration Successful!", Colors.green);
        Navigator.pop(context); // Return to Login
      } else {
        _showSnackBar("Registration Failed: ${response.body}", Colors.red);
      }
    } catch (e) {
      _showSnackBar(
        "Connection Error. Check if server is running.",
        Colors.orange,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ApiService().register(
            username: "vendor562",
            email: "vendor498@dfs.com",
            password: "Madhu@12",
            mobile: "7894567844",
            gender: "MALE",
            firstName: "vendor4",
            lastName: "vendor4",
          );
        },
      ),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Fill in your details to get started",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 30),

            // Name Row
            Row(
              children: [
                Expanded(
                  child: _buildTextField(_firstNameController, "First Name"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(_lastNameController, "Last Name"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildTextField(_usernameController, "Username"),
            const SizedBox(height: 16),

            _buildTextField(
              _emailController,
              "Email Address",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              _mobileController,
              "Mobile Number",
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              value: _selectedGender,
              dropdownColor: AppColors.surface,
              style: const TextStyle(color: AppColors.textMain),
              decoration: _inputDecoration("Gender"),
              items: ["MALE", "FEMALE", "OTHER"].map((String val) {
                return DropdownMenuItem(value: val, child: Text(val));
              }).toList(),
              onChanged: (val) => setState(() => _selectedGender = val!),
            ),
            const SizedBox(height: 16),

            _buildTextField(_passwordController, "Password", isObscure: true),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        "CREATE ACCOUNT",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper to keep code clean
  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isObscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textMain),
      decoration: _inputDecoration(label),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      filled: true,
      fillColor: AppColors.surface,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}
