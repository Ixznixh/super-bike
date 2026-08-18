import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ManufacturerFooter extends StatelessWidget {
  final Function(String) onNavSelect;

  const ManufacturerFooter({
    super.key,
    required this.onNavSelect,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isMobile = screenWidth < 600;

    return Container(
      color: const Color(0xFF090B0F),
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : 40,
        40,
        isMobile ? 16 : 40,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Footer Grid / Layout
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand Column
                SizedBox(
                  width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.two_wheeler_rounded, color: AppTheme.triumphRed, size: 28),
                          const SizedBox(width: 10),
                          const Text(
                            'GARAGE OF VELOCITY',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'FOR THE RIDE OF A LIFETIME',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.triumphRed,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'The ultimate superbike telemetry & heritage engineering platform. Dedicated to high-performance flagship superbikes, aero telemetry, and engine heritage.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.6),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Navigation Columns
                _buildFooterColumn('MOTORCYCLES', [
                  'Flagship Superbikes',
                  'Hyper Naked Series',
                  'Aerodynamic Racing',
                  'Telemetry Analytics',
                ]),

                _buildFooterColumn('BRANDS & HERITAGE', [
                  'Ducati Corse',
                  'BMW Motorrad M',
                  'Aprilia Factory',
                  'Kawasaki Ninja',
                ]),

                _buildFooterColumn('PORTAL & SPECS', [
                  'Apex Telemetry Auth',
                  'Google Sync Cloud',
                  'Engine Note Acoustics',
                  'Rankings & Leaderboard',
                ]),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Info
                Row(
                  children: [
                    const Icon(Icons.two_wheeler_rounded, color: AppTheme.triumphRed, size: 26),
                    const SizedBox(width: 8),
                    const Text(
                      'GARAGE OF VELOCITY',
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
                const SizedBox(height: 6),
                Text(
                  'FOR THE RIDE OF A LIFETIME',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.triumphRed,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The ultimate superbike telemetry platform.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 24),

                // Compact Mobile Links Grid
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  children: [
                    _buildFooterColumn('PORTAL', ['Superbikes', 'Telemetry', 'Racing']),
                    _buildFooterColumn('BRANDS', ['Ducati', 'BMW', 'Aprilia', 'Kawasaki']),
                  ],
                ),
              ],
            ),

          const SizedBox(height: 32),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 1),
          const SizedBox(height: 20),

          // Bottom Bar & Copyright Disclaimer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '© 2026 GARAGE OF VELOCITY. ALL RIGHTS RESERVED. TELEMETRY SPECS & DATA PROVIDED FOR ENTHUSIAST DEMONSTRATION.',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: isMobile ? 8 : 10,
                    color: Colors.white.withValues(alpha: 0.4),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: () {},
              child: Text(
                item,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
