import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    double w = size.width;
    double h = size.height;

    path.moveTo(w * 0.5, 0);
    path.lineTo(w * 0.65, 0);
    path.lineTo(w * 0.65, h * 0.35);
    path.lineTo(w, h * 0.35);
    path.lineTo(w, h * 0.5);
    path.arcToPoint(Offset(w * 0.55, h * 1),
        radius: Radius.circular(35), clockwise: false);
    path.lineTo(w * 0.65, h);
    path.lineTo(w * 0.35, h);
    path.lineTo(w * 0.35, h * 0.65);
    path.lineTo(0, h * 0.65);
    path.lineTo(0, h * 0.5);
    path.arcToPoint(Offset(w * 0.45, 0),
        radius: Radius.circular(40), clockwise: false);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
