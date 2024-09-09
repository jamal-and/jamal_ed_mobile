import 'package:jamal_ed/core/utils/global.dart';
import 'package:jamal_ed/ui/theme/decorations.dart';
import 'package:jamal_ed/ui/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: cardDecoration(),
      padding: generalPadding,
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minWidth: kDeviceWidth,
        minHeight: kDeviceHeight * 0.2,
      ),
      child: const RawLoading(),
    ); //.animate().scale(curve: Curves.easeOutBack);
  }
}

class RawLoading extends StatelessWidget {
  const RawLoading({
    super.key,
    this.loadingText,
  });

  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpinKitWaveSpinner(
          color: AppColors.primary,
          trackColor: AppColors.grey,
          size: horizontalSpacing * 3,
          waveColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
        generalSmallBox,
        FittedBox(
          fit: BoxFit.none,
          child: Text(
            loadingText ?? 'Loading',
            style: tStyles['black16'],
          ),
        )
      ],
    );
  }
}
