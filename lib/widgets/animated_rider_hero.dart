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
        final val = _controller.value;
        // Micro engine rumble vibration (1.2px vertical oscillation)
        final rumbleY = sin(val * 2 * pi * 4) * 1.2;

        return SizedBox(
          height: widget.height,
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 1. Background Airflow & Speed Streamlines Layer
              Positioned.fill(
                child: CustomPaint(
                  painter: _AirflowMotionPainter(animValue: val),
                ),
              ),

              // 2. Main Biker Image (Without altering main picture, keying white to transparent)
              Transform.translate(
                offset: Offset(0, rumbleY),
                child: Container(
                  height: widget.height,
                  alignment: Alignment.center,
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dst,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.matrix(<double>[
                        // Matrix to key out white background: (Red + Green + Blue)/3 inversion for alpha
                        1, 0, 0, 0, 0,
                        0, 1, 0, 0, 0,
                        0, 0, 1, 0, 0,
                        -0.33, -0.33, -0.33, 1, 255,
                      ]),
                      child: Image.asset(
                        'assets/images/biker_hero.png',
                        height: widget.height,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback in case asset path is loading on web
                          return Image.network(
                            'assets/biker_hero.png',
                            height: widget.height,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // 3. Foreground Motion Effects (Wheel Spoke Rims, Exhaust Flames, Headlight Flare)
              Positioned.fill(
                child: CustomPaint(
                  painter: _ForegroundEffectsPainter(
                    animValue: val,
                    rumbleY: rumbleY,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AirflowMotionPainter extends CustomPainter {
  final double animValue;

  _AirflowMotionPainter({required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Aerodynamic Wind Tunnel Streamlines wrapping over the rider
    final airPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    void drawStream(Path path, Color color, double strokeWidth, double phase, double dashLen) {
      final metrics = path.computeMetrics();
      for (final m in metrics) {
        final len = m.length;
        final progress = (animValue + phase) % 1.0;
        final start = progress * len;
        final end = min(start + dashLen, len);

        if (start < len) {
          airPaint
            ..color = color
            ..strokeWidth = strokeWidth
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
          canvas.drawPath(m.extractPath(start, end), airPaint);
        }
        if (start + dashLen > len) {
          final wrapEnd = (start + dashLen) - len;
          airPaint
            ..color = color
            ..strokeWidth = strokeWidth
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
          canvas.drawPath(m.extractPath(0, wrapEnd), airPaint);
        }
      }
    }

    // Top Airflow Stream over Helmet
    final pathTop = Path()
      ..moveTo(w * 0.95, h * 0.12)
      ..cubicTo(w * 0.70, h * 0.05, w * 0.40, h * 0.05, w * 0.05, h * 0.15);
    drawStream(pathTop, AppTheme.electricCyan.withValues(alpha: 0.9), 2.4, 0.0, 75);

    // Helmet Contour Airflow Stream
    final pathHelmet = Path()
      ..moveTo(w * 0.90, h * 0.32)
      ..cubicTo(w * 0.75, h * 0.18, w * 0.50, h * 0.08, w * 0.10, h * 0.28);
    drawStream(pathHelmet, Colors.white.withValues(alpha: 0.95), 2.8, 0.3, 85);

    // Tank & Arm Airflow Stream
    final pathMid = Path()
      ..moveTo(w * 0.92, h * 0.52)
      ..cubicTo(w * 0.70, h * 0.42, w * 0.45, h * 0.35, w * 0.05, h * 0.48);
    drawStream(pathMid, AppTheme.electricCyan.withValues(alpha: 0.75), 2.0, 0.6, 65);

    // Ground Speed Asphalt Lines under tires
    final groundY = h * 0.88;
    final groundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int g = 0; g < 7; g++) {
      final gProg = (animValue + g * 0.14) % 1.0;
      final gx1 = w * (1.1 - gProg * 1.2);
      final gx2 = gx1 - 40;
      groundPaint.color = AppTheme.electricCyan.withValues(alpha: (1.0 - gProg) * 0.45);
      canvas.drawLine(Offset(gx1, groundY), Offset(gx2, groundY), groundPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AirflowMotionPainter oldDelegate) {
    return oldDelegate.animValue != animValue;
  }
}

class _ForegroundEffectsPainter extends CustomPainter {
  final double animValue;
  final double rumbleY;

  _ForegroundEffectsPainter({
    required this.animValue,
    required this.rumbleY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Center offsets corresponding to the picture proportions
    final imgWidth = min(w, h * 1.5);
    final imgLeft = (w - imgWidth) / 2;

    // Coordinates mapped to the image dimensions
    final rearWheel = Offset(imgLeft + imgWidth * 0.21, h * 0.74 + rumbleY);
    final frontWheel = Offset(imgLeft + imgWidth * 0.83, h * 0.74 + rumbleY);
    final wheelRadius = imgWidth * 0.145;

    final headlightPos = Offset(imgLeft + imgWidth * 0.88, h * 0.48 + rumbleY);
    final exhaustPos = Offset(imgLeft + imgWidth * 0.34, h * 0.73 + rumbleY);

    // 1. ROTATING NEON WHEEL SPOKE GLOW OVERLAYS
    void drawWheelMotion(Offset center) {
      final rimGlow = Paint()
        ..color = AppTheme.electricCyan.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);
      canvas.drawCircle(center, wheelRadius - 3, rimGlow);

      // Rotating Spoke Lines
      final spokePaint = Paint()
        ..color = AppTheme.electricCyan.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8;

      const numSpokes = 5;
      final rotation = animValue * 2 * pi * 4; // High speed rotation

      for (int i = 0; i < numSpokes; i++) {
        final angle = rotation + (i * 2 * pi / numSpokes);
        final sx = center.dx + (wheelRadius - 6) * cos(angle);
        final sy = center.dy + (wheelRadius - 6) * sin(angle);
        canvas.drawLine(center, Offset(sx, sy), spokePaint);
      }
    }

    drawWheelMotion(rearWheel);
    drawWheelMotion(frontWheel);

    // 2. EXHAUST BURNOUT SMOKE & TURBO AFTERBURNER FLAMES
    final flamePaint = Paint()..style = PaintingStyle.fill;
    for (int f = 0; f < 6; f++) {
      final fProg = (animValue + f * 0.16) % 1.0;
      final fx = exhaustPos.dx - fProg * 45;
      final fy = exhaustPos.dy + sin(fProg * pi * 4) * 3;
      final fRadius = 6.5 * (1.0 - fProg);
      flamePaint.color = (f % 2 == 0 ? AppTheme.neonRed : Colors.orangeAccent)
          .withValues(alpha: (1.0 - fProg) * 0.85);
      canvas.drawCircle(Offset(fx, fy), fRadius, flamePaint);
    }

    // 3. HEADLIGHT PULSING LED LENS FLARE
    final flareRadius = 14.0 + sin(animValue * 2 * pi * 2) * 4.0;
    final flarePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 8);
    canvas.drawCircle(headlightPos, flareRadius, flarePaint);

    final laserBeamPath = Path();
    laserBeamPath.moveTo(headlightPos.dx, headlightPos.dy - 3);
    laserBeamPath.lineTo(w, headlightPos.dy - 20);
    laserBeamPath.lineTo(w, headlightPos.dy + 25);
    laserBeamPath.lineTo(headlightPos.dx, headlightPos.dy + 3);
    laserBeamPath.close();

    final beamShader = LinearGradient(
      colors: [
        AppTheme.electricCyan.withValues(alpha: 0.6),
        AppTheme.electricCyan.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromLTWH(headlightPos.dx, 0, w - headlightPos.dx, h));

    canvas.drawPath(laserBeamPath, Paint()..shader = beamShader);
  }

  @override
  bool shouldRepaint(covariant _ForegroundEffectsPainter oldDelegate) {
    return oldDelegate.animValue != animValue || oldDelegate.rumbleY != rumbleY;
  }
}
