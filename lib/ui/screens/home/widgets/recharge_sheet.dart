import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/ui/screens/home/controller.dart';
import 'package:jamal_ed/ui/theme/colors.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/widgets/button.dart';

class RechargeSheet extends StatelessWidget {
  const RechargeSheet({
    super.key,
    required this.number,
    required this.id,
  });
  final String number;
  final num id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Container(
        decoration: cardDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: generalPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recharge ${formatPhoneNumber(number)}',
                    style: tStyles['black18mid'],
                  ),
                  const Icon(CupertinoIcons.xmark),
                ],
              ),
            ),
            SizedBox(
              height: kDeviceHeight * 0.08,
              child: ListView.builder(
                itemCount: controller.topupOptions.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  vertical: verticalSpacing / 2,
                  horizontal: horizontalSpacing / 2,
                ),
                itemBuilder: (context, index) {
                  num currentNumber = controller.topupOptions[index];
                  bool isSelected = index == controller.selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      controller.updateSelectedIndex(index);
                    },
                    child: AnimatedContainer(
                      duration: Durations.short4,
                      decoration: cardDecoration(
                          withShadow: true,
                          color: isSelected ? mainColor : Colors.white),
                      margin: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing / 4,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalSpacing / 2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AED $currentNumber',
                            style: isSelected
                                ? tStyles['white14bold']
                                : tStyles['black14bold'],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // generalSmallBox,
            Row(
              children: [
                generalBox,
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'A charge of AED 1 will be applied for top-up transaction',
                      style: tStyles['primary12mid'],
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            //  generalBox,
            Padding(
              padding: generalPadding,
              child: FullWidthButton(
                text: 'Topup',
                onPress: () {
                  // controller.didReachLimit(
                  //   valueToBeAdded:
                  //       controller.topupOptions[controller.selectedIndex],
                  //   contactId: id,
                  // );
                  // return;
                  if (controller.didReachLimit(
                    valueToBeAdded:
                        controller.topupOptions[controller.selectedIndex],
                    contactId: id,
                  )) {
                  } else {
                    controller.topUp(
                      id,
                      controller.topupOptions[controller.selectedIndex],
                    );
                  }
                },
              ),
            ),
            generalBox,
          ],
        ),
      );
    });
  }
}
