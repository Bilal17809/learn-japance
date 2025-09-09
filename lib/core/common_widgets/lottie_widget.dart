import '../theme/theme.dart';
import '/core/constants/constants.dart';
import '/core/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class LottieWidget extends StatelessWidget {
  final String? assetPath;
  final String? message;
  const LottieWidget({super.key, this.message, this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.5,

          child: Lottie.asset(
            assetPath ?? Assets.searchError,
            width: context.screenWidth * 0.35,
          ),
        ),
        Text(message ?? 'No results found.', style: bodyLargeStyle),
      ],
    );
  }
}
