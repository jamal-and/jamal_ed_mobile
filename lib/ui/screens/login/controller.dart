import 'package:jamal_ed/core/controllers/userController.dart';
import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool newUser = false;
  bool showPassword = false;

  Usercontroller usercontroller = Get.find<Usercontroller>();
  void checkNewUser(bool? v) {
    newUser = v ?? false;
    update();
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void login() {
    if (newUser) {
      if (validatePassword() == null) {
        usercontroller.signUp(
          userName: userNameController.text,
          pass: passwordController.text,
        );
        newUser = false;
        update();
      }
    } else {
      usercontroller.login(
        userName: userNameController.text,
        pass: passwordController.text,
      );
    }
  }

  String? validatePassword() {
    String value = passwordController.text;
    String message = '';
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value.isEmpty) {
      message = 'Please enter password';
      showErrorMessage(message: message);
      return message;
    } else {
      if (!regex.hasMatch(value)) {
        message =
            'Password should contain at least one upper case, one lower case, one digit, one Special character, and Must be at least 6 characters';
        showErrorMessage(message: message, seconds: 10);
        return '';
      } else {
        return null;
      }
    }
  }
}
