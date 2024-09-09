import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/theme/theme_colors.dart';
import 'package:flutter/cupertino.dart';

class FullWidthButton extends StatelessWidget {
  const FullWidthButton({
    super.key,
    this.text = '',
    this.onPress,
    this.isOutline = false,
    this.isDisabled = false,
  });
  final String text;
  final void Function()? onPress;
  final bool isOutline;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    Function()? onButtonPress;
    if (isDisabled) {
      onButtonPress = null;
    } else {
      onButtonPress = onPress;
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: onButtonPress,
      color: isOutline ? null : AppColors.accent,
      disabledColor: AppColors.grey,
      borderRadius: BorderRadius.circular(kDeviceWidth),
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDeviceWidth),
          border: isOutline
              ? Border.all(
                  color:
                      onButtonPress == null ? AppColors.grey : AppColors.accent,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing * 0.75,
          horizontal: horizontalSpacing,
        ),
        width: kDeviceWidth,
        alignment: Alignment.center,
        child: Text(
          text,
          style: isOutline
              ? onButtonPress == null
                  ? tStyles['grey14mid']
                  : tStyles['primary14mid']
              : tStyles['white16bold'],
        ),
      ),
    );
  }
}
