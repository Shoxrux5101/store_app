import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/home/widgets/custom_bottom_nav_bar.dart';

import '../../../core/routes/routes.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Routes.homePage,
    Routes.searchPage,
    Routes.savedPage,
    Routes.cartPage,
    Routes.accountPage,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(_routes[index]);
        },
      ),
    );
  }
}
