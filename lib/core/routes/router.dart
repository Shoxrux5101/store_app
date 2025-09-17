import 'package:go_router/go_router.dart';
import 'package:strore_app/core/routes/routes.dart';
import 'package:strore_app/features/forgot_password/pages/forgot_password_page.dart';
import 'package:strore_app/features/onboarding/page/onboarding.dart';
import 'package:strore_app/features/sign_up/pages/sign_up.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/login/pages/login_page.dart';
import '../../features/onboarding/page/splash.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.forgotPage,
    routes: [
      GoRoute(path: Routes.splash,
          builder: (context,state) {
            return Splash();
          }
      ),
      GoRoute(path: Routes.onboarding,
        builder: (context,state) {
          return Onboarding();
        }
      ),
      GoRoute(
          path: Routes.signUp,
          builder: (context,state) {
            return SignUp();
          }
      ),
      GoRoute(path: Routes.loginPage,
        builder: (context, state) {
        return LoginPage();
        }
      ),
      GoRoute(path: Routes.forgotPage,
        builder: (context, state) {
        return ForgotPasswordPage();
        }
      ),
      GoRoute(path: Routes.homePage,
        builder: (context, state) {
        return HomePage();
        }
      ),
    ],
  );
}
