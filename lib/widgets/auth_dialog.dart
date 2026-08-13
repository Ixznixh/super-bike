import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'animated_rider_hero.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({super.key});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final AuthService _authService = AuthService();
  bool isGoogleLoading = false;
  String? errorMessage;

  Future<void> _handleGoogleSignIn() async {
    if (!mounted) return;
    setState(() {
      isGoogleLoading = true;
      errorMessage = null;
    });

    try {
      await _authService.signInWithGoogle();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString().replaceAll(RegExp(r'\[.*\]'), '').trim();
        });
      }
    } finally {
      if (mounted) {
        setState(() => isGoogleLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 440,
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.glassDecoration(
          borderColor: AppTheme.electricCyan,
          fillColor: const Color(0xFF0D1017).withValues(alpha: 0.95),
          borderRadius: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flash_on_rounded, color: AppTheme.neonRed, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'APEX TELEMETRY AUTH',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8)),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Live Animated Superbike Rider Hero
            const AnimatedRiderHero(height: 130),

            const SizedBox(height: 16),

            Text(
              'IGNITE YOUR GARAGE',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppTheme.electricCyan,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Sign in with Google to access live telemetry specs and sync across devices.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Color(0xFF94A3B8),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            if (errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.neonRed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.neonRed),
                ),
                child: Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppTheme.neonRed,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ),

            // Ultra-Modern Glowing Google Sign-In Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.electricCyan.withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: isGoogleLoading ? null : _handleGoogleSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: isGoogleLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black),
                      )
                    : const FaIcon(FontAwesomeIcons.google, color: Color(0xFF4285F4), size: 22),
                label: Text(
                  isGoogleLoading ? 'IGNITING ENGINE...' : 'SIGN IN WITH GOOGLE',
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
