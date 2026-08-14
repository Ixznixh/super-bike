import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ManufacturerHeader extends StatelessWidget {
  final User? currentUser;
  final VoidCallback onLoginTap;
  final VoidCallback onLogoutTap;
  final Function(String) onNavSelect;

  const ManufacturerHeader({
    super.key,
    required this.currentUser,
    required this.onLoginTap,
    required this.onLogoutTap,
    required this.onNavSelect,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Upper Utility Bar (Location, Dealer, Finance, Auth)
        Container(
          color: const Color(0xFF090B0F),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left indicator
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppTheme.triumphRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'OFFICIAL MOTORCYCLE PORTAL',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),

              // Right utility menu
              Row(
                children: [
                  if (isDesktop) ...[
                    _buildUtilityLink('Dealer Locator', () {}),
                    _buildUtilityDivider(),
                    _buildUtilityLink('Customize', () {}),
                    _buildUtilityDivider(),
                    _buildUtilityLink('Finance Offers', () {}),
                    _buildUtilityDivider(),
                    _buildUtilityLink('Book Test Ride', () {}),
                    _buildUtilityDivider(),
                    // Country Dropdown
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.white70, size: 13),
                        const SizedBox(width: 4),
                        Text(
                          'INDIA 🇮🇳',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 14),
                      ],
                    ),
                    const SizedBox(width: 16),
                  ],

                  // User Auth Pill Button
                  InkWell(
                    onTap: currentUser == null ? onLoginTap : onLogoutTap,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: currentUser == null ? AppTheme.triumphRed : const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: currentUser == null ? AppTheme.triumphRed : AppTheme.electricCyan,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            currentUser == null ? Icons.login_rounded : Icons.person_rounded,
                            size: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            currentUser == null
                                ? 'LOG IN / REGISTER'
                                : (currentUser!.email?.split('@').first.toUpperCase() ?? 'MY GARAGE'),
                            style: const TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 10,
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
            ],
          ),
        ),

        // Main Navigation Bar with Logo & Sections
        Container(
          color: const Color(0xFF10141D),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Brand Logo & Title
              InkWell(
                onTap: () => onNavSelect('HOME'),
                child: Row(
                  children: [
                    const Icon(Icons.two_wheeler_rounded, color: AppTheme.triumphRed, size: 32),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GARAGE OF VELOCITY',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'FOR THE RIDE OF A LIFETIME',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.triumphRed,
                            letterSpacing: 1.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Nav Items (Desktop)
              if (isDesktop)
                Row(
                  children: [
                    _buildNavItem('MOTORCYCLES', true, () => onNavSelect('MOTORCYCLES')),
                    _buildNavItem('SUPERBIKES', false, () => onNavSelect('SUPERBIKES')),
                    _buildNavItem('TELEMETRY & SPECS', false, () => onNavSelect('SPECS')),
                    _buildNavItem('RACING', false, () => onNavSelect('RACING')),
                    _buildNavItem('OWNERS', false, () => onNavSelect('OWNERS')),
                    _buildNavItem('DISCOVER', false, () => onNavSelect('DISCOVER')),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUtilityLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildUtilityDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        '|',
        style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 11),
      ),
    );
  }

  Widget _buildNavItem(String label, bool isHighlight, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: isHighlight ? Colors.white : Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}
