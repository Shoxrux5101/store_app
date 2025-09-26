import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const AccountItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
        ],
      ),
    );
  }
}
