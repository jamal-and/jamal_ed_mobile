import 'package:jamal_ed/core/helpers/ui_helper.dart';
import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/ui/theme/colors.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

class CTextInput extends StatelessWidget {
  const CTextInput({
    super.key,
    this.hint,
    this.onChange,
    this.prefixIcon,
    this.maxLength = 200,
    this.isPassword = false,
    this.isSmall = false,
    this.controller,
    this.minLines,
    this.maxLines,
    this.inputType,
    this.suffix,
    this.suffixText,
    this.suffixStyle,
  });
  final String? hint;
  final void Function(String v)? onChange;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? suffixText;
  final int maxLength;
  final bool isPassword;
  final bool isSmall;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final TextInputType? inputType;
  final TextStyle? suffixStyle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: isPassword,
      minLines: minLines,
      keyboardType: inputType,
      onTapOutside: (event) {
        hideKeyboard();
      },
      maxLines: maxLines ?? 1,
      autocorrect: false,
      inputFormatters: [
        // if (TextInputType.number == inputType)
        //   FilteringTextInputFormatter.digitsOnly,
        if (TextInputType.number == inputType)
          MaskedInputFormatter('### ### ####',
              allowedCharMatcher: RegExp("^[0-9]"))
      ],
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: tStyles['grey14'],
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: mainColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalSpacing / 2,
          vertical: isSmall ? verticalSpacing / 2 : verticalSpacing,
        ),
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        counterText: '',
        prefixIconConstraints: const BoxConstraints(),
        isCollapsed: true,
      ),
      cursorColor: mainColor,
      maxLength: maxLength,
    );
  }
}
