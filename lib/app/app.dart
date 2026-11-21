import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'app_router.dart';

class GarmentsHRMSApp extends StatelessWidget {
  const GarmentsHRMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Garments HRMS',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
