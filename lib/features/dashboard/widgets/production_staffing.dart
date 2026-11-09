
import 'package:flutter/material.dart';
import 'panel.dart';

class ProductionStaffing extends StatelessWidget {
  const ProductionStaffing({super.key});

  static const Color blue = Color(0xFF2563EB);

  final List<Map<String, dynamic>> departments = const [
    {
      'name': 'Sewing Line 1',
      'supervisor': 'Nasrin Akter',
      'present': '58 / 60',
      'staffing': '97%',
      'progress': 0.97,
      'style': 'STYLE-A',
      'status': 'On target',
    },
    {
      'name': 'Sewing Line 2',
      'supervisor': 'Abdul Karim',
      'present': '54 / 60',
      'staffing': '89%',
      'progress': 0.89,
      'style': 'STYLE-B',
      'status': 'Review',
    },
    {
      'name': 'Sewing Line 3',
      'supervisor': 'Sultana Razia',
      'present': '59 / 60',
      'staffing': '99%',
      'progress': 0.99,
      'style': 'STYLE-A',
      'status': 'On target',
    },
    {
      'name': 'Sewing Line 4',
      'supervisor': 'Rafiqul Islam',
      'present': '47 / 60',
      'staffing': '78%',
      'progress': 0.78,
      'style': 'STYLE-C',
      'status': 'Below target',
    },
    {
      'name': 'Finishing A',
      'supervisor': 'Mahmuda Khatun',
      'present': '41 / 42',
      'staffing': '95%',
      'progress': 0.95,
      'style': 'STYLE-A',
      'status': 'On target',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Production Line Staffing',
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          }

          return _buildDesktopLayout();
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Present vs. required operators, today',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 650,
            child: Column(
              children: [
                _tableHeader(),
                const Divider(
                  height: 1,
                  color: Color(0xFFE8EDF5),
                ),
                ...departments.map(_desktopRow),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _tableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Line', style: _headerStyle),
          ),
          Expanded(
            flex: 2,
            child: Text('Present / Target', style: _headerStyle),
          ),
          Expanded(
            flex: 2,
            child: Text('Staffing', style: _headerStyle),
          ),
          Expanded(
            flex: 2,
            child: Text('Running Style', style: _headerStyle),
          ),
          Expanded(
            flex: 2,
            child: Text('Status', style: _headerStyle),
          ),
        ],
      ),
    );
  }

  Widget _desktopRow(Map<String, dynamic> item) {
    final progress = item['progress'] as double;
    final status = item['status'] as String;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8EDF5),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supervisor: ${item['supervisor']}',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item['present'],
              style: const TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFE8EDF5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress < 0.80
                            ? const Color(0xFFDC6B45)
                            : const Color(0xFF16858B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['staffing'],
                    style: const TextStyle(fontSize: 9),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Style [${item['style']}]',
              style: const TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
            flex: 2,
            child: _statusLabel(status),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Present vs. required operators, today',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),
        ...departments.map((department) {
          final progress = department['progress'] as double;

          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        department['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      department['present'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Supervisor: ${department['supervisor']}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE8EDF5),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      blue,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${department['staffing']} • ${department['status']}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _statusLabel(String status) {
    final Color color;
    final Color background;

    if (status == 'Review') {
      color = const Color(0xFFB7791F);
      background = const Color(0xFFFEF3C7);
    } else if (status == 'Below target') {
      color = const Color(0xFFB45335);
      background = const Color(0xFFFCE8DF);
    } else {
      color = const Color(0xFF16858B);
      background = const Color(0xFFDDF4F1);
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

const TextStyle _headerStyle = TextStyle(
  fontSize: 10,
  color: Color(0xFF64748B),
  fontWeight: FontWeight.w600,
);
