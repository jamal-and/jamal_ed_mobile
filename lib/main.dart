import 'package:jamal_ed/core/controllers/userController.dart';
import 'package:jamal_ed/routes.dart';
import 'package:jamal_ed/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

void main() {
  Get.put(Usercontroller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Edened',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
        fontFamily: 'Mon',
      ),
      getPages: routes,
      builder: (context, child) {
        return FlutterSmartDialog(
          child: child,
        );
      },
    );
  }
}
