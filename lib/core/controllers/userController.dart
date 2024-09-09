import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamal_ed/core/api/api_request.dart';
import 'package:jamal_ed/core/api/api_routes.dart';
import 'package:jamal_ed/core/api/keys.dart';
import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:jamal_ed/core/utils/keys.dart';
import 'package:jamal_ed/routes.dart';
import 'package:jamal_ed/ui/screens/home/controller.dart';

class Usercontroller extends GetxController {
  Map? userData;
  String? userId;
  final box = GetStorage();

  Future getUserData() async {
    await ApiRequest(
      path: '$apiUsers/${userData?[kId]}',
      method: getMethod,
    ).request(
      onSuccess: (data, response) {
        userData = data;
        userId = userData![kId];
        box.write(kUserData, userData);
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().userData = userData!;
          Get.find<HomeController>().refreshUserData();
        }
        Get.forceAppUpdate();
      },
    );
  }

  void login({required String userName, required String pass}) {
    ApiRequest(
      path: apiLogin,
      method: postMethod,
      shouldShowMessage: false,
      withLoading: true,
      body: {
        kUsername: userName,
        kPassword: pass,
      },
    ).request(
      onError: (error) {
        showErrorMessage(message: 'Wrong username or password');
      },
      onSuccess: (data, response) async {
        if (data is Map) {
          userData = data;
          userId = userData?[kId];
          await getUserData();
          if (userData != null) {
            Get.offAllNamed(routeHome);
          } else {
            showErrorMessage(
              message: 'Something unexpected happend please try next',
            );
          }
        } else {}
      },
    );
  }

  void signUp({required String userName, required String pass}) {
    ApiRequest(
      path: apiUsers,
      method: postMethod,
      body: {
        kUsername: userName,
        'passwordHash': pass,
        kTransactions: [],
        kContacts: [],
        kCredit: 1000,
      },
    ).request(
      onSuccess: (data, response) async {
        if (data is Map) {
          userData = data;
          userId = userData?[kId];
          await getUserData();
          if (userData != null) {
            Get.toNamed(routeHome);
          } else {
            showErrorMessage(
              message: 'Something unexpected happend please try next',
            );
          }
        } else {}
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    userData = box.read(kUserData);
    userId = userData?[kId];
  }
}
