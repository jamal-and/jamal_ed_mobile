import 'package:jamal_ed/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        Get.offAllNamed(routeLogin);
      },
    );
  }
}
