import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class FloatingConciergeButton extends StatelessWidget {
  final VoidCallback onRequestTestRide;

  const FloatingConciergeButton({
    super.key,
    required this.onRequestTestRide,
  });

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/?text=Hello%20Garage%20of%20Velocity!%20I%20would%20like%20to%20inquire%20about%20a%20Superbike%20Test%20Ride.');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Positioned(
      bottom: isMobile ? (16 + bottomPadding) : 24,
      right: isMobile ? 12 : 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // WhatsApp Liquid Glass Action Pill
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: InkWell(
                onTap: _openWhatsApp,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 8 : 10,
                  ),
                  decoration: AppTheme.liquidGlassPill(
                    accentColor: AppTheme.neonGreen,
                    isActive: true,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_bubble_rounded, color: Colors.white, size: isMobile ? 16 : 20),
                      SizedBox(width: isMobile ? 6 : 8),
                      Text(
                        'WhatsApp',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: isMobile ? 11 : 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 8 : 10),

          // Test Ride Liquid Glass Floating Button
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: InkWell(
                onTap: onRequestTestRide,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 8 : 10,
                  ),
                  decoration: AppTheme.liquidGlassPill(
                    accentColor: AppTheme.triumphRed,
                    isActive: true,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.two_wheeler_rounded, color: AppTheme.triumphRed, size: isMobile ? 16 : 20),
                      SizedBox(width: isMobile ? 6 : 8),
                      Text(
                        'Book Test Ride',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: isMobile ? 9 : 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
