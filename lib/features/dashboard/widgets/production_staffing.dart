
import 'package:flutter/material.dart';
import 'panel.dart';

class ProductionStaffing extends StatelessWidget {
  const ProductionStaffing({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = [
      {
        'name': 'Sewing Line 01',
        'present': '42',
        'total': '50',
        'progress': 0.84,
      },
      {
        'name': 'Sewing Line 02',
        'present': '38',
        'total': '45',
        'progress': 0.84,
      },
      {
        'name': 'Quality Control',
        'present': '18',
        'total': '20',
        'progress': 0.90,
      },
      {
        'name': 'Finishing',
        'present': '25',
        'total': '30',
        'progress': 0.83,
      },
    ];

    return Panel(
      title: 'Production Line Staffing',
      child: Column(
        children: departments.map((department) {
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
                        department['name'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${department['present']} / ${department['total']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE8EDF5),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF2563EB),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
