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
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 24,
            vertical: 6,
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

              // Right utility menu & Auth button
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
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 8 : 12,
                        vertical: isMobile ? 4 : 5,
                      ),
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
                            size: isMobile ? 11 : 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            currentUser == null
                                ? (isMobile ? 'LOG IN' : 'LOG IN / REGISTER')
                                : (currentUser!.email?.split('@').first.toUpperCase() ?? 'MY GARAGE'),
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: isMobile ? 9 : 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.6,
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
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 24,
            vertical: isMobile ? 10 : 14,
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
