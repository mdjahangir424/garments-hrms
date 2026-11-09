
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${approvals.length} pending',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9A6700),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (approvals.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'No pending approvals',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _mobileList();
                }

                return _desktopList();
              },
            ),
        ],
      ),
    );
  }

  Widget _desktopList() {
    return Column(
      children: approvals.asMap().entries.map((entry) {
        return _approvalRow(entry.key, entry.value);
      }).toList(),
    );
  }

  Widget _approvalRow(
    int index,
    Map<String, String> approval,
  ) {
    final name = approval['name'] ?? '';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

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
          CircleAvatar(
            radius: 13,
            backgroundColor: const Color(0xFFE8F1F8),
            child: Text(
              initial,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${approval['type']} · ${approval['date']} · ${approval['department']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          _actionButton(
            label: 'Approve',
            color: const Color(0xFF16858B),
            onPressed: () => onApproval(index, 'Approved'),
          ),
          const SizedBox(width: 4),
          _actionButton(
            label: 'Decline',
            color: const Color(0xFF64748B),
            outlined: true,
            onPressed: () => onApproval(index, 'Declined'),
          ),
        ],
      ),
    );
  }

  Widget _mobileList() {
    return Column(
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
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 5,
                      children: [
                        _actionButton(
                          label: 'Approve',
                          color: const Color(0xFF2563EB),
                          onPressed: () =>
                              onApproval(index, 'Approved'),
                        ),
                        _actionButton(
                          label: 'Decline',
                          color: const Color(0xFFDC2626),
                          outlined: true,
                          onPressed: () =>
                              onApproval(index, 'Declined'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _actionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
    bool outlined = false,
  }) {
    return SizedBox(
      height: 27,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: color,
                side: BorderSide(
                  color: const Color(0xFFE2E8F0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 7),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                label,
                style: const TextStyle(fontSize: 9),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                label,
                style: const TextStyle(fontSize: 9),
              ),
            ),
    );
  }
}
