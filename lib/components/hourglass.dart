import 'package:flutter/cupertino.dart';
import 'package:focus_bits/constants.dart';
import 'dart:math';

class Hourglass extends StatefulWidget {
  const Hourglass({Key? key, required this.progress}) : super(key: key);

  final double progress;

  @override
  State<Hourglass> createState() => _HourglassState();
}

Animation<double>? animation;
AnimationController? controller;

class _HourglassState extends State<Hourglass> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      height: 300,
      child: Center(
        child: CustomPaint(
          painter: HourglassPainter(progress: widget.progress),
        ),
      ),
    );
  }
}

class HourglassPainter extends CustomPainter {
  HourglassPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paintStroke = Paint()
      ..color = kPrimaryColor
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final paintFill = Paint()
      ..color = kPrimaryColor
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final paintFillBG = Paint()
      ..color = kBackgroundColor // kBackgroundColor
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    // Upper sand
    canvas.drawArc(
        Rect.fromCenter(center: const Offset(0, -100), width: 150, height: 200),
        0,
        pi,
        true,
        paintFill);

    canvas.drawRect(
        Rect.fromLTWH(-75, -100, 150, 100 - progress * 100), paintFillBG);
    // Upper glass
    canvas.drawArc(
        Rect.fromCenter(center: const Offset(0, -100), width: 150, height: 200),
        0,
        pi,
        true,
        paintStroke);

    // Lower sand
    canvas.drawArc(
        Rect.fromCenter(
            center: const Offset(0, 100),
            width: 150,
            height: 200 - progress * 200),
        0,
        -pi,
        true,
        paintFill);

    // Lower glass
    canvas.drawArc(
        Rect.fromCenter(center: const Offset(0, 100), width: 150, height: 200),
        0,
        -pi,
        true,
        paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
