import 'package:jamal_ed/core/controllers/userController.dart';
import 'package:get/get.dart';

String? getUserId() {
  return Get.find<Usercontroller>().userId;
}

const String apiUsers = 'users';
const String apiLogin = 'users/login';
String apiAddContact() {
  return '$apiUsers/${getUserId()}/add-contact';
}

String apiDeleteContact(num contactId) {
  return '$apiUsers/${getUserId()}/delete-contact/$contactId';
}

String apiTopup() {
  return '$apiUsers/${getUserId()}/transactions';
}

const String apiLoginGoogle = 'login/google';
const String apiLoginTwitter = 'login/twitter';
const String apiForgotPassword = 'passwords/forgot';
