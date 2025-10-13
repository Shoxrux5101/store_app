import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/routes.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Routes.homePage,
    Routes.searchPage,
    Routes.savedPage,
    Routes.cartPage,
    Routes.accountPage,
  ];

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
