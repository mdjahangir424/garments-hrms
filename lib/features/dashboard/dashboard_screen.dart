import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_config.dart';
import '../../core/widgets/sidebar.dart';
import '../employees/employees_screen.dart';
import 'widgets/dashboard_content.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color primary = const Color(0xFF2563EB);

  final List<Map<String, String>> approvals = [
    {
      'name': 'Rahim Ahmed',
      'type': 'Leave Request',
      'date': '08 Nov 2026',
      'department': 'Sewing',
    },
    {
      'name': 'Nusrat Jahan',
      'type': 'Overtime Request',
      'date': '08 Nov 2026',
      'department': 'Quality',
    },
    {
      'name': 'Karim Uddin',
      'type': 'Leave Request',
      'date': '07 Nov 2026',
      'department': 'Finishing',
    },
  ];

  void handleApproval(int index, String action) {
    final name = approvals[index]['name']!;

    setState(() {
      approvals.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name: $action (Demo only)'),
      ),
    );
  }

  void openRoute(String route, {required bool isMobile}) {
    context.go(route);

    if (isMobile) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmployeesRoute =
        GoRouterState.of(context).uri.path == AppRoutes.employees;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        return Scaffold(
          drawer: isMobile
              ? Drawer(
                  child: SafeArea(
                    child: Sidebar(
                      primary: primary,
                      employeesSelected: isEmployeesRoute,
                      onDashboardTap: () {
                        openRoute(
                          AppRoutes.dashboard,
                          isMobile: true,
                        );
                      },
                      onEmployeesTap: () {
                        openRoute(
                          AppRoutes.employees,
                          isMobile: true,
                        );
                      },
                    ),
                  ),
                )
              : null,
          appBar: isMobile
              ? AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    isEmployeesRoute ? 'Employees' : 'Garments HRMS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : null,
          body: Row(
            children: [
              if (!isMobile)
                SizedBox(
                  width: 245,
                  child: Sidebar(
                    primary: primary,
                    employeesSelected: isEmployeesRoute,
                    onDashboardTap: () {
                      openRoute(
                        AppRoutes.dashboard,
                        isMobile: false,
                      );
                    },
                    onEmployeesTap: () {
                      openRoute(
                        AppRoutes.employees,
                        isMobile: false,
                      );
                    },
                  ),
                ),
              Expanded(
                child: isEmployeesRoute
                    ? const EmployeesScreen()
                    : DashboardContent(
                        isMobile: isMobile,
                        approvals: approvals,
                        onApproval: handleApproval,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
