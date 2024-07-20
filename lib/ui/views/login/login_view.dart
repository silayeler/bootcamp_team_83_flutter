import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:bootcamp_team_83_flutter/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StackedView<LoginViewModel> {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/arka_plan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Text(
                  "HOŞ  GELDİN!",
                  style: GoogleFonts.courierPrime(
                    textStyle: const TextStyle(
                      color: Color(0xFFD7EAF8),
                      letterSpacing: .5,
                      fontSize: 35,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Resim
                Image.asset(
                  'assets/login.png',
                  fit: BoxFit.cover,
                  height: 350,
                  width: 370,
                ),
                // Email
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                // Şifre
                _buildTextField(
                  controller: passwordController,
                  hintText: 'Şifre',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Buton
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildElevatedButton(
                    onPressed: () async {
                      await viewModel.signIn(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    text: 'Giriş',
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Aramizda yeni misin?',
                      style: TextStyle(color: Color(0xFFAAACAF), fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.goToRegister();
                      },
                      child: const Text(
                        'Kayıt Ol',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFD7EAF8),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0XFFAAACAF), fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          backgroundColor: const Color(0xFFD4F6C8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) {
    return LoginViewModel();
  }
}
