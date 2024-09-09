import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jamal_ed/ui/screens/splash/controller.dart';
import 'package:jamal_ed/ui/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (controller) => const Scaffold(
        backgroundColor: mainColor,
        body: Center(
          child: Text(
            'Jamal ED',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
