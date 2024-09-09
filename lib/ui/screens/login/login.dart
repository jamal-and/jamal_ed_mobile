import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/ui/screens/login/controller.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/theme/theme_colors.dart';
import 'package:jamal_ed/ui/widgets/button.dart';
import 'package:jamal_ed/ui/widgets/inputs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          //resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primary,
          body: SizedBox(
            //  height: kDeviceHeight,
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: kDeviceHeight * 0.1,
                      ),
                      const Icon(
                        CupertinoIcons.paperplane_fill,
                        size: 86,
                        color: AppColors.white,
                      ),
                      Text(
                        'Jamal ED',
                        style: tStyles['white32bold'],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDeviceHeight * 0.1,
                  ),
                  Center(
                    child: Container(
                      decoration: cardDecoration(withShadow: true),
                      //height: kDeviceHeight * 0.6,
                      width: kDeviceWidth * 0.9,
                      padding: generalPadding,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          generalBox,
                          Text(
                            'Login / Sing Up',
                            style: tStyles['black24bold'],
                          ),
                          generalBox,
                          generalBox,
                          CTextInput(
                            controller: controller.userNameController,
                            hint: 'UserName',
                            prefixIcon: Padding(
                              padding: generalPadding,
                              child: const Icon(Icons.person),
                            ),
                          ),
                          generalBox,
                          CTextInput(
                            controller: controller.passwordController,
                            hint: 'Password',
                            isPassword: !controller.showPassword,
                            suffix: CupertinoButton(
                              onPressed: () {
                                controller.toggleShowPassword();
                              },
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalSpacing / 2,
                              ),
                              minSize: 0,
                              child: Icon(
                                controller.showPassword
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: generalPadding,
                              child: const Icon(Icons.lock),
                            ),
                          ),
                          generalBox,
                          CheckboxListTile.adaptive(
                            value: controller.newUser,
                            onChanged: controller.checkNewUser,
                            title: const Text('New user?'),
                          ),
                          generalBox,
                          FullWidthButton(
                            text: controller.newUser ? 'Sing Up' : 'Login',
                            onPress: controller.login,
                          ),
                          generalBox,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
