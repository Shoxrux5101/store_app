import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 4; i++) {
      final path = Path();
      path.moveTo(0, 60.0 + i * 35);
      path.quadraticBezierTo(
        size.width * 0.4,
        0.0 + i * 25,
        size.width,
        400.0 + i * 45,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}