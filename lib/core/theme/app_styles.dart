import 'package:flutter/material.dart';

/// Text
TextStyle headlineLargeStyle = const TextStyle(
  fontSize: 64,
  fontWeight: FontWeight.w700,
  shadows: kShadow,
);

TextStyle headlineMediumStyle = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

TextStyle headlineSmallStyle = const TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.w500,
);

TextStyle titleMediumStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle titleLargeStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

TextStyle titleSmallStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

TextStyle bodyLargeStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

TextStyle bodyMediumStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle bodySmallStyle = const TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

/// Shadows
const List<Shadow> kShadow = [
  Shadow(offset: Offset(3, 3), blurRadius: 4, color: Colors.black54),
];
