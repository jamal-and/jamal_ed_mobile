import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/widgets/loading.dart';

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

SnackbarController showMessage({
  required String message,
  required String title,
  Color? messageColor,
  Widget? icon,
  Color? background,
  int seconds = 3,
}) {
  return Get.snackbar(
    title, message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: messageColor, // background?.withOpacity(0.7),
    colorText: Colors.white,
    icon: icon,
    duration: Duration(seconds: seconds),
    //snackPosition: SnackPosition.BOTTOM,
  );
  // return Flushbar(
  //   flushbarPosition: FlushbarPosition.TOP,
  //   borderRadius: generalRadius,
  //   shouldIconPulse: false,
  //   messageText: Text(
  //     message,
  //     style: textStyle14BlackSemiBold.copyWith(
  //       color: messageColor,
  //     ),
  //   ),
  //   backgroundColor: background ?? AppColors.background,
  //   icon: icon ?? const Icon(CupertinoIcons.info),
  //   margin: EdgeInsets.symmetric(
  //     vertical: verticalSpacing,
  //     horizontal: horizontalSpacing,
  //   ),
  //   duration: Duration(seconds: seconds),
  // )..show(
  //     Get.context!,
  //   );
}

void showSuccessMessage({
  required String message,
  String title = 'Success',
  int seconds = 3,
}) {
  showMessage(
    message: message,
    title: title,
    seconds: seconds,
    icon: const Icon(
      CupertinoIcons.check_mark_circled_solid,
      color: Colors.white,
    ),
    messageColor: Colors.green[600],
    background: Colors.green[200],
  );
}

void showWarningMessage({
  required String message,
  String title = 'Warning',
  int seconds = 3,
}) {
  showMessage(
    message: message,
    title: title,
    seconds: seconds,
    icon: const Icon(
      CupertinoIcons.exclamationmark_triangle_fill,
      color: Colors.white,
    ),
    messageColor: Colors.orange[700],
    background: Colors.yellow[100],
  );
}

void showInfoMessage({
  required String message,
  String title = 'Info',
  int seconds = 3,
}) =>
    showMessage(
      message: message,
      title: title,
      seconds: seconds,
      icon: const Icon(
        CupertinoIcons.info_circle_fill,
        color: Colors.white,
      ),
      messageColor: Colors.blue[900],
      background: Colors.blue[100],
    );

void showErrorMessage({
  required String message,
  String title = 'Error',
  int seconds = 3,
}) {
  showMessage(
    message: message,
    seconds: seconds,
    title: title,
    icon: const Icon(
      CupertinoIcons.xmark_circle_fill,
      color: Colors.white,
    ),
    messageColor: Colors.red[900],
    background: Colors.red[100],
  );
}

void dismissLoading() {
  SmartDialog.dismiss();
}

void startLoading() {
  SmartDialog.showLoading(
    builder: (context) {
      return GestureDetector(
        onDoubleTap: () {
          dismissLoading();
        },
        child: Container(
          decoration: cardDecoration(),
          width: kDeviceWidth * 0.35,
          height: kDeviceWidth * 0.35,
          child: const LoadingWidget(),
        ),
      );
    },
  );
}

String formatPhoneNumber(String number) {
  return '${number.toString().substring(0, 3)} ${number.toString().substring(3, 6)} ${number.toString().substring(6)}';
}
