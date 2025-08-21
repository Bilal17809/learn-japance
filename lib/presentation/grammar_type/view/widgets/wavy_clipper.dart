import 'package:flutter/material.dart';

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double notchRadius = 20;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
      size.width,
      size.height * 0.25,
      size.width,
      size.height * 0.4,
    );
    path.arcToPoint(
      Offset(size.width, size.height * 0.6),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.quadraticBezierTo(
      size.width,
      size.height * 0.75,
      size.width,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
