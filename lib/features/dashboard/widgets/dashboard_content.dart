import 'package:flutter/material.dart';

import 'factory_selector.dart';
import 'stat_card.dart';
import 'attendance_chart.dart';
import 'department_chart.dart';
import 'production_staffing.dart';
import 'pending_approvals.dart';

class DashboardContent extends StatelessWidget {
  final bool isMobile;
  final List<Map<String, String>> approvals;
  final Function(int, String) onApproval;

  const DashboardContent({
    super.key,
    required this.isMobile,
    required this.approvals,
    required this.onApproval,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HR Overview',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF172554),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Monitor your workforce and factory operations.',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none),
                ),
              if (!isMobile)
                const Text(
                  '08 Nov 2026',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          const FactorySelector(),
          const SizedBox(height: 22),

          LayoutBuilder(
            builder: (context, constraints) {
              final count = constraints.maxWidth > 1000
                  ? 4
                  : constraints.maxWidth > 550
                      ? 2
                      : 1;

              final cards = [
                const StatCard(
                  title: 'Total Workforce',
                  value: '2,450',
                  subtitle: 'Registered employees',
                  icon: Icons.groups_rounded,
                  color: Color(0xFF2563EB),
                ),
                const StatCard(
                  title: 'Present Today',
                  value: '2,284',
                  subtitle: '93.2% attendance',
                  icon: Icons.how_to_reg_rounded,
                  color: Color(0xFF16A34A),
                ),
                const StatCard(
                  title: 'Absent / On Leave',
                  value: '166',
                  subtitle: '6.8% of workforce',
                  icon: Icons.event_busy_rounded,
                  color: Color(0xFFEA580C),
                ),
                const StatCard(
                  title: 'Overtime Hours',
                  value: '384',
                  subtitle: 'Hours recorded today',
                  icon: Icons.schedule_rounded,
                  color: Color(0xFF7C3AED),
                ),
              ];

              return GridView.count(
                crossAxisCount: count,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: count == 1 ? 3.2 : 1.8,
                children: cards,
              );
            },
          ),

          const SizedBox(height: 22),

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 700) {
                return const Column(
                  children: [
                    AttendanceChart(),
                    SizedBox(height: 16),
                    DepartmentChart(),
                  ],
                );
              }

              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: AttendanceChart(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: DepartmentChart(),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 22),
          const ProductionStaffing(),
          const SizedBox(height: 22),

          PendingApprovals(
            approvals: approvals,
            onApproval: onApproval,
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
