import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mjbeauty/presentation/controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final AuthController authController = Get.find<AuthController>();
      
      Future.delayed(const Duration(seconds: 30), () {
        if (authController.isLoggedIn()) {
          Get.offNamed('/home');
        } else {
          Get.offNamed('/auth');
        }
      });
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.purpleAccent], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.3, end: 1.0), 
                duration: const Duration(seconds: 1), 
                curve: Curves.elasticOut, 
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26, 
                        blurRadius: 10, 
                        offset: const Offset(0, 5)
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shopping_bag, 
                    size: 80, 
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 30), 
              const Text(
                'MJ Beauty',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}