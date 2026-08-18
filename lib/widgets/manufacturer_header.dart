import 'dart:ui';
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
    final isMobile = screenWidth < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Upper Utility Bar (Location, Dealer, Finance, Auth)
        Container(
          color: const Color(0xFF090B0F),
          padding: EdgeInsets.fromLTRB(
            isMobile ? 12 : 24,
            MediaQuery.of(context).padding.top > 0 ? MediaQuery.of(context).padding.top + 4 : 6,
            isMobile ? 12 : 24,
            6,
          ),
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
                  const SizedBox(width: 6),
                  Text(
                    isMobile ? 'PORTAL' : 'OFFICIAL MOTORCYCLE PORTAL',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: isMobile ? 9 : 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: isMobile ? 0.8 : 1.2,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),

              // Right utility menu (India Country Selector + Auth button)
              Row(
                children: [
                  // Country Selector
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white70, size: 12),
                      const SizedBox(width: 3),
                      Text(
                        'INDIA 🇮🇳',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: isMobile ? 9 : 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 14),
                    ],
                  ),
                  SizedBox(width: isMobile ? 10 : 16),

                  // User Auth Pill Button
                  InkWell(
                    onTap: currentUser == null ? onLoginTap : onLogoutTap,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 10 : 16,
                        vertical: isMobile ? 5 : 7,
                      ),
                      decoration: AppTheme.liquidGlassPill(
                        accentColor: AppTheme.triumphRed,
                        isActive: true,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            currentUser == null ? Icons.login_rounded : Icons.person_rounded,
                            size: isMobile ? 11 : 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            currentUser == null
                                ? 'LOG IN / REGISTER'
                                : (currentUser!.email?.split('@').first.toUpperCase() ?? 'MY GARAGE'),
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
            ],
          ),
        ),

        // Main iOS Liquid Glass Navigation Bar
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 16,
            vertical: 6,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 24,
                  vertical: isMobile ? 10 : 14,
                ),
                decoration: AppTheme.liquidGlassDecoration(
                  fillColor: const Color(0xFF10141D).withValues(alpha: 0.75),
                  borderColor: Colors.white.withValues(alpha: 0.18),
                  borderRadius: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
              // Brand Logo & Title
              Flexible(
                child: InkWell(
                  onTap: () => onNavSelect('HOME'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.two_wheeler_rounded,
                        color: AppTheme.triumphRed,
                        size: isMobile ? 24 : 32,
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GARAGE OF VELOCITY',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: isMobile ? 13 : 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: isMobile ? 1.0 : 2.0,
                              ),
                            ),
                            Text(
                              'FOR THE RIDE OF A LIFETIME',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: isMobile ? 7 : 9,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.triumphRed,
                                letterSpacing: isMobile ? 1.0 : 1.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main Nav Items (Desktop) or Mobile Menu Button
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
                )
              else
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 22),
                  color: const Color(0xFF10141D),
                  onSelected: onNavSelect,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'MOTORCYCLES',
                      child: Text('MOTORCYCLES', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 12)),
                    ),
                    const PopupMenuItem(
                      value: 'SUPERBIKES',
                      child: Text('SUPERBIKES', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 12)),
                    ),
                    const PopupMenuItem(
                      value: 'SPECS',
                      child: Text('TELEMETRY & SPECS', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 12)),
                    ),
                    const PopupMenuItem(
                      value: 'RACING',
                      child: Text('RACING', style: TextStyle(color: Colors.white, fontFamily: 'Orbitron', fontSize: 12)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
  ),
],
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
