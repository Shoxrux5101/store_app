import 'package:go_router/go_router.dart';
import 'package:strore_app/core/routes/routes.dart';
import 'package:strore_app/features/onboarding/page/onboarding.dart';
import 'package:strore_app/features/sign_up/pages/sign_up.dart';

import '../../features/onboarding/page/splash.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
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
    ],
  );
}
