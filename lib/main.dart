
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        fontFamily: 'Arial',
      ),
      home: const DashboardScreen(),
    );
  }
}

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
      SnackBar(content: Text('$name: $action (Demo only)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        return Scaffold(
          drawer: isMobile
              ? Drawer(
                  child: SafeArea(
                    child: Sidebar(primary: primary),
                  ),
                )
              : null,
          appBar: isMobile
              ? AppBar(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Garments HRMS',
                    style: TextStyle(
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
                  child: Sidebar(primary: primary),
                ),
              Expanded(
                child: DashboardContent(
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

class Sidebar extends StatelessWidget {
  final Color primary;

  const Sidebar({super.key, required this.primary});

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

  Widget menuItem(IconData icon, String title,
      {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEFF4FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          size: 20,
          color: selected ? primary : const Color(0xFF64748B),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            color: selected ? primary : const Color(0xFF475569),
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
          menuItem(Icons.dashboard_rounded, 'Dashboard',
              selected: true),
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
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                  Expanded(flex: 3, child: AttendanceChart()),
                  SizedBox(width: 16),
                  Expanded(flex: 2, child: DepartmentChart()),
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

class FactorySelector extends StatelessWidget {
  const FactorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.factory_outlined,
            color: Color(0xFF2563EB),
            size: 21,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Factory',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Main Factory - Gazipur',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE8EDF5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(icon, color: color, size: 21),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172554),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const Panel({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE8EDF5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF172554),
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class AttendanceChart extends StatelessWidget {
  const AttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Attendance Trend',
      child: Column(
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: AttendancePainter(),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Mon', style: TextStyle(fontSize: 10)),
              Text('Tue', style: TextStyle(fontSize: 10)),
              Text('Wed', style: TextStyle(fontSize: 10)),
              Text('Thu', style: TextStyle(fontSize: 10)),
              Text('Fri', style: TextStyle(fontSize: 10)),
              Text('Sat', style: TextStyle(fontSize: 10)),
              Text('Sun', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

class AttendancePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final values = [0.70, 0.84, 0.76, 0.91, 0.82, 0.95, 0.89];

    final gridPaint = Paint()
      ..color = const Color(0xFFE9EEF5)
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = i * size.height / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final linePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    for (int i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final y = size.height * (1 - values[i]);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = const Color(0xFF2563EB);

    for (int i = 0; i < values.length; i++) {
      final x = i * size.width / (values.length - 1);
      final y = size.height * (1 - values[i]);
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant AttendancePainter oldDelegate) => false;
}

class DepartmentChart extends StatelessWidget {
  const DepartmentChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Workforce by Department',
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: CustomPaint(
              painter: DepartmentPainter(),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '2,450',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'Employees',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 15,
            runSpacing: 12,
            children: [
              LegendItem('Sewing', Color(0xFF2563EB)),
              LegendItem('Cutting', Color(0xFF16A34A)),
              LegendItem('Finishing', Color(0xFFF59E0B)),
              LegendItem('Others', Color(0xFF8B5CF6)),
            ],
          ),
        ],
      ),
    );
  }
}

class DepartmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final values = [0.48, 0.20, 0.18, 0.14];
    final colors = [
      const Color(0xFF2563EB),
      const Color(0xFF16A34A),
      const Color(0xFFF59E0B),
      const Color(0xFF8B5CF6),
    ];

    double start = -1.5708;
    final rect = Offset.zero & size;

    for (int i = 0; i < values.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.butt;

      final sweep = values[i] * 6.28318;
      canvas.drawArc(rect.deflate(10), start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant DepartmentPainter oldDelegate) => false;
}

class LegendItem extends StatelessWidget {
  final String title;
  final Color color;

  const LegendItem(this.title, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}

class ProductionStaffing extends StatelessWidget {
  const ProductionStaffing({super.key});

  @override
  Widget build(BuildContext context) {
    final lines = [
      ['Line 01', 'Sewing', '120', '112', 'Active'],
      ['Line 02', 'Sewing', '110', '105', 'Active'],
      ['Line 03', 'Cutting', '85', '78', 'Active'],
      ['Line 04', 'Finishing', '95', '82', 'Short Staff'],
    ];

    return Panel(
      title: 'Production Line Staffing',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 38,
          dataRowMinHeight: 45,
          dataRowMaxHeight: 50,
          columnSpacing: 35,
          columns: const [
            DataColumn(label: Text('Line')),
            DataColumn(label: Text('Department')),
            DataColumn(label: Text('Required')),
            DataColumn(label: Text('Present')),
            DataColumn(label: Text('Status')),
          ],
          rows: lines.map((line) {
            final active = line[4] == 'Active';

            return DataRow(
              cells: [
                DataCell(Text(line[0])),
                DataCell(Text(line[1])),
                DataCell(Text(line[2])),
                DataCell(Text(line[3])),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFFFEDD5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      line[4],
                      style: TextStyle(
                        fontSize: 10,
                        color: active
                            ? const Color(0xFF15803D)
                            : const Color(0xFFC2410C),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PendingApprovals extends StatelessWidget {
  final List<Map<String, String>> approvals;
  final Function(int, String) onApproval;

  const PendingApprovals({
    super.key,
    required this.approvals,
    required this.onApproval,
  });

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Pending Approvals',
      child: approvals.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('No pending approvals'),
              ),
            )
          : Column(
              children: List.generate(approvals.length, (index) {
                final item = approvals[index];

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFF1F5F9)),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final compact = constraints.maxWidth < 500;

                      return Flex(
                        direction: compact
                            ? Axis.vertical
                            : Axis.horizontal,
                        crossAxisAlignment: compact
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: compact ? 0 : 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item['type']} • ${item['department']}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  item['date']!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (compact) const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              OutlinedButton(
                                onPressed: () =>
                                    onApproval(index, 'Declined'),
                                child: const Text(
                                  'Decline',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              const SizedBox(width: 8),
                              FilledButton(
                                onPressed: () =>
                                    onApproval(index, 'Approved'),
                                child: const Text(
                                  'Approve',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
            ),
    );
  }
}
