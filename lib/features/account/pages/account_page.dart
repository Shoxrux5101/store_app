import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/account/pages/my_orders.dart';
import 'package:store_app/features/account/widgets/accoutn_item.dart';
import 'package:store_app/features/account/widgets/logout_dialog.dart';
import 'package:store_app/features/home/widgets/custom_bottom_nav_bar.dart';

import '../../../core/routes/routes.dart';
import '../../help_center/page/help_center.dart';
import '../../my_details/pages/my_details.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _currentIndex = 0;

  final List<String> _routes = [
    Routes.homePage,
    Routes.searchPage,
    Routes.savedPage,
    Routes.cartPage,
    Routes.accountPage,
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.notification);
            },
            icon: SvgPicture.asset('assets/icons/Bell.svg'),
          ),
        ],
      ),
      body: Column(
        spacing: 24,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Divider(),
                SizedBox(
                  height: 21,
                ),
                AccountItem(
                  iconPath: 'assets/icons/Box.svg',
                  title: "My Orders",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrders()),
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(
            thickness: 8,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 22,
              children: [
                AccountItem(
                  iconPath: 'assets/icons/Details.svg',
                  title: "My Details",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyDetails()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: Divider(),
                ),
                AccountItem(
                  iconPath: 'assets/icons/account-home.svg',
                  title: "Address Book",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyDetails()),
                    // );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: Divider(),
                ),
                AccountItem(
                  iconPath: 'assets/icons/Card.svg',
                  title: "Payment Methods",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyDetails()),
                    // );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: Divider(),
                ),
                AccountItem(
                  iconPath: 'assets/icons/account-bell.svg',
                  title: "Notifications",
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyDetails()),
                    // );
                  },
                ),
              ],
            ),
          ),
          Divider(thickness: 8,color:Colors.grey[300]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 22,
              children: [
                AccountItem(
                  iconPath: "assets/icons/Question.svg",
                  title: "FAQs",
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 33),
                  child: Divider(),
                ),
                AccountItem(
                  iconPath: 'assets/icons/Headphones.svg',
                  title: "Help Center",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpCenterPage()));
                  },
                ),
              ],
            ),
          ),
          Divider(thickness: 8,color:Colors.grey[300]),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){LogoutDialog.show(context);},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      SvgPicture.asset('assets/icons/Logout.svg',width: 24,height: 24,),
                      Text("Logout",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400,fontSize: 16),),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
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
