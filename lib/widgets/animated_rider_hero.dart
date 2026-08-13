import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedRiderHero extends StatefulWidget {
  final double height;

  const AnimatedRiderHero({super.key, this.height = 160});

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
      duration: const Duration(milliseconds: 900),
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
            painter: _HyperSuperbikeRiderPainter(
              animValue: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _HyperSuperbikeRiderPainter extends CustomPainter {
  final double animValue;

  _HyperSuperbikeRiderPainter({required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Center base reference points
    final bikeCenterY = h * 0.52;
    final wheelRadius = h * 0.22;

    final rearWheel = Offset(w * 0.28, bikeCenterY + h * 0.14);
    final frontWheel = Offset(w * 0.72, bikeCenterY + h * 0.14);

    // -------------------------------------------------------------
    // 1. DYNAMIC ROAD / ASPHALT SPEED MARKS (Moving Backward Fast)
    // -------------------------------------------------------------
    final roadY = rearWheel.dy + wheelRadius + 2;
    final roadPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 8; i++) {
      final progress = (animValue + i * 0.125) % 1.0;
      final rx1 = w * (1.1 - progress * 1.2);
      final rx2 = rx1 - 40;
      roadPaint.color = (i % 2 == 0 ? AppTheme.electricCyan : AppTheme.neonRed)
          .withValues(alpha: (1.0 - progress) * 0.4);
      canvas.drawLine(Offset(rx1, roadY + (i % 3) * 3), Offset(rx2, roadY + (i % 3) * 3), roadPaint);
    }

    // -------------------------------------------------------------
    // 2. EXHAUST BURNOUT SMOKE & HIGH SPEED PARTICLES
    // -------------------------------------------------------------
    final exhaustPoint = Offset(rearWheel.dx - 10, rearWheel.dy - 22);
    final flamePaint = Paint()..style = PaintingStyle.fill;

    // Afterburner Turbo Exhaust Flames
    for (int f = 0; f < 5; f++) {
      final fProgress = (animValue + f * 0.2) % 1.0;
      final fx = exhaustPoint.dx - fProgress * 55;
      final fy = exhaustPoint.dy + sin(fProgress * pi * 4) * 4;
      final fRadius = 7.0 * (1.0 - fProgress);
      flamePaint.color = (f % 2 == 0 ? AppTheme.neonRed : Colors.orange)
          .withValues(alpha: (1.0 - fProgress) * 0.85);
      canvas.drawCircle(Offset(fx, fy), fRadius, flamePaint);
    }

    // High Speed Ambient Energy Lines
    final speedLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    for (int s = 0; s < 12; s++) {
      final sProgress = (animValue + s * 0.08) % 1.0;
      final sx = w * (1.2 - sProgress * 1.4);
      final sy = h * (0.1 + (s * 0.075));
      speedLinePaint.color = AppTheme.electricCyan.withValues(alpha: (1.0 - sProgress) * 0.35);
      canvas.drawLine(Offset(sx, sy), Offset(sx - 35, sy), speedLinePaint);
    }

    // -------------------------------------------------------------
    // 3. ULTRA-MODERN ALLOY WHEELS & SLICK TIRES
    // -------------------------------------------------------------
    void drawHyperWheel(Offset center) {
      // Outer Rubber Slick Tire
      final tireOutline = Paint()
        ..color = const Color(0xFF0F131C)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, wheelRadius, tireOutline);

      final tireTread = Paint()
        ..color = const Color(0xFF1E2638)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;
      canvas.drawCircle(center, wheelRadius - 2, tireTread);

      // Glowing Rim Wall
      final rimGlow = Paint()
        ..color = AppTheme.electricCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);
      canvas.drawCircle(center, wheelRadius - 6, rimGlow);

      // Brake Disc Rotor (Cross-Drilled)
      final discPaint = Paint()
        ..color = const Color(0xFF334155).withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
      canvas.drawCircle(center, wheelRadius - 12, discPaint);

      // High-Speed Rotating Y-Spokes (5 Dual Spokes)
      final spokePaint = Paint()
        ..color = AppTheme.electricCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2;

      final rotation = animValue * 2 * pi * 4; // High rpm rotation
      const numSpokes = 5;

      for (int k = 0; k < numSpokes; k++) {
        final angle = rotation + (k * 2 * pi / numSpokes);
        final innerX = center.dx + 8 * cos(angle);
        final innerY = center.dy + 8 * sin(angle);

        final outerX1 = center.dx + (wheelRadius - 7) * cos(angle - 0.12);
        final outerY1 = center.dy + (wheelRadius - 7) * sin(angle - 0.12);

        final outerX2 = center.dx + (wheelRadius - 7) * cos(angle + 0.12);
        final outerY2 = center.dy + (wheelRadius - 7) * sin(angle + 0.12);

        canvas.drawLine(Offset(innerX, innerY), Offset(outerX1, outerY1), spokePaint);
        canvas.drawLine(Offset(innerX, innerY), Offset(outerX2, outerY2), spokePaint);
      }

      // Center Hub & Brembo Red Caliper
      canvas.drawCircle(center, 7, Paint()..color = const Color(0xFF0F172A));
      canvas.drawCircle(center, 4, Paint()..color = Colors.white);

      // Red Brake Caliper at top of disc
      final caliperPaint = Paint()..color = AppTheme.neonRed;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(center.dx - 4, center.dy - wheelRadius + 7, 10, 8),
          const Radius.circular(2),
        ),
        caliperPaint,
      );
    }

    drawHyperWheel(rearWheel);
    drawHyperWheel(frontWheel);

    // -------------------------------------------------------------
    // 4. SUPERBIKE CHASSIS & CARBON FIBER BODYWORK
    // -------------------------------------------------------------
    // Rear Swingarm (Aluminum Dual Beam)
    final swingarmPath = Path();
    swingarmPath.moveTo(rearWheel.dx, rearWheel.dy);
    swingarmPath.lineTo(w * 0.45, bikeCenterY + 4);
    swingarmPath.lineTo(w * 0.42, bikeCenterY + 14);
    swingarmPath.close();

    final swingarmPaint = Paint()
      ..color = const Color(0xFF334155)
      ..style = PaintingStyle.fill;
    canvas.drawPath(swingarmPath, swingarmPaint);

    // Inverted Upside-Down Front Forks (Gold/Cyan Metallic Finish)
    final forkPaint = Paint()
      ..color = AppTheme.electricCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final forkStart = Offset(w * 0.62, bikeCenterY - 18);
    canvas.drawLine(forkStart, frontWheel, forkPaint);

    // Aerodynamic Fairing Body Shell (Hyper Aggressive Superbike)
    final fairingPath = Path();
    fairingPath.moveTo(rearWheel.dx - 18, bikeCenterY - 24); // Sharp Tail Cowl
    fairingPath.lineTo(w * 0.38, bikeCenterY - 22); // Rider Seat
    fairingPath.lineTo(w * 0.48, bikeCenterY - 32); // Sculpted Fuel Tank
    fairingPath.lineTo(w * 0.64, bikeCenterY - 26); // Clip-on Mount / Cockpit
    fairingPath.lineTo(w * 0.74, bikeCenterY - 14); // Nose Fairing Cone
    fairingPath.lineTo(w * 0.68, bikeCenterY + 12); // Front Fender/Bellypan Front
    fairingPath.lineTo(w * 0.50, bikeCenterY + 16); // Lower Engine Bellypan
    fairingPath.lineTo(w * 0.36, bikeCenterY - 6);  // Underseat Exhaust Chamber
    fairingPath.close();

    // Bodywork Gradient Fill (Crimson Red & Deep Racing Carbon)
    final bodyGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppTheme.neonRed,
        const Color(0xFF990000),
        const Color(0xFF1E293B),
      ],
    ).createShader(Rect.fromLTWH(w * 0.25, bikeCenterY - 35, w * 0.5, 55));

    canvas.drawPath(fairingPath, Paint()..shader = bodyGradient);

    // Carbon Fiber Aero Winglet on Front Nose
    final wingletPath = Path();
    wingletPath.moveTo(w * 0.68, bikeCenterY - 12);
    wingletPath.lineTo(w * 0.76, bikeCenterY - 10);
    wingletPath.lineTo(w * 0.74, bikeCenterY - 4);
    wingletPath.lineTo(w * 0.66, bikeCenterY - 6);
    wingletPath.close();
    canvas.drawPath(wingletPath, Paint()..color = const Color(0xFF0F172A));
    canvas.drawPath(
      wingletPath,
      Paint()
        ..color = AppTheme.electricCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // Neon Cyber Decal Lines
    final decalPaint = Paint()
      ..color = AppTheme.electricCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawLine(Offset(w * 0.40, bikeCenterY - 20), Offset(w * 0.66, bikeCenterY - 14), decalPaint);
    canvas.drawLine(Offset(w * 0.44, bikeCenterY - 2), Offset(w * 0.62, bikeCenterY + 6), decalPaint);

    // -------------------------------------------------------------
    // 5. MODERN MOTOGP RACING RIDER (Tucked Low & Streamlined)
    // -------------------------------------------------------------
    final riderSuitPaint = Paint()
      ..color = const Color(0xFF0B0F17)
      ..style = PaintingStyle.fill;

    // Aerodynamic Speed Hump on Rider's Back
    final humpPath = Path();
    humpPath.moveTo(w * 0.38, bikeCenterY - 34);
    humpPath.lineTo(w * 0.45, bikeCenterY - 44);
    humpPath.lineTo(w * 0.48, bikeCenterY - 38);
    humpPath.close();
    canvas.drawPath(humpPath, Paint()..color = AppTheme.neonRed);

    // Rider Body Curve (Low MotoGP Tuck)
    final riderPath = Path();
    riderPath.moveTo(w * 0.35, bikeCenterY - 24); // Hips / Tail Seat
    riderPath.lineTo(w * 0.44, bikeCenterY - 42); // Spine Back
    riderPath.lineTo(w * 0.57, bikeCenterY - 44); // Neck / Shoulder
    riderPath.lineTo(w * 0.62, bikeCenterY - 26); // Extended Arm to Handlebars
    riderPath.lineTo(w * 0.48, bikeCenterY - 24); // Leg Knee Puck Pressed to Tank
    riderPath.close();

    canvas.drawPath(riderPath, riderSuitPaint);
    canvas.drawPath(
      riderPath,
      Paint()
        ..color = AppTheme.electricCyan.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Racing Helmet (Aerodynamic Shell with Mirror Chrome Visor)
    final helmetCenter = Offset(w * 0.58, bikeCenterY - 45);
    canvas.drawCircle(helmetCenter, 11, Paint()..color = const Color(0xFF1E293B));
    canvas.drawCircle(
      helmetCenter,
      11,
      Paint()
        ..color = AppTheme.electricCyan
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Iridescent Visor Tint
    final visorPath = Path();
    visorPath.moveTo(helmetCenter.dx + 1, helmetCenter.dy - 5);
    visorPath.lineTo(helmetCenter.dx + 10, helmetCenter.dy - 1);
    visorPath.lineTo(helmetCenter.dx + 8, helmetCenter.dy + 5);
    visorPath.lineTo(helmetCenter.dx, helmetCenter.dy + 3);
    visorPath.close();

    canvas.drawPath(
      visorPath,
      Paint()
        ..shader = const LinearGradient(
          colors: [AppTheme.electricCyan, Colors.yellowAccent, AppTheme.neonRed],
        ).createShader(Rect.fromLTWH(helmetCenter.dx, helmetCenter.dy - 5, 10, 10)),
    );

    // -------------------------------------------------------------
    // 6. TWIN DRL HEADLIGHT LASER BEAM (FORWARD ILLUMINATION)
    // -------------------------------------------------------------
    final headlightNose = Offset(w * 0.74, bikeCenterY - 14);

    // Twin DRL Light Eyebrows
    final lightEyebrow = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);
    canvas.drawLine(headlightNose, Offset(headlightNose.dx - 4, headlightNose.dy - 5), lightEyebrow);

    // High Power Laser Cone Beam
    final beamPath = Path();
    beamPath.moveTo(headlightNose.dx, headlightNose.dy - 2);
    beamPath.lineTo(w, headlightNose.dy - 24);
    beamPath.lineTo(w, headlightNose.dy + 28);
    beamPath.lineTo(headlightNose.dx, headlightNose.dy + 4);
    beamPath.close();

    final beamShader = LinearGradient(
      colors: [
        AppTheme.electricCyan.withValues(alpha: 0.65),
        AppTheme.electricCyan.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromLTWH(headlightNose.dx, 0, w - headlightNose.dx, h));

    canvas.drawPath(beamPath, Paint()..shader = beamShader);
  }

  @override
  bool shouldRepaint(covariant _HyperSuperbikeRiderPainter oldDelegate) {
    return oldDelegate.animValue != animValue;
  }
}
