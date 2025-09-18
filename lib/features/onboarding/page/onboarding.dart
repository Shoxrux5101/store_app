import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/button_onboarding.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ Scaffold(
        body: Stack(
          children: [
            Center(child: Image.asset('assets/images/element-onboardin.png')),
            Padding(
              padding: EdgeInsets.only(left: 24,right: 42,top: 59.h),
              child: Text(
                'Define yourself in your unique way.',
                maxLines: 4,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                  height: 0.8.h,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60,left: 70),
              child: Image.asset('assets/images/bolacha.png',),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 24,right: 24,bottom: 50),
          child: ButtonOnboarding(),
        ),
      ),
    ]
    );
  }
}
