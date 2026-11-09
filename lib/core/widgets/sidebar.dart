import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Color primary;

  const Sidebar({
    super.key,
    required this.primary,
  });

  Widget menuTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 12, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Color(0xFF94A3B8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget menuItem(
    IconData icon,
    String title, {
    bool selected = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFFEFF4FF)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          size: 20,
          color: selected
              ? primary
              : const Color(0xFF64748B),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: selected
                ? FontWeight.bold
                : FontWeight.w500,
            color: selected
                ? primary
                : const Color(0xFF475569),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 12, 24),
            child: Row(
              children: [
                Container(
                  height: 39,
                  width: 39,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.apartment_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Garments HRMS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Human Resource System',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          menuTitle('MAIN'),
          menuItem(
            Icons.dashboard_rounded,
            'Dashboard',
            selected: true,
          ),
          menuItem(Icons.people_outline, 'Employees'),
          menuItem(Icons.person_add_alt_1, 'Recruitment'),
          menuTitle('OPERATIONS'),
          menuItem(Icons.access_time_rounded, 'Attendance'),
          menuItem(Icons.event_available, 'Leave Management'),
          menuItem(Icons.factory_outlined, 'Production Lines'),
          menuItem(Icons.school_outlined, 'Training'),
          menuTitle('FINANCE & COMPLIANCE'),
          menuItem(Icons.payments_outlined, 'Payroll'),
          menuItem(Icons.assessment_outlined, 'Reports'),
          menuItem(Icons.verified_user_outlined, 'Compliance'),
          const Spacer(),
          const Divider(),
          menuItem(Icons.settings_outlined, 'Settings'),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFE0E7FF),
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ayesha Hasan',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'HR Manager',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_horiz,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
