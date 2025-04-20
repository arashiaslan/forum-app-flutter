import 'package:flutter/material.dart';
import 'package:frontend/views/home.dart';
import 'package:frontend/views/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      final token = box.read('token');
      if (token != null) {
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => const LoginPage());
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
