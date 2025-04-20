import 'package:flutter/material.dart';
import 'package:frontend/controllers/authentication.dart';
import 'package:frontend/views/login_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import './widgets/input_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register Page',
                  style: GoogleFonts.poppins(fontSize: size * 0.080)),
              const SizedBox(height: 30),
              InputWidget(
                controller: _nameController,
                obscureText: false,
                labelText: 'Name',
              ),
              const SizedBox(height: 30),
              InputWidget(
                controller: _userNameController,
                obscureText: false,
                labelText: 'Username',
              ),
              const SizedBox(height: 30),
              InputWidget(
                controller: _emailController,
                obscureText: false,
                labelText: 'Email',
              ),
              const SizedBox(height: 30),
              InputWidget(
                controller: _passwordController,
                obscureText: true,
                labelText: 'Password',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () async {
                  await _authenticationController.register(
                    name: _nameController.text.trim(),
                    username: _userNameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );
                },
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const Center(child: const CircularProgressIndicator(color: Colors.white,))
                      : Text('Register',
                          style: GoogleFonts.poppins(
                              fontSize: size * 0.040, color: Colors.white));
                }),
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Get.to(() => const LoginPage());
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(fontSize: size * 0.040),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
