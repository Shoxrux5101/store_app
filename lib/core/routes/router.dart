import 'package:go_router/go_router.dart';
import 'package:store_app/core/routes/routes.dart';
import 'package:store_app/features/account/pages/account_page.dart';
import 'package:store_app/features/address/page/address_page.dart';
import 'package:store_app/features/card/pages/card_page.dart';
import 'package:store_app/features/my_cart/pages/my_cart_page.dart';
import 'package:store_app/features/product_details/pages/product_detail_page.dart';
import 'package:store_app/features/review/pages/review_page.dart';
import 'package:store_app/features/saved/pages/saved_page.dart';
import 'package:store_app/features/search/pages/search_page.dart';
import '../../features/forgot_password/pages/forgot_password_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/login/pages/login_page.dart';
import '../../features/notification/pages/notification_page.dart';
import '../../features/onboarding/page/onboarding.dart';
import '../../features/onboarding/page/splash.dart';
import '../../features/sign_up/pages/sign_up.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.homePage,
    // redirect: (){}, //kerakli funksiyalar uchun
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) {
          return Splash();
        },
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) {
          return Onboarding();
        },
      ),
      GoRoute(
        path: Routes.signUp,
        builder: (context, state) {
          return SignUp();
        },
      ),
      GoRoute(
        path: Routes.loginPage,
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: Routes.forgotPage,
        builder: (context, state) {
          return ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: Routes.homePage,
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: Routes.searchPage,
        builder: (context, state) {
          return SearchPage();
        },
      ),
      GoRoute(
        path: Routes.savedPage,
        builder: (context, state) {
          return SavedPage();
        },
      ),
      GoRoute(
        path: Routes.cartPage,
        builder: (context, state) {
          return MyCartScreen();
        },
      ),
      GoRoute(
        path: Routes.accountPage,
        name: "/account",
        builder: (context, state) {
          return AccountPage();
        },
      ),
      GoRoute(
        path: Routes.notification,
        builder: (context, state) {
          return NotificationPage();
        },
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
      GoRoute(
        path: Routes.addressPage,
        builder: (context, state) {
          return AddressPage();
        },
      ),
    ],
  );
}
