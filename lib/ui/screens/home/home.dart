import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jamal_ed/core/api/log.dart';
import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/core/utils/keys.dart';
import 'package:jamal_ed/routes.dart';
import 'package:jamal_ed/ui/screens/home/controller.dart';
import 'package:jamal_ed/ui/screens/home/widgets/add_beneficiaries_sheet.dart';
import 'package:jamal_ed/ui/screens/home/widgets/recharge_sheet.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/theme/theme_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    //  padding: generalPadding,
                    child: SizedBox(
                      width: kDeviceWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          generalBox,
                          ListTile(
                            title: const Text('Welcome Back!'),
                            trailing: CupertinoButton(
                              onPressed: () {
                                GetStorage().erase();
                                Get.offAllNamed(routeLogin);
                              },
                              padding: EdgeInsets.zero,
                              child: const Text('Logout'),
                            ),
                            subtitle:
                                Text(controller.userData[kNormalizedUserName]),
                            leading: Container(
                              decoration:
                                  circleDecoration(color: AppColors.primary),
                              clipBehavior: Clip.hardEdge,
                              padding: EdgeInsets.all(horizontalSpacing / 2),
                              child: const Icon(
                                Icons.person,
                                color: AppColors.white,
                                size: 40,
                              ),
                            ),
                          ),
                          generalBox,
                          Center(
                            child: Container(
                              padding: generalPadding,
                              decoration: cardDecoration(withShadow: true),
                              child: Column(
                                children: [
                                  Text(
                                    'Your balance',
                                    style: tStyles['black18'],
                                  ),
                                  Text(
                                    'AED ${controller.userData['credit']}',
                                    style: tStyles['black32semi'],
                                  ),
                                  // generalSmallBox,
                                  // CupertinoButton(
                                  //   color: mainColor,
                                  //   padding: EdgeInsets.symmetric(
                                  //     vertical: verticalSpacing / 2,
                                  //     horizontal: horizontalSpacing,
                                  //   ),
                                  //   minSize: 0,
                                  //   onPressed: () {},
                                  //   child: const Text('Topup'),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          generalBox,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalSpacing),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Beneficiaries:',
                                  style: tStyles['black18semi'],
                                ),
                                CupertinoButton(
                                  onPressed: () {
                                    if (controller.numbers.length >= 5) {
                                      return showWarningMessage(
                                        message:
                                            'You can add maximum of 5 beneficiaries',
                                      );
                                    }
                                    Get.bottomSheet(
                                      AddBeneficiarySheet(),
                                      isScrollControlled: true,
                                    );
                                  },
                                  minSize: 0,
                                  padding: EdgeInsets.only(
                                    left: horizontalSpacing,
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDeviceHeight * 0.17,
                            child: controller.numbers.isEmpty
                                ? Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: verticalSpacing),
                                      child: Text(
                                        'Click on + to add beneficiary',
                                        style: tStyles['grey14'],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: controller.numbers.length,
                                    scrollDirection: Axis.horizontal,
                                    padding: generalPadding,
                                    itemBuilder: (context, index) {
                                      Map item = controller.numbers[index];
                                      return GestureDetector(
                                        onLongPress: () {
                                          Get.dialog(
                                            CupertinoAlertDialog(
                                              title: const Text(
                                                  'Delete beneficiary'),
                                              actions: [
                                                CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  onPressed: () {
                                                    controller.deleteNumber(
                                                        numberId:
                                                            item[kContactId]);
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                CupertinoDialogAction(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: kDeviceWidth * 0.33,
                                          decoration:
                                              cardDecoration(withShadow: true),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: horizontalSpacing / 4,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: verticalSpacing / 2,
                                            horizontal: horizontalSpacing / 2,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  item[kNickname],
                                                  style:
                                                      tStyles['primary16bold'],
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  formatPhoneNumber(
                                                      item[kPhoneNumber]),
                                                  style: tStyles['black16'],
                                                ),
                                              ),
                                              CupertinoButton(
                                                color: AppColors.accent,
                                                minSize: 0,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                  horizontal: 8,
                                                ),
                                                onPressed: () {
                                                  // controller.didReachLimit(
                                                  //     contactId: item['contactId'],
                                                  //     valueToBeAdded: 20);
                                                  // return;
                                                  consoleLogPretty(
                                                      controller.numbers);
                                                  Get.bottomSheet(
                                                    RechargeSheet(
                                                      number:
                                                          item[kPhoneNumber],
                                                      id: item[kContactId],
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Recharge',
                                                  style: tStyles['white14semi'],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
