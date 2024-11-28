import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: RadialSlider(
            maxValue: 3,
            minValue: 1,
          ),
        ),
      ),
    );
  }
}

class RadialSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;

  const RadialSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
  });

  @override
  State<RadialSlider> createState() => _RadialSliderState();
}

double _currentAngle = -3 * math.pi / 4;

class _RadialSliderState extends State<RadialSlider> {
  double _currentValue = 1; // Start at level 1
  Offset _center = Offset.zero;

  final double _radius = 332;
  final double _strokeWidth = 10;

  // Define angles for each level (90 degrees divided by 3)
  final double level1Angle = -math.pi; // Start angle for level 1
  final double level2Angle = -3 * math.pi / 4; // Middle angle for level 2
  final double level3Angle = -math.pi / 2; // End angle for level 3

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: CustomPaint(
        size: Size(_radius * 2 + _strokeWidth, _radius * 2 + _strokeWidth),
        painter: RadialSliderPainter(
          minValue: widget.minValue,
          maxValue: widget.maxValue,
          currentValue: _currentValue,
          currentAngle: _currentAngle,
          strokeWidth: _strokeWidth,
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    _center = Offset(_radius + _strokeWidth / 2, _radius + _strokeWidth / 2);
    _updateValue(details.localPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _updateValue(details.localPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _snapToClosestLevel();
  }

  void _updateValue(Offset localPosition) {
    final dx = localPosition.dx - _center.dx;
    final dy = localPosition.dy - _center.dy;
    _currentAngle = math.atan2(dy, dx);

    // Limit the angle to the upper-left 90 degrees (from -π to -π/2)
    _currentAngle = _currentAngle.clamp(level1Angle, level3Angle);

    setState(() {
      _currentValue = _angleToValue(_currentAngle);
    });
  }

  double _angleToValue(double angle) {
    // Snap to specific levels based on the angle
    if ((angle - level1Angle).abs() < math.pi / 12) return 1;
    if ((angle - level2Angle).abs() < math.pi / 12) return 2;
    if ((angle - level3Angle).abs() < math.pi / 12) return 3;

    // Fallback for continuous sliding
    return 1 +
        ((angle + math.pi) / (math.pi / 2)) *
            (widget.maxValue - widget.minValue);
  }

  void _snapToClosestLevel() {
    // Snap to the closest of level1, level2, or level3
    if ((_currentAngle - level1Angle).abs() <=
            (_currentAngle - level2Angle).abs() &&
        (_currentAngle - level1Angle).abs() <=
            (_currentAngle - level3Angle).abs()) {
      setState(() {
        _currentAngle = level1Angle;
        _currentValue = 1;
      });
    } else if ((_currentAngle - level2Angle).abs() <=
        (_currentAngle - level3Angle).abs()) {
      setState(() {
        _currentAngle = level2Angle;
        _currentValue = 2;
      });
    } else {
      setState(() {
        _currentAngle = level3Angle;
        _currentValue = 3;
      });
    }
  }
}

class RadialSliderPainter extends CustomPainter {
  final double minValue;
  final double maxValue;
  final double currentValue;
  final double currentAngle;
  final double strokeWidth;

  RadialSliderPainter({
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.currentAngle,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - strokeWidth) / 2;

    // Background track for the 90-degree section
    final trackPaint = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Active track for the 90-degree section
    final activePaint = Paint()
      ..shader = SweepGradient(
        colors: const [
          Color.fromARGB(255, 180, 17, 17),
          Colors.deepPurpleAccent,
        ],
        startAngle: -math.pi,
        endAngle: -math.pi / 2,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Thumb paint
    final thumbPaint = Paint()..color = Colors.deepPurpleAccent;

    // Draw the background track (90 degrees only)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi,
      math.pi / 2,
      false,
      trackPaint,
    );

    // Draw the active arc up to the current angle within 90 degrees
    final sweepAngle = (_currentAngle + math.pi).clamp(0.0, math.pi / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi,
      sweepAngle,
      false,
      activePaint,
    );

    // Draw the thumb
    final thumbPos = Offset(
      center.dx + radius * math.cos(currentAngle),
      center.dy + radius * math.sin(currentAngle),
    );
    // canvas.drawCircle(thumbPos, strokeWidth * 4, thumbPaint);
    // Define paint properties
    final paint = Paint()
      ..color = Colors.deepPurpleAccent // Change color as needed
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    // Define the rounded square with a given radius for corners
    final rect = Rect.fromLTWH(
      center.dx + radius * math.cos(currentAngle) - strokeWidth * 2,
      center.dy + radius * math.sin(currentAngle) - strokeWidth * 2,
      strokeWidth * 4,
      strokeWidth * 4,
    );

    // Define the border radius
    final borderRadius = BorderRadius.circular(20); // Adjust as needed
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(15));

    // Draw the rounded square on the canvas
    canvas.drawRRect(rrect, paint);
    // Load the icon
    final icon = Icons.open_in_full_rounded; // Change to the desired icon
    final textPainterIcon = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: strokeWidth * 2, // Adjust size as needed
          fontFamily: icon.fontFamily,
          color: Colors.white, // Change color as needed
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainterIcon.layout();
    textPainterIcon.paint(
      canvas,
      Offset(
        center.dx + radius * math.cos(currentAngle) - textPainterIcon.width / 2,
        center.dy +
            radius * math.sin(currentAngle) -
            textPainterIcon.height / 2,
      ),
    );

    // Draw current value text
    final textSpan = TextSpan(
      text: '${currentValue.toInt()}\nLevel',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(radius * 0.4, radius * 4),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
