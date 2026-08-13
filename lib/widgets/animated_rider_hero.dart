import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedRiderHero extends StatefulWidget {
  final double height;

  const AnimatedRiderHero({super.key, this.height = 180});

  @override
  State<AnimatedRiderHero> createState() => _AnimatedRiderHeroState();
}

class _AnimatedRiderHeroState extends State<AnimatedRiderHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final val = _controller.value;

        // Smooth high-octane engine rumble (vertical) & forward motion (horizontal)
        final offsetY = sin(val * 2 * pi * 3) * 1.5;
        final offsetX = cos(val * 2 * pi * 1.5) * 2.0;

        return SizedBox(
          height: widget.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Aerodynamic Air Flow Lines Moving Front to Back (Right to Left)
              Positioned.fill(
                child: CustomPaint(
                  painter: _FrontToBackAirflowPainter(animValue: val),
                ),
              ),

              // 2. Clean Bike & Rider Image with Motion Vibration
              Transform.translate(
                offset: Offset(offsetX, offsetY),
                child: Image.asset(
                  'assets/images/biker_hero.png',
                  height: widget.height * 0.9,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'assets/biker_hero.png',
                      height: widget.height * 0.9,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FrontToBackAirflowPainter extends CustomPainter {
  final double animValue;

  _FrontToBackAirflowPainter({required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final airPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw continuous streamlines flowing from right (front of bike) to left (back of bike)
    void drawAirflowLine({
      required Path path,
      required Color color,
      required double strokeWidth,
      required double phaseOffset,
      required double streamLength,
    }) {
      final metrics = path.computeMetrics();
      for (final m in metrics) {
        final totalLen = m.length;
        final progress = (animValue + phaseOffset) % 1.0;
        final startDist = progress * totalLen;
        final endDist = min(startDist + streamLength, totalLen);

        if (startDist < totalLen) {
          airPaint
            ..color = color
            ..strokeWidth = strokeWidth
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
          canvas.drawPath(m.extractPath(startDist, endDist), airPaint);
        }
        if (startDist + streamLength > totalLen) {
          final wrapEnd = (startDist + streamLength) - totalLen;
          airPaint
            ..color = color
            ..strokeWidth = strokeWidth
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
          canvas.drawPath(m.extractPath(0, wrapEnd), airPaint);
        }
      }
    }

    // Streamline 1: High aerodynamic stream over helmet (Right to Left)
    final pathTop = Path()
      ..moveTo(w * 0.95, h * 0.12)
      ..cubicTo(w * 0.68, h * 0.05, w * 0.38, h * 0.05, w * 0.05, h * 0.18);
    drawAirflowLine(
      path: pathTop,
      color: AppTheme.electricCyan.withValues(alpha: 0.85),
      strokeWidth: 2.2,
      phaseOffset: 0.0,
      streamLength: 80,
    );

    // Streamline 2: Contour wrapping over Rider Helmet and Back
    final pathHelmet = Path()
      ..moveTo(w * 0.90, h * 0.28)
      ..cubicTo(w * 0.72, h * 0.15, w * 0.48, h * 0.10, w * 0.05, h * 0.32);
    drawAirflowLine(
      path: pathHelmet,
      color: Colors.white.withValues(alpha: 0.9),
      strokeWidth: 2.6,
      phaseOffset: 0.25,
      streamLength: 95,
    );

    // Streamline 3: Mid stream over Tank & Arms
    final pathMid = Path()
      ..moveTo(w * 0.92, h * 0.48)
      ..cubicTo(w * 0.68, h * 0.38, w * 0.42, h * 0.32, w * 0.05, h * 0.52);
    drawAirflowLine(
      path: pathMid,
      color: AppTheme.electricCyan.withValues(alpha: 0.7),
      strokeWidth: 2.0,
      phaseOffset: 0.50,
      streamLength: 70,
    );

    // Streamline 4: Lower stream under engine & rear wheel
    final pathLow = Path()
      ..moveTo(w * 0.90, h * 0.75)
      ..cubicTo(w * 0.65, h * 0.72, w * 0.35, h * 0.72, w * 0.05, h * 0.78);
    drawAirflowLine(
      path: pathLow,
      color: AppTheme.neonRed.withValues(alpha: 0.75),
      strokeWidth: 2.2,
      phaseOffset: 0.75,
      streamLength: 75,
    );

    // Ground Speed Asphalt Lines under tires (Right to Left motion)
    final groundY = h * 0.90;
    final groundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int g = 0; g < 6; g++) {
      final gProg = (animValue + g * 0.16) % 1.0;
      final gx1 = w * (1.1 - gProg * 1.2);
      final gx2 = gx1 - 45;
      groundPaint.color = AppTheme.electricCyan.withValues(alpha: (1.0 - gProg) * 0.4);
      canvas.drawLine(Offset(gx1, groundY), Offset(gx2, groundY), groundPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _FrontToBackAirflowPainter oldDelegate) {
    return oldDelegate.animValue != animValue;
  }
}
