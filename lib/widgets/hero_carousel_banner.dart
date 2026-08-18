import 'dart:async';
import 'package:flutter/material.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';

class HeroCarouselBanner extends StatefulWidget {
  final List<Superbike> featuredBikes;
  final Function(Superbike) onExploreBike;

  const HeroCarouselBanner({
    super.key,
    required this.featuredBikes,
    required this.onExploreBike,
  });

  @override
  State<HeroCarouselBanner> createState() => _HeroCarouselBannerState();
}

class _HeroCarouselBannerState extends State<HeroCarouselBanner> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (widget.featuredBikes.isEmpty) return;
      final nextIndex = (_currentIndex + 1) % widget.featuredBikes.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featuredBikes.isEmpty) return const SizedBox.shrink();

    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isMobile = screenWidth < 600;
    final heroHeight = isDesktop ? 520.0 : (isMobile ? 420.0 : 380.0);

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        children: [
          // PageView Slider
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: widget.featuredBikes.length,
            itemBuilder: (context, index) {
              final bike = widget.featuredBikes[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Full-bleed Image with Dark Vignette Overlay
                  Image.network(
                    bike.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.surface,
                      child: const Center(
                        child: Icon(Icons.two_wheeler_rounded, size: 80, color: AppTheme.triumphRed),
                      ),
                    ),
                  ),

                  // Dark Gradient Overlay for Crisp Text Readability
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xEE090B0F), // Dark black vignette left
                          Color(0x99090B0F), // Mid opacity
                          Color(0x22090B0F), // Transparent right
                        ],
                        stops: [0.0, 0.55, 1.0],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),

                  // Content Overlay (Stacked Headline, Subtitle, Red Action Button)
                  Positioned(
                    left: isDesktop ? 60 : 16,
                    top: isDesktop ? 90 : (isMobile ? 24 : 40),
                    right: isDesktop ? screenWidth * 0.4 : 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pill badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.triumphRed,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            'FLAGSHIP SERIES #${index + 1}',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: isMobile ? 9 : 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 10 : 16),

                        // Stacked Massive White Typography (Clean displayTitle)
                        Text(
                          bike.displayTitle.toUpperCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: isDesktop ? 44 : (isMobile ? 20 : 26),
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                            letterSpacing: isMobile ? 0.8 : 1.5,
                          ),
                        ),
                        SizedBox(height: isMobile ? 6 : 12),

                        // Subtitle tagline
                        Text(
                          bike.tagline,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: isDesktop ? 20 : (isMobile ? 13 : 15),
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.85),
                            height: 1.25,
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 24),

                        // Red Action Buttons (Wrap for mobile)
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ElevatedButton(
                              onPressed: () => widget.onExploreBike(bike),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.triumphRed,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop ? 28 : (isMobile ? 14 : 20),
                                  vertical: isDesktop ? 16 : (isMobile ? 10 : 12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'VIEW BIKES',
                                    style: TextStyle(
                                      fontFamily: 'Orbitron',
                                      fontSize: isMobile ? 10 : 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(Icons.arrow_forward_rounded, size: isMobile ? 14 : 16),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () => widget.onExploreBike(bike),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white, width: 1.5),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop ? 20 : (isMobile ? 12 : 14),
                                  vertical: isDesktop ? 16 : (isMobile ? 10 : 12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: Text(
                                'TELEMETRY SPECS',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: isMobile ? 9 : 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Slide Indicators & Navigation Arrows (Bottom & Right)
          Positioned(
            bottom: 20,
            left: isDesktop ? 60 : 20,
            child: Row(
              children: List.generate(
                widget.featuredBikes.length,
                (idx) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  width: _currentIndex == idx ? 32 : 12,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _currentIndex == idx ? AppTheme.triumphRed : Colors.white38,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),

          // Next Arrow Button (Right edge)
          if (isDesktop)
            Positioned(
              right: 20,
              top: heroHeight / 2 - 24,
              child: IconButton(
                onPressed: () {
                  final nextIndex = (_currentIndex + 1) % widget.featuredBikes.length;
                  _pageController.animateToPage(
                    nextIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 28),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
