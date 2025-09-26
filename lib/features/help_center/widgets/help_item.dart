import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';

class HelpItem extends StatelessWidget {
  final String icon;
  final String text;
  const HelpItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1,color: AppColors.grey2
          )
      ),
      child: Row(
        spacing: 12,
        children: [
          SvgPicture.asset(icon),
          Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }
}
