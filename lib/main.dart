
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/dashboard/dashboard_screen.dart';

void main() {
  runApp(const GarmentsHRMSApp());
}

class GarmentsHRMSApp extends StatelessWidget {
  const GarmentsHRMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garments HRMS',
      theme: AppTheme.lightTheme,
      home: const DashboardScreen(),
    );
  }
}
