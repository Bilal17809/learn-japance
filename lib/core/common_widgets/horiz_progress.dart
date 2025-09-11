import '/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HorizontalProgress extends StatelessWidget {
  final int? totalSteps;
  final int currentStep;
  final Color? selectedColor;
  final Color? unselectedColor;

  const HorizontalProgress({
    super.key,
    required this.currentStep,
    this.totalSteps,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: totalSteps ?? 100,
      currentStep: currentStep,
      size: 8,
      padding: 0,
      selectedColor: selectedColor ?? AppColors.primary(context),
      unselectedColor: unselectedColor ?? AppColors.kWhite,
      roundedEdges: const Radius.circular(10),
    );
  }
}
