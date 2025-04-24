import 'package:flutter/material.dart';
import 'package:onyx_task_app/core/enums/state_enum.dart';
import 'package:onyx_task_app/features/auth/data/models/login_credentials.dart';
import 'package:onyx_task_app/features/auth/logic/auth_provider.dart';
import 'package:onyx_task_app/features/home/data/models/delivery_request.dart';
import 'package:onyx_task_app/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String _langCode = "2";

  void _handleLogin(AuthProvider authProvider) async {
    final success = await authProvider.login(
      LoginCredentials(
        deliveryCode: userIdController.text.trim(),
        langCode: _langCode,
        password: passwordController.text.trim(),
      ),
    );

    if (success) {
      Provider.of<HomeProvider>(context, listen: false).getData(
        DeliveryRequest(
          pDlvryNo: userIdController.text.trim(),
          pLangNo: _langCode,
          pBillSrl: "",
          pPrcssdFlg: "",
        ),
        _langCode,
      );
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error ${authProvider.apiResult?.result.errMsg}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTopLogo(context),
                const SizedBox(height: 24),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D61),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Log back into your account',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                _buildTextField('User ID', userIdController),
                const SizedBox(height: 16),
                _buildTextField(
                  'Password',
                  passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Show More',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Consumer<AuthProvider>(
                    builder: (context, provider, _) {
                      return provider.state == StateEnum.loading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            onPressed: () => _handleLogin(provider),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF004D61),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Log in',
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/delivery.png', // Replace with your asset
                  height: 180,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopLogo(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFD32F2F), // red circle
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
            ),
            child: const Icon(Icons.language, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Image.asset(
            'assets/OnxRestaurant_Logo.png', // Replace with your logo asset
            height: 60,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF1F3F6),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
