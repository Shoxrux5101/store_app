import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSection extends StatelessWidget {
  final String googleText;
  final String facebookText;
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;
  final VoidCallback? onLoginTap;

  const SocialSection({
    super.key,
    this.googleText = "Sign Up With Google",
    this.facebookText = "Sign Up With Facebook",
    this.onGoogleTap,
    this.onFacebookTap,
    this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Container(width: 160, height: 1, color: const Color(0xFFE6E6E6)),
            const SizedBox(width: 10),
            const Text(
              "Or",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080),
              ),
            ),
            const SizedBox(width: 10),
            Container(width: 160, height: 1, color: const Color(0xFFE6E6E6)),
          ],
        ),
        const SizedBox(height: 24),

        GestureDetector(
          onTap: onGoogleTap,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: const Color(0xFFCCCCCC),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/logos_google.svg"),
                const SizedBox(width: 5),
                Text(
                  googleText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        GestureDetector(
          onTap: onFacebookTap,
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF1877F2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/logos_facebook.svg"),
                const SizedBox(width: 5),
                Text(
                  facebookText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
