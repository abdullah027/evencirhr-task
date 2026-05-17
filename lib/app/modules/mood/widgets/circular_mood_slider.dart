import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularMoodSlider extends StatelessWidget {
  final double size;
  final double value;
  final Function(double) onChanged;
  final Widget centerChild;

  const CircularMoodSlider({
    super.key,
    required this.size,
    required this.value,
    required this.onChanged,
    required this.centerChild,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final box = context.findRenderObject() as RenderBox;
        final center = box.size.center(Offset.zero);
        final position = details.localPosition - center;
        double angle = atan2(position.dy, position.dx);

        double normalized = (angle + pi) / (2 * pi);
        onChanged(normalized);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _MoodSliderPainter(value: value),
          ),
          SizedBox(
            width: size * 0.44,
            height: size * 0.44,
            child: centerChild,
          ),
        ],
      ),
    );
  }
}

class _MoodSliderPainter extends CustomPainter {
  final double value;

  _MoodSliderPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final strokeWidth = 32.0.w;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          Color(0xFFA6E3FF),
          Color(0xFFF99955),
          Color(0xFF6EB9AD),
          Color(0xFFC9BBEF),
          Color(0xFFA6E3FF),
        ],
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawArc(rect, 0, 2 * pi, false, paint);

    final dividerPaint = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..strokeWidth = 2.0.w;

    for (int i = 0; i < 12; i++) {
      final angle = i * (2 * pi / 12);
      final startOffset = Offset(
        center.dx + (radius - strokeWidth) * cos(angle),
        center.dy + (radius - strokeWidth) * sin(angle),
      );
      final endOffset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(startOffset, endOffset, dividerPaint);
    }

    final handleAngle = (value * 2 * pi) - pi;
    final handlePos = Offset(
      center.dx + (radius - strokeWidth / 2) * cos(handleAngle),
      center.dy + (radius - strokeWidth / 2) * sin(handleAngle),
    );

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.14)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 6.r);
    canvas.drawCircle(handlePos + Offset(0, 2.h), 26.r, shadowPaint);

    final outerRimPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(handlePos, 24.r, outerRimPaint);

    final innerFillPaint = Paint()
      ..color = const Color(0xFFEAF9F6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(handlePos, 21.r, innerFillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
