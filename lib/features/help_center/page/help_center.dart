import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/chat/page/chat_page.dart';
import 'package:store_app/features/help_center/widgets/help_item.dart';

import '../../../core/routes/routes.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Help Center'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/Bell.svg'),
            onPressed: () {
              context.push(Routes.notification);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          spacing: 14,
          children: [
            Divider(),
            GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));},
                child: HelpItem(
                icon: "assets/icons/Headphones.svg", text: "Customer Service")),
            HelpItem(icon: "assets/icons/Whatsapp.svg", text: "Whatsapp"),
            HelpItem(icon: "assets/icons/Card.svg", text: "Website"),
            HelpItem(
                icon: "assets/icons/Facebook.svg", text: "Customer Service"),
            HelpItem(
                icon: "assets/icons/Twitter.svg", text: "Customer Service"),
            HelpItem(
                icon: "assets/icons/Instagram.svg", text: "Customer Service"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}

