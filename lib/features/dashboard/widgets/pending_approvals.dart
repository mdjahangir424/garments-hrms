
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
      final name = approval['name'] ?? '';
      final initial = name.isNotEmpty
          ? name[0].toUpperCase()
          : '?';

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE8EDF5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFEFF6FF),
                  child: Text(
                    initial,
                    style: const TextStyle(
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF172554),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 22),

            _mobileInfoRow(
              'Request Type',
              approval['type'] ?? '',
            ),
            const SizedBox(height: 10),

            _mobileInfoRow(
              'Department',
              approval['department'] ?? '',
            ),
            const SizedBox(height: 10),

            _mobileInfoRow(
              'Date',
              approval['date'] ?? '',
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () =>
                          onApproval(index, 'Approved'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF16858B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      child: const Text(
                        'Approve',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: OutlinedButton(
                      onPressed: () =>
                          onApproval(index, 'Declined'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            const Color(0xFF64748B),
                        side: const BorderSide(
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _mobileInfoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF64748B),
        ),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF172554),
          ),
        ),
      ),
    ],
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
