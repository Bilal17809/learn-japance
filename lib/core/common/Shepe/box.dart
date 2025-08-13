import 'package:flutter/material.dart';

class BlobShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFF4B73F), Color(0xFFFFE0A0), Color(0xFFEB9D2A)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));


    final path = Path()
      ..moveTo(size.width * 0.6, 0)
      ..quadraticBezierTo(
          size.width * 1.1, size.height * 0.02, size.width * 0.85, size.height * 0.65)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 1.05, size.width * 0.35, size.height * 0.95)
      ..quadraticBezierTo(
          -size.width * 0.3, size.height * 0.8, size.width * 0.01, size.height * 0.3)
      ..quadraticBezierTo(
          size.width * 0.25, size.height * 0.05, size.width * 0.6,0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BlobShapeWidget extends StatelessWidget {
  const BlobShapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: BlobShapePainter(),
    );
  }
}
