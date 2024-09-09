import 'dart:ui';

import 'package:jamal_ed/ui/theme/theme_colors.dart';
import 'package:flutter/material.dart';

BoxDecoration cardDecoration({
  Color? color,
  BorderRadius? borderRadius,
  bool withShadow = false,
}) =>
    BoxDecoration(
      color: color ?? AppColors.shapeBackground,
      boxShadow: withShadow
          ? [
              BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  color: AppColors.black.withOpacity(0.1))
            ]
          : null,
      borderRadius: borderRadius ?? BorderRadius.circular(horizontalSpacing),
    );
BoxDecoration circleDecoration({Color? color}) => BoxDecoration(
      color: color ?? AppColors.shapeBackground,
      shape: BoxShape.circle,
    );

SizedBox generalBox = SizedBox(
  height: verticalSpacing,
  width: horizontalSpacing,
);

SizedBox generalSmallBox = SizedBox(
  height: verticalSpacing / 2,
  width: horizontalSpacing / 2,
);
// General Spacing

final double horizontalSpacing = kDeviceWidth * 0.05;
final double verticalSpacing = kDeviceHeight * 0.02;

// Widgets Measures

final double fullWidthButtonHeight = kDeviceHeight * 0.065;
final double shaderHeight = kDeviceHeight * 0.75;

final generalPadding = EdgeInsets.symmetric(
  vertical: verticalSpacing,
  horizontal: horizontalSpacing,
);

final inputPadding = EdgeInsets.symmetric(
  vertical: verticalSpacing / 2,
  horizontal: horizontalSpacing,
);

const Duration generalDuration = Duration(milliseconds: 400);

final generalRadius = BorderRadius.circular(horizontalSpacing);

double pixelRatio = window.devicePixelRatio;

/// Size in physical pixels
Size physicalScreenSize = window.physicalSize;
double physicalWidth = physicalScreenSize.width;
double physicalHeight = physicalScreenSize.height;

/// Size in logical pixels
Size logicalScreenSize = window.physicalSize / pixelRatio;
final double screenRatio = (logicalScreenSize.height / logicalScreenSize.width);
// ignore: avoid_bool_literals_in_conditional_expressions
bool isThereSystemNav = screenRatio < 19.1 / 9 ? true : false;
double heightToBeAdded() {
  if (screenRatio >= 2.16) {
    return 0;
  } else {
    final double newSize = 2.16 * kDeviceWidth;
    return newSize - logicalScreenSize.height;
  }
}

///  ignore: duplicate_ignore
double kDeviceWidth = logicalScreenSize.width;
double kDeviceHeight = logicalScreenSize.height;
double kResponsiveDeviceHeight = (isThereSystemNav)
    ? logicalScreenSize.height + heightToBeAdded()
    : logicalScreenSize.height;
