import 'package:flutter/material.dart';

class BlobShape1 extends StatelessWidget {
  const BlobShape1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: BlobClipper(),
        child: Container(
          width: 200,
          height: 200,
          color: const Color(0xFFF4C892), // peach-like color
        ),
      ),
    );
  }
}

class BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width, size.height * 0.1,
        size.width * 0.9, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.8, size.height, size.width * 0.3, size.height);
    path.quadraticBezierTo(
        0, size.height * 0.8, size.width * 0.2, size.height * 0.2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
