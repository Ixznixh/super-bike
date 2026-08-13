import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({super.key});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final AuthService _authService = AuthService();

  bool isGoogleLoading = false;
  bool isGuestLoading = false;
  String? errorMessage;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      isGoogleLoading = true;
      errorMessage = null;
    });

    try {
      await _authService.signInWithGoogle();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll(RegExp(r'\[.*\]'), '').trim();
      });
    } finally {
      if (mounted) setState(() => isGoogleLoading = false);
    }
  }

  Future<void> _guestLogin() async {
    setState(() {
      isGuestLoading = true;
      errorMessage = null;
    });
    try {
      await _authService.signInAnonymously();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() => errorMessage = 'Guest login failed: $e');
    } finally {
      if (mounted) setState(() => isGuestLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SIGN IN TO APEX',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.electricCyan,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Sign in with your Google Account to upload superbikes and sync telemetry across devices.',
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
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.neonRed),
                ),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: AppTheme.neonRed,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ),

            // Prominent Google Sign-In Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: isGoogleLoading || isGuestLoading ? null : _handleGoogleSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: isGoogleLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      )
                    : const FaIcon(FontAwesomeIcons.google, color: Color(0xFF4285F4), size: 22),
                label: Text(
                  isGoogleLoading ? 'SIGNING IN...' : 'SIGN IN WITH GOOGLE',
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Guest Mode Option
            TextButton(
              onPressed: isGoogleLoading || isGuestLoading ? null : _guestLogin,
              child: isGuestLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF94A3B8)),
                    )
                  : const Text(
                      'Continue as Guest',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                        fontFamily: 'Rajdhani',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
