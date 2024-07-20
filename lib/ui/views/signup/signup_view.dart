import 'package:bootcamp_team_83_flutter/ui/common/ui_helpers.dart';
import 'package:bootcamp_team_83_flutter/ui/views/signup/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StackedView<SignupViewModel> {
  SignupView({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController surnamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget builder(
      BuildContext context, SignupViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/arka_plan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Selam Dostum! Akademideki kaydını oluşturmak için birkaç bilgiye ihtiyacımız var.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(
                      'assets/astronot_signup.png', // Astronot resmi dosya yolu
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),

                // İsim
                _buildTextField(
                  controller: namecontroller,
                  hintText: 'İsim',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                // Soyisim
                _buildTextField(
                  controller: surnamecontroller,
                  hintText: 'Soyisim',
                  icon: Icons.subtitles,
                ),
                const SizedBox(height: 20),

                // Email
                _buildTextField(
                  controller: emailcontroller,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),

                // Şifre
                _buildTextField(
                    controller: passwordcontroller,
                    hintText: 'Şifre',
                    icon: Icons.password,
                    obscureText: true),
                const SizedBox(height: 20),

                // Şifre Tekrarı
                _buildTextField(
                    controller: confirmpasswordController,
                    hintText: 'Şifre tekrarı',
                    icon: Icons.password_rounded,
                    obscureText: true),
                const SizedBox(height: 10),

                // Buton
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildElevatedButton(
                    onPressed: () async {
                      await viewModel.signUp(
                        emailcontroller.text,
                        passwordcontroller.text,
                        confirmpasswordController.text,
                        namecontroller.text,
                        surnamecontroller.text,
                      );
                    },
                    text: 'Bitti',
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      " Aramızdan biri misin?",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.goToLogin();
                      },
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
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
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFD7EAF8),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0XFFAAACAF), fontWeight: FontWeight.bold),
        prefixIcon: Icon(
          icon,
          color: Colors.black54,
        ),
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
  SignupViewModel viewModelBuilder(BuildContext context) {
    return SignupViewModel();
  }
}
