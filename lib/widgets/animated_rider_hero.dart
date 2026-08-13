import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedRiderHero extends StatefulWidget {
  final double height;

  const AnimatedRiderHero({super.key, this.height = 170});

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
        return SizedBox(
          height: widget.height,
          width: double.infinity,
          child: CustomPaint(
            painter: _IconBikerAirflowPainter(
              animValue: _controller.value,
            ),
          ),
        );
      },
    );
  }
}

class _IconBikerAirflowPainter extends CustomPainter {
  final double animValue;

  _IconBikerAirflowPainter({required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Scale reference box based on canvas dimensions
    final bikeScale = min(w / 320.0, h / 160.0);
    final cx = w * 0.48;
    final cy = h * 0.52;

    // Wheel Centers
    final rearCenter = Offset(cx - 75 * bikeScale, cy + 25 * bikeScale);
    final frontCenter = Offset(cx + 85 * bikeScale, cy + 25 * bikeScale);
    final wheelR = 26 * bikeScale;

    // -----------------------------------------------------------------
    // 1. AERODYNAMIC AIR FLOW STREAMS (Wind Tunnel Dynamic Animations)
    // -----------------------------------------------------------------
    final airPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    void drawAirStream({
      required Path basePath,
      required double strokeWidth,
      required Color color,
      required double phaseOffset,
      required double dashLength,
    }) {
      final pathMetrics = basePath.computeMetrics();
      for (final metric in pathMetrics) {
        final totalLength = metric.length;
        final progress = (animValue + phaseOffset) % 1.0;
        final startDist = (progress * totalLength);
        final endDist = min(startDist + dashLength, totalLength);

        if (startDist < totalLength) {
          final extractPath = metric.extractPath(startDist, endDist);
          airPaint
            ..color = color
            ..strokeWidth = strokeWidth
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
          canvas.drawPath(extractPath, airPaint);
        }

        // Loop second segment for continuous stream wrap
        if (startDist + dashLength > totalLength) {
          final wrapEnd = (startDist + dashLength) - totalLength;
          final wrapPath = metric.extractPath(0, wrapEnd);
          airPaint
            ..color = color
            ..strokeWidth = strokeWidth
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
          canvas.drawPath(wrapPath, airPaint);
        }
      }
    }

    // Stream 1: High stream over helmet
    final streamTop = Path();
    streamTop.moveTo(cx + 140 * bikeScale, cy - 65 * bikeScale);
    streamTop.cubicTo(
      cx + 70 * bikeScale, cy - 75 * bikeScale,
      cx - 20 * bikeScale, cy - 75 * bikeScale,
      cx - 130 * bikeScale, cy - 60 * bikeScale,
    );
    drawAirStream(
      basePath: streamTop,
      strokeWidth: 2.2,
      color: AppTheme.electricCyan.withValues(alpha: 0.9),
      phaseOffset: 0.0,
      dashLength: 70 * bikeScale,
    );

    // Stream 2: Contour wrapping directly over Rider Helmet & Back
    final streamHelmet = Path();
    streamHelmet.moveTo(cx + 120 * bikeScale, cy - 35 * bikeScale);
    streamHelmet.cubicTo(
      cx + 50 * bikeScale, cy - 48 * bikeScale, // Front nose & helmet dip
      cx - 20 * bikeScale, cy - 65 * bikeScale, // Over helmet dome & spine
      cx - 140 * bikeScale, cy - 40 * bikeScale, // Flowing off back
    );
    drawAirStream(
      basePath: streamHelmet,
      strokeWidth: 2.8,
      color: Colors.white.withValues(alpha: 0.95),
      phaseOffset: 0.25,
      dashLength: 85 * bikeScale,
    );

    // Stream 3: Mid stream over Tank & Arms
    final streamMid = Path();
    streamMid.moveTo(cx + 130 * bikeScale, cy - 10 * bikeScale);
    streamMid.cubicTo(
      cx + 60 * bikeScale, cy - 22 * bikeScale,
      cx + 10 * bikeScale, cy - 30 * bikeScale,
      cx - 120 * bikeScale, cy - 20 * bikeScale,
    );
    drawAirStream(
      basePath: streamMid,
      strokeWidth: 2.0,
      color: AppTheme.electricCyan.withValues(alpha: 0.75),
      phaseOffset: 0.5,
      dashLength: 60 * bikeScale,
    );

    // Stream 4: Low stream under chassis & rear wheel
    final streamLow = Path();
    streamLow.moveTo(cx + 130 * bikeScale, cy + 30 * bikeScale);
    streamLow.cubicTo(
      cx + 50 * bikeScale, cy + 20 * bikeScale,
      cx - 30 * bikeScale, cy + 20 * bikeScale,
      cx - 130 * bikeScale, cy + 28 * bikeScale,
    );
    drawAirStream(
      basePath: streamLow,
      strokeWidth: 2.4,
      color: AppTheme.neonRed.withValues(alpha: 0.8),
      phaseOffset: 0.75,
      dashLength: 65 * bikeScale,
    );

    // -----------------------------------------------------------------
    // 2. ROAD SPEED PULSES UNDER TIRES
    // -----------------------------------------------------------------
    final groundY = rearCenter.dy + wheelR + 2 * bikeScale;
    final groundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * bikeScale
      ..strokeCap = StrokeCap.round;

    for (int g = 0; g < 6; g++) {
      final gProgress = (animValue + g * 0.16) % 1.0;
      final gx1 = w * (1.1 - gProgress * 1.2);
      final gx2 = gx1 - 35 * bikeScale;
      groundPaint.color = AppTheme.electricCyan.withValues(alpha: (1.0 - gProgress) * 0.5);
      canvas.drawLine(Offset(gx1, groundY), Offset(gx2, groundY), groundPaint);
    }

    // -----------------------------------------------------------------
    // 3. EXACT VECTOR SILHOUETTE OF THE BIKER (TRANSPARENT BACKGROUND)
    // -----------------------------------------------------------------
    final bPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 * bikeScale;

    // --- SPINNING WHEELS (Matching exact icon position) ---
    void drawIconWheel(Offset center) {
      // Outer Tire
      canvas.drawCircle(center, wheelR, bPaint);
      // Inner Hub Hole (Cutout transparent)
      canvas.drawCircle(center, wheelR - 7 * bikeScale, Paint()..color = AppTheme.background);
      canvas.drawCircle(center, wheelR - 7 * bikeScale, outlinePaint);

      // Spinning 4-Spoke Cross
      final spokeP = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5 * bikeScale;

      final rot = animValue * 2 * pi * 3;
      for (int s = 0; s < 4; s++) {
        final angle = rot + (s * pi / 2);
        final sx = center.dx + (wheelR - 7 * bikeScale) * cos(angle);
        final sy = center.dy + (wheelR - 7 * bikeScale) * sin(angle);
        canvas.drawLine(center, Offset(sx, sy), spokeP);
      }

      // Center Axle Pin
      canvas.drawCircle(center, 5 * bikeScale, bPaint);
    }

    drawIconWheel(rearCenter);
    drawIconWheel(frontCenter);

    // --- REAR FENDER ---
    final rearFenderPath = Path();
    rearFenderPath.addArc(
      Rect.fromCircle(center: rearCenter, radius: wheelR + 4 * bikeScale),
      pi * 1.1,
      pi * 0.55,
    );
    canvas.drawPath(
      rearFenderPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6 * bikeScale
        ..strokeCap = StrokeCap.round,
    );

    // --- CHASSIS FRAME & LOWER EXHAUST PIPE ---
    final framePath = Path();
    // Lower Frame Bar connecting rear axle to engine and exhaust
    framePath.moveTo(rearCenter.dx, rearCenter.dy);
    framePath.lineTo(cx - 30 * bikeScale, cy + 25 * bikeScale);
    framePath.lineTo(cx + 25 * bikeScale, cy + 25 * bikeScale); // Engine base
    framePath.lineTo(cx + 52 * bikeScale, cy - 5 * bikeScale);  // Front down tube
    framePath.lineTo(cx + 42 * bikeScale, cy - 35 * bikeScale); // Steering neck
    framePath.lineTo(cx + 82 * bikeScale, cy + 25 * bikeScale); // Front fork to front wheel
    
    final frameBarPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5 * bikeScale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(framePath, frameBarPaint);

    // Exhaust Pipe (Running straight back under footrest)
    final exhaustPath = Path();
    exhaustPath.moveTo(cx + 20 * bikeScale, cy + 22 * bikeScale);
    exhaustPath.lineTo(cx - 55 * bikeScale, cy + 22 * bikeScale);
    canvas.drawPath(
      exhaustPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4 * bikeScale
        ..strokeCap = StrokeCap.round,
    );

    // --- ENGINE BLOCK ---
    final enginePath = Path();
    enginePath.moveTo(cx + 5 * bikeScale, cy + 5 * bikeScale);
    enginePath.lineTo(cx + 28 * bikeScale, cy + 5 * bikeScale);
    enginePath.lineTo(cx + 28 * bikeScale, cy + 24 * bikeScale);
    enginePath.lineTo(cx + 5 * bikeScale, cy + 24 * bikeScale);
    enginePath.close();
    canvas.drawPath(enginePath, bPaint);

    // --- FUEL TANK (Classic Sculpted Droplet Tank) ---
    final tankPath = Path();
    tankPath.moveTo(cx - 10 * bikeScale, cy - 5 * bikeScale);
    tankPath.cubicTo(
      cx + 5 * bikeScale, cy - 25 * bikeScale,
      cx + 35 * bikeScale, cy - 25 * bikeScale,
      cx + 45 * bikeScale, cy - 8 * bikeScale,
    );
    tankPath.lineTo(cx + 20 * bikeScale, cy - 4 * bikeScale);
    tankPath.close();
    canvas.drawPath(tankPath, bPaint);

    // --- FRONT HEADLIGHT ---
    canvas.drawCircle(Offset(cx + 46 * bikeScale, cy - 32 * bikeScale), 7 * bikeScale, bPaint);

    // --- HIGH HANDLEBARS ---
    final handlebarPath = Path();
    handlebarPath.moveTo(cx + 42 * bikeScale, cy - 35 * bikeScale);
    handlebarPath.lineTo(cx + 25 * bikeScale, cy - 45 * bikeScale);
    handlebarPath.lineTo(cx + 20 * bikeScale, cy - 42 * bikeScale);
    canvas.drawPath(
      handlebarPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5 * bikeScale
        ..strokeCap = StrokeCap.round,
    );

    // --- RIDER SILHOUETTE (Exact matching posture from uploaded image) ---
    // 1. Round Open-Face Helmet & Face Contour
    final headCenter = Offset(cx - 20 * bikeScale, cy - 60 * bikeScale);
    canvas.drawCircle(headCenter, 14 * bikeScale, bPaint);
    // Chin cutout curve for face profile
    final faceCutout = Path();
    faceCutout.moveTo(headCenter.dx + 4 * bikeScale, headCenter.dy - 6 * bikeScale);
    faceCutout.lineTo(headCenter.dx + 15 * bikeScale, headCenter.dy - 6 * bikeScale);
    faceCutout.lineTo(headCenter.dx + 15 * bikeScale, headCenter.dy + 8 * bikeScale);
    faceCutout.lineTo(headCenter.dx + 7 * bikeScale, headCenter.dy + 8 * bikeScale);
    faceCutout.close();
    canvas.drawPath(faceCutout, Paint()..color = AppTheme.background);

    // Nose & Chin detail pin
    canvas.drawCircle(
      Offset(headCenter.dx + 10 * bikeScale, headCenter.dy + 1 * bikeScale),
      2.5 * bikeScale,
      bPaint,
    );

    // 2. Rider Torso (Upright Body)
    final torsoPath = Path();
    torsoPath.moveTo(cx - 38 * bikeScale, cy - 25 * bikeScale); // Seat hips
    torsoPath.lineTo(cx - 28 * bikeScale, cy - 48 * bikeScale); // Back spine to shoulder
    torsoPath.lineTo(cx - 10 * bikeScale, cy - 48 * bikeScale); // Chest
    torsoPath.lineTo(cx - 20 * bikeScale, cy - 25 * bikeScale); // Lap
    torsoPath.close();
    canvas.drawPath(torsoPath, bPaint);

    // 3. Extended Arms holding Handlebars
    final armPath = Path();
    armPath.moveTo(cx - 15 * bikeScale, cy - 46 * bikeScale); // Shoulder
    armPath.lineTo(cx + 12 * bikeScale, cy - 44 * bikeScale); // Arm
    armPath.lineTo(cx + 20 * bikeScale, cy - 42 * bikeScale); // Hand on grip
    canvas.drawPath(
      armPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6 * bikeScale
        ..strokeCap = StrokeCap.round,
    );

    // 4. Bent Leg & Riding Boot (Right Angle to Footpeg)
    final legPath = Path();
    legPath.moveTo(cx - 22 * bikeScale, cy - 25 * bikeScale); // Hip
    legPath.lineTo(cx - 10 * bikeScale, cy - 4 * bikeScale);  // Thigh to Knee
    legPath.lineTo(cx - 10 * bikeScale, cy + 18 * bikeScale); // Shin down
    legPath.lineTo(cx + 5 * bikeScale, cy + 18 * bikeScale);  // Boot forward on footrest
    legPath.lineTo(cx + 5 * bikeScale, cy + 10 * bikeScale);
    legPath.lineTo(cx - 2 * bikeScale, cy + 10 * bikeScale);
    legPath.lineTo(cx - 2 * bikeScale, cy - 4 * bikeScale);
    legPath.close();
    canvas.drawPath(legPath, bPaint);
  }

  @override
  bool shouldRepaint(covariant _IconBikerAirflowPainter oldDelegate) {
    return oldDelegate.animValue != animValue;
  }
}
