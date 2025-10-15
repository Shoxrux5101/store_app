import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/core/routes/routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/Bell.svg"),
          onPressed: () => context.push(Routes.notification),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
