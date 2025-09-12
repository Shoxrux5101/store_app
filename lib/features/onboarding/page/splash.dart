import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/routes.dart';
import '../widgets/curved_liner_painter.dart';
import '../widgets/plus_painter.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _OnboardingState();
}

class _OnboardingState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.push(Routes.onboarding);
      }
    });
  }
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



