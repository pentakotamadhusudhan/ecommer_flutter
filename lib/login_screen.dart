import 'package:flutter/material.dart';
import 'package:local_baba/app_style.dart'; // Ensure this contains your AppTheme
import 'package:local_baba/service/user_service.dart';
import 'package:local_baba/ui/customer/customer_home_screen.dart';
import 'package:local_baba/user_registraion.dart' hide AppColors;
import 'package:local_baba/utils/constant_string.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ApiService _apiService = ApiService();

  bool obscure = true;
  bool isLoading = false;

  Future<void> handleLogin() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CustomerDashBoardScreen()),
    );
    if (_emailController.text.isEmpty || _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = await _apiService.login(_emailController.text, _passController.text);

      if (user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CustomerDashBoardScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid Credentials")),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accessing theme data once for cleaner code
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea( // Ensures content doesn't hit status bar
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
          // Makes buttons full width
            children: [
              // 1. Branding Section
              Center(
                child: Column(
                  children: [
                    SizedBox(

                        child: Image(image: AssetImage("assets/images/app_logo.png",),fit: BoxFit.cover,)),
                    Text(ConstantString().APP_TITLE, style: textTheme.displayLarge),

                    Text("Welcome back to Style & Flow", style: textTheme.bodyMedium),
                    SizedBox(height: 10,)
                  ],
                ),
              ),



              // 2. Social Login Zone
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.apple),
                label: const Text("Continue with Apple"),
              ),
              const SizedBox(height: 5),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text("Continue with Google"),
              ),

              const SizedBox(height: 10),

              // 3. Divider
              Row(
                children: [
                  Expanded(child: Divider(color: theme.dividerColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("OR", style: textTheme.bodySmall),
                  ),
                  Expanded(child: Divider(color: theme.dividerColor)),
                ],
              ),

              const SizedBox(height: 10),

              // 4. Input Fields
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: AppTheme().inputDecoration(context, "Email or Phone Number"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passController,
                obscureText: obscure,
                decoration: AppTheme().inputDecoration(context, "Password").copyWith(
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => obscure = !obscure),
                    icon: Icon(
                      obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: theme.hintColor,
                    ),
                  ),
                ),
              ),

              // 5. Secondary Actions
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ),

              const SizedBox(height: 15),

              // 6. Main CTA
              ElevatedButton(
                onPressed: isLoading ? null : handleLogin,
                child: isLoading
                    ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)
                )
                    : const Text("SIGN IN SECURELY"),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New here?", style: textTheme.bodyMedium),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                    },
                    child: const Text("Create Account"),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }


}