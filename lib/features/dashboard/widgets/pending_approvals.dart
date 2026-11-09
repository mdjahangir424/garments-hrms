
import 'package:flutter/material.dart';
import 'panel.dart';

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
      child: Column(
        children: approvals.asMap().entries.map((entry) {
          final index = entry.key;
          final approval = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: const Color(0xFFEFF6FF),
                  child: Text(
                    approval['name']![0],
                    style: const TextStyle(
                      color: Color(0xFF2563EB),
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
                        approval['name']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${approval['type']} • ${approval['department']}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        approval['date']!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => onApproval(index, 'Declined'),
                  child: const Text(
                    'Decline',
                    style: TextStyle(
                      color: Color(0xFFDC2626),
                      fontSize: 11,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onApproval(index, 'Approved'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                  ),
                  child: const Text(
                    'Approve',
                    style: TextStyle(fontSize: 11),
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
