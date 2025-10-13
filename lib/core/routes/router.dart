import 'package:go_router/go_router.dart';
import 'package:store_app/core/routes/routes.dart';
import 'package:store_app/features/account/pages/account_page.dart';
import 'package:store_app/features/address/page/address_page.dart';
import 'package:store_app/features/my_cart/pages/my_cart_page.dart';
import 'package:store_app/features/product_details/pages/product_detail_page.dart';
import 'package:store_app/features/review/pages/review_page.dart';
import 'package:store_app/features/saved/pages/saved_page.dart';
import 'package:store_app/features/search/pages/search_page.dart';
import '../../features/forgot_password/pages/forgot_password_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/login/pages/login_page.dart';
import '../../features/main/pages/main_shall.dart';
import '../../features/notification/pages/notification_page.dart';
import '../../features/onboarding/page/onboarding.dart';
import '../../features/onboarding/page/splash.dart';
import '../../features/sign_up/pages/sign_up.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.homePage,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: Routes.homePage, builder: (context, state) => HomePage()),
          GoRoute(path: Routes.searchPage, builder: (context, state) => SearchPage()),
          GoRoute(path: Routes.savedPage, builder: (context, state) => SavedPage()),
          GoRoute(path: Routes.cartPage, builder: (context, state) => MyCartScreen()),
          GoRoute(path: Routes.accountPage, builder: (context, state) => AccountPage()),
          GoRoute(path: Routes.addressPage, builder: (context, state) => AddressPage()),
          GoRoute(path: Routes.notification, builder: (context, state) => NotificationPage()),
        ],
      ),
      GoRoute(
        path: Routes.productDetail,
        builder: (context, state) {
          final productId = state.extra as int;
          return ProductDetailPage(productId: productId);
        },
      ),
      GoRoute(
        path: Routes.reviewPage,
        builder: (context, state) {
          final productId = state.extra as int;
          return ReviewPage(productId: productId);
        },
      ),
      GoRoute(path: Routes.splash, builder: (context, state) => Splash()),
      GoRoute(path: Routes.onboarding, builder: (context, state) => Onboarding()),
      GoRoute(path: Routes.signUp, builder: (context, state) => SignUp()),
      GoRoute(path: Routes.loginPage, builder: (context, state) => LoginPage()),
      GoRoute(path: Routes.forgotPage, builder: (context, state) => ForgotPasswordPage()),
    ],
  );
}
