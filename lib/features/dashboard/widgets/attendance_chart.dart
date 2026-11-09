
import 'package:flutter/material.dart';
import 'panel.dart';

class AttendanceChart extends StatelessWidget {
  const AttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Attendance Trend',
      child: SizedBox(
        height: 210,
        width: double.infinity,
        child: CustomPaint(
          painter: AttendancePainter(),
        ),
      ),
    );
  }
}

class AttendancePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE8EDF5)
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final linePaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final points = [
      Offset(size.width * 0.02, size.height * 0.70),
      Offset(size.width * 0.18, size.height * 0.55),
      Offset(size.width * 0.34, size.height * 0.62),
      Offset(size.width * 0.50, size.height * 0.35),
      Offset(size.width * 0.66, size.height * 0.43),
      Offset(size.width * 0.82, size.height * 0.20),
      Offset(size.width * 0.98, size.height * 0.28),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()
      ..color = const Color(0xFF2563EB);

    for (final point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
