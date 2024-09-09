import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/ui/screens/home/controller.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/widgets/button.dart';
import 'package:jamal_ed/ui/widgets/inputs.dart';

class AddBeneficiarySheet extends StatelessWidget {
  AddBeneficiarySheet({
    super.key,
  });
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController =
      TextEditingController(text: '05');
  @override
  Widget build(BuildContext context) {
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
                  'Add Beneficiary',
                  style: tStyles['black18mid'],
                ),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.xmark)),
              ],
            ),
          ),
          generalBox,
          Padding(
            padding: generalPadding,
            child: Column(
              children: [
                CTextInput(
                  hint: 'Nickname',
                  maxLength: 20,
                  controller: nameController,
                ),
                generalBox,
                CTextInput(
                  hint: 'Phone Number',
                  inputType: const TextInputType.numberWithOptions(),
                  controller: numberController,
                  onChange: (v) {
                    if (!v.startsWith('05')) {
                      numberController.text = '05';
                      Get.find<HomeController>().update();
                    }
                  },
                ),
                generalBox,
                FullWidthButton(
                  text: 'Add',
                  onPress: () {
                    if (nameController.text.isEmpty) {
                      showWarningMessage(
                          message: 'Please enter a name for this beneficiray');
                      return;
                    }
                    if (numberController.text.replaceAll(' ', '').length < 10) {
                      showWarningMessage(
                          message: 'Please enter a valid phone number');
                      return;
                    }

                    Get.back();
                    Get.find<HomeController>().addNumber(
                      name: nameController.text,
                      number: numberController.text,
                    );
                  },
                ),
                generalBox,
                //  generalBox,
              ],
            ),
          )
        ],
      ),
    );
  }
}
