import 'package:go_router/go_router.dart';

import '../features/dashboard/dashboard_screen.dart';
import 'app_config.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.dashboard,
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => AppRoutes.dashboard,
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.employees,
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
    errorBuilder: (context, state) => const DashboardScreen(),
  );
}
