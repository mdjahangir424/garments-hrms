
import 'package:flutter/material.dart';
import 'panel.dart';

class DepartmentChart extends StatelessWidget {
  const DepartmentChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Workforce by Department',
      child: SizedBox(
        height: 210,
        child: Row(
          children: [
            Expanded(
              child: CustomPaint(
                size: const Size(150, 150),
                painter: DepartmentPainter(),
              ),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LegendItem(
                    color: Color(0xFF2563EB),
                    label: 'Sewing',
                    value: '45%',
                  ),
                  SizedBox(height: 12),
                  LegendItem(
                    color: Color(0xFF7C3AED),
                    label: 'Quality',
                    value: '25%',
                  ),
                  SizedBox(height: 12),
                  LegendItem(
                    color: Color(0xFF06B6D4),
                    label: 'Finishing',
                    value: '20%',
                  ),
                  SizedBox(height: 12),
                  LegendItem(
                    color: Color(0xFFF59E0B),
                    label: 'Other',
                    value: '10%',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DepartmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.shortestSide / 2;

    final sections = [
      {'color': const Color(0xFF2563EB), 'value': 45.0},
      {'color': const Color(0xFF7C3AED), 'value': 25.0},
      {'color': const Color(0xFF06B6D4), 'value': 20.0},
      {'color': const Color(0xFFF59E0B), 'value': 10.0},
    ];

    double startAngle = -1.5708;

    for (final section in sections) {
      final sweepAngle =
          (section['value'] as double) / 100 * 6.2832;

      final paint = Paint()
        ..color = section['color'] as Color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.28
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius * 0.78,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 11),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
