import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Stack(
        children: [
          CustomPaint(
            painter: CurvedLinesPainter(),
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
          ),

          Center(
            child: Container(
              width: 80,
              height: 80,
              color: Colors.transparent,
              child: CustomPaint(
                painter: PlusPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 4; i++) {
      final path = Path();
      path.moveTo(0, 80.0 + i * 25);
      path.quadraticBezierTo(
        size.width * 0.4,
        0.0 + i * 25,
        size.width,
        80.0 + i * 25,
      );
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

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
    path.arcToPoint(Offset(w * 0.65, h * 0.85),
        radius: Radius.circular(40), clockwise: false);
    path.lineTo(w * 0.65, h);
    path.lineTo(w * 0.5, h);
    path.lineTo(w * 0.5, h * 0.65);
    path.lineTo(0, h * 0.65);
    path.lineTo(0, h * 0.5);
    path.arcToPoint(Offset(w * 0.35, 0),
        radius: Radius.circular(40), clockwise: false);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
