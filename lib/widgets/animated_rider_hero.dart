import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedRiderHero extends StatefulWidget {
  final double height;

  const AnimatedRiderHero({super.key, this.height = 140});

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
      duration: const Duration(milliseconds: 1200),
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
        return SizedBox(
          height: widget.height,
          width: double.infinity,
          child: CustomPaint(
            painter: _RiderPainter(
              animationValue: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _RiderPainter extends CustomPainter {
  final double animationValue;

  _RiderPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.48, size.height * 0.55);
    final wheelRadius = size.height * 0.24;
    final wheelDistance = size.width * 0.32;

    final rearWheelCenter = Offset(center.dx - wheelDistance * 0.45, center.dy + size.height * 0.12);
    final frontWheelCenter = Offset(center.dx + wheelDistance * 0.45, center.dy + size.height * 0.12);

    // 1. High Speed Neon Telemetry Streaks / Particle Lines (Flying Backwards)
    final streakPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 14; i++) {
      final lineY = size.height * (0.15 + (i * 0.05));
      final speedFactor = 1.0 + (i % 3) * 0.4;
      final startX = size.width * ((1.2 - (animationValue * speedFactor + i * 0.15)) % 1.4 - 0.2);
      final lineLength = 30.0 + (i % 4) * 15.0;

      streakPaint
        ..color = (i % 2 == 0 ? AppTheme.electricCyan : AppTheme.neonRed)
            .withValues(alpha: 0.25 + (i % 3) * 0.2)
        ..strokeWidth = 1.5 + (i % 2);

      canvas.drawLine(
        Offset(startX, lineY),
        Offset(startX - lineLength, lineY),
        streakPaint,
      );
    }

    // 2. Rear Wheel Exhaust Burnout Particles
    final particlePaint = Paint()..style = PaintingStyle.fill;
    for (int p = 0; p < 8; p++) {
      final progress = (animationValue + p * 0.125) % 1.0;
      final px = rearWheelCenter.dx - progress * 40;
      final py = rearWheelCenter.dy + (Random(p).nextDouble() * 12 - 6);
      particlePaint.color = AppTheme.neonRed.withValues(alpha: (1.0 - progress) * 0.7);
      canvas.drawCircle(Offset(px, py), 2.5 * (1.0 - progress * 0.5), particlePaint);
    }

    // 3. Spinning Wheels Function
    void drawSpinningWheel(Offset wheelCenter) {
      // Outer Tire
      final tirePaint = Paint()
        ..color = const Color(0xFF161A23)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8;
      canvas.drawCircle(wheelCenter, wheelRadius, tirePaint);

      // Neon Glowing Rim
      final rimPaint = Paint()
        ..color = AppTheme.electricCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);
      canvas.drawCircle(wheelCenter, wheelRadius - 4, rimPaint);

      // Spinning Spokes
      final spokePaint = Paint()
        ..color = AppTheme.electricCyan.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8;

      const spokeCount = 6;
      final rotationAngle = animationValue * 2 * pi * 3; // Fast rotation spin

      for (int i = 0; i < spokeCount; i++) {
        final angle = rotationAngle + (i * 2 * pi / spokeCount);
        final spokeX = wheelCenter.dx + (wheelRadius - 5) * cos(angle);
        final spokeY = wheelCenter.dy + (wheelRadius - 5) * sin(angle);
        canvas.drawLine(wheelCenter, Offset(spokeX, spokeY), spokePaint);
      }

      // Center Hub
      final hubPaint = Paint()..color = Colors.white;
      canvas.drawCircle(wheelCenter, 4, hubPaint);
    }

    drawSpinningWheel(rearWheelCenter);
    drawSpinningWheel(frontWheelCenter);

    // 4. Superbike Chassis Frame & Aero Fairing
    final chassisPath = Path();
    chassisPath.moveTo(rearWheelCenter.dx, rearWheelCenter.dy);
    chassisPath.lineTo(center.dx - 15, center.dy - 10); // Swingarm
    chassisPath.lineTo(center.dx - 30, center.dy - 28); // Tail cowl
    chassisPath.lineTo(center.dx, center.dy - 20); // Tank
    chassisPath.lineTo(center.dx + 25, center.dy - 22); // Clip-on handlebar area
    chassisPath.lineTo(center.dx + 45, center.dy - 15); // Windscreen / nose fairing
    chassisPath.lineTo(frontWheelCenter.dx, frontWheelCenter.dy); // Front fork

    final framePaint = Paint()
      ..color = const Color(0xFF2D3548)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(chassisPath, framePaint);

    // Aerodynamic Body Fairing (Red Racing Paint)
    final bodyPath = Path();
    bodyPath.moveTo(center.dx - 35, center.dy - 25);
    bodyPath.lineTo(center.dx + 5, center.dy - 28); // Fuel tank top
    bodyPath.lineTo(center.dx + 42, center.dy - 20); // Nose front
    bodyPath.lineTo(center.dx + 30, center.dy - 2); // Bellypan
    bodyPath.lineTo(center.dx - 10, center.dy);
    bodyPath.close();

    final bodyPaint = Paint()
      ..color = AppTheme.neonRed
      ..style = PaintingStyle.fill;
    canvas.drawPath(bodyPath, bodyPaint);

    // Glowing Neon Accent Stripe
    final stripePaint = Paint()
      ..color = AppTheme.electricCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawLine(
      Offset(center.dx - 20, center.dy - 22),
      Offset(center.dx + 35, center.dy - 16),
      stripePaint,
    );

    // 5. Rider Silhouette Tucked Low in Racing Stance
    final riderPath = Path();
    // Helmet
    final headCenter = Offset(center.dx + 12, center.dy - 40);
    canvas.drawCircle(headCenter, 10, Paint()..color = const Color(0xFF1E2430));
    // Helmet Visor Neon Line
    canvas.drawLine(
      Offset(headCenter.dx + 3, headCenter.dy - 2),
      Offset(headCenter.dx + 10, headCenter.dy + 1),
      Paint()
        ..color = AppTheme.electricCyan
        ..strokeWidth = 2.5,
    );

    // Rider Torso (Leaning aerodynamically forward)
    riderPath.moveTo(center.dx - 32, center.dy - 24); // Hips / Seat
    riderPath.lineTo(headCenter.dx - 6, headCenter.dy + 4); // Back spine
    riderPath.lineTo(center.dx + 22, center.dy - 20); // Arm clip-on hold
    riderPath.lineTo(center.dx - 18, center.dy - 10); // Leg knee bend
    riderPath.close();

    final riderPaint = Paint()
      ..color = const Color(0xFF0D1017)
      ..style = PaintingStyle.fill;
    canvas.drawPath(riderPath, riderPaint);

    final riderOutline = Paint()
      ..color = AppTheme.glassBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(riderPath, riderOutline);

    // 6. Forward LED Headlight Laser Beam
    final headlightStart = Offset(center.dx + 44, center.dy - 18);
    final headlightPath = Path();
    headlightPath.moveTo(headlightStart.dx, headlightStart.dy - 3);
    headlightPath.lineTo(size.width, headlightStart.dy - 18);
    headlightPath.lineTo(size.width, headlightStart.dy + 22);
    headlightPath.lineTo(headlightStart.dx, headlightStart.dy + 3);
    headlightPath.close();

    final headlightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppTheme.electricCyan.withValues(alpha: 0.5),
          AppTheme.electricCyan.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(headlightStart.dx, 0, size.width - headlightStart.dx, size.height));
    canvas.drawPath(headlightPath, headlightPaint);
  }

  @override
  bool shouldRepaint(covariant _RiderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
