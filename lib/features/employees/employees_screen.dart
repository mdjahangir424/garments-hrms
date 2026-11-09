
import 'package:flutter/material.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  static const Color primary = Color(0xFF2563EB);

  final List<Map<String, String>> employees = [
    {
      'id': 'EMP-001',
      'name': 'Rahim Ahmed',
      'department': 'Sewing',
      'designation': 'Operator',
      'status': 'Active',
    },
    {
      'id': 'EMP-002',
      'name': 'Nusrat Jahan',
      'department': 'Quality',
      'designation': 'Quality Inspector',
      'status': 'Active',
    },
    {
      'id': 'EMP-003',
      'name': 'Karim Uddin',
      'department': 'Finishing',
      'designation': 'Supervisor',
      'status': 'Inactive',
    },
  ];

  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredEmployees = employees.where((employee) {
      if (selectedFilter == 'All') return true;
      return employee['status'] == selectedFilter;
    }).toList();

    final activeCount = employees
        .where((e) => e['status'] == 'Active')
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Employees',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172554),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Manage your workforce and employee information.',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),

            LayoutBuilder(
              builder: (context, constraints) {
                final columns =
                    constraints.maxWidth > 600 ? 2 : 1;

                return GridView.count(
                  crossAxisCount: columns,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio:
                      columns == 1 ? 3.2 : 2.5,
                  children: [
                    _summaryCard(
                      'Total Employees',
                      '${employees.length}',
                      Icons.groups_rounded,
                      primary,
                    ),
                    _summaryCard(
                      'Active Employees',
                      '$activeCount',
                      Icons.verified_user_rounded,
                      const Color(0xFF16A34A),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: const Color(0xFFE8EDF5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 12,
                    spacing: 12,
                    children: [
                      const Text(
                        'Employee List',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF172554),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 17),
                        label: const Text('Add Employee'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  DropdownButtonFormField<String>(
                    value: selectedFilter,
                    decoration: const InputDecoration(
                      labelText: 'Employee Status',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: ['All', 'Active', 'Inactive']
                        .map((value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedFilter = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  ...filteredEmployees.map(_employeeCard),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _employeeCard(Map<String, String> employee) {
    final isActive = employee['status'] == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFDBEAFE),
            child: Text(
              employee['name']!
                  .split(' ')
                  .map((part) => part[0])
                  .take(2)
                  .join(),
              style: const TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${employee['id']} • ${employee['department']}',
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
                Text(
                  employee['designation']!,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              employee['status']!,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF15803D)
                    : const Color(0xFF64748B),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
