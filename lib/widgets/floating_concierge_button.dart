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
          // WhatsApp Floating Action Pill
          InkWell(
            onTap: _openWhatsApp,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: isMobile ? 8 : 10,
              ),
              decoration: BoxDecoration(
                color: AppTheme.neonGreen,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.neonGreen.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
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
          SizedBox(height: isMobile ? 8 : 10),

          // Test Ride Floating Button
          InkWell(
            onTap: onRequestTestRide,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: isMobile ? 8 : 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF10141D),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppTheme.triumphRed, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
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
        ],
      ),
    );
  }
}
