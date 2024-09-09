import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamal_ed/core/utils/keys.dart';
import 'package:jamal_ed/routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        if (box.read(kUserData) != null) {
          // Did user logged in
          Get.offAllNamed(routeHome);
        } else {
          Get.offAllNamed(routeLogin);
        }
      },
    );
  }
}
