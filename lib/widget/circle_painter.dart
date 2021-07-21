import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final _circlePaint = Paint()
    ..color = const Color(0xff3ee8c7)
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _circlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
