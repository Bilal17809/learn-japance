import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_japan/core/theme/app_color.dart';

final BoxDecoration linedocation=BoxDecoration(
  color: Color(0xFFF4C892), // same tone as your design
  borderRadius: BorderRadius.circular(2), // rounded ends
);
final BoxDecoration GridViewdocation= BoxDecoration(
  color: appwhite,
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      color: textcolor,
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ],
);
final BoxDecoration textdocation=BoxDecoration(
  color: iocnbgcolor,
  shape: BoxShape.circle,
);