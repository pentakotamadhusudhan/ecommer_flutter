import 'package:flutter/material.dart';
import 'package:local_baba/app_style.dart';
import 'package:local_baba/service/user_service.dart';
import 'package:local_baba/user_registraion.dart' hide AppColors;
import 'package:local_baba/utils/constant_string.dart';
import 'package:local_baba/utils/constant_string.dart';
import 'customer/customer_dashboard.dart';
// Import your style file here

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Inside your LoginScreen State class
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ApiService _apiService = ApiService();

  bool obscure = true;
  bool isLoading = false;
  Future handleLogin() async {
    setState(() {
      isLoading = true;
    });
    final user = await _apiService.login(
      _emailController.text,
      _passController.text,
    );

    if (user != null) {
      // Success: Navigate to Home or Show Welcome
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Welcome ${user.username}")));
    } else {
      // Failure
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid Credentials")));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              // Logo Placeholder
              const Icon(
                Icons.auto_awesome_mosaic,
                size: 60,
                color: AppColors.primary,
              ),
              const SizedBox(height: 10),
              Text(ConstantString().APP_TITLE, style: AppTextStyles.heading),
              const Text(
                "Welcome back to Style & Flow",
                style: AppTextStyles.body,
              ),

              const SizedBox(height: 40),

              // Social Login Zone
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.apple),
                label: const Text("Continue with Apple"),
                style: AppButtons.socialAction,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text("Continue with Google"),
                style: AppButtons.socialAction,
              ),

              const SizedBox(height: 30),
              const Text("OR", style: TextStyle(color: AppColors.inputBorder)),
              const SizedBox(height: 30),

              // Traditional Input Fields
              TextField(
                controller: _emailController,
                decoration: _inputDecoration("Email or Phone Number"),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passController,
                obscureText: obscure,
                decoration: _inputDecoration("Password").copyWith(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(Icons.visibility_outlined, color: Colors.grey),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Main CTA
              ElevatedButton(
                onPressed: isLoading
                    ? () {}
                    : () async {
                        // await handleLogin();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomerDashBoardScreen()));
                      },
                style: AppButtons.primaryAction,
                child: isLoading
                    ? CircularProgressIndicator()
                    : const Text("SIGN IN SECURELY"),
              ),
            ],
          ),
        ),
      ),
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
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }
}
