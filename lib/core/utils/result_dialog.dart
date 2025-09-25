import 'package:flutter/material.dart';
import '/core/constants/constants.dart';
import '/core/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class ResultDialog {
  static void show({
    required BuildContext context,
    required String message,
    required String lottieAsset,
    Duration duration = const Duration(seconds: 5),
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Timer(duration, () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kBodyHp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: kElementGap,
              children: [
                Lottie.asset(
                  lottieAsset,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: titleSmallStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
