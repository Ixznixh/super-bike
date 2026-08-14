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
    final heroHeight = isDesktop ? 520.0 : 380.0;

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
                    left: isDesktop ? 60 : 20,
                    top: isDesktop ? 90 : 40,
                    right: isDesktop ? screenWidth * 0.4 : 20,
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
                            style: const TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Stacked Massive White Typography (Triumph Style)
                        Text(
                          bike.name.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: isDesktop ? 44 : 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.05,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtitle tagline
                        Text(
                          bike.tagline,
                          style: TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: isDesktop ? 20 : 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.85),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Red Action Buttons
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => widget.onExploreBike(bike),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.triumphRed,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop ? 28 : 20,
                                  vertical: isDesktop ? 16 : 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'VIEW BIKES',
                                    style: TextStyle(
                                      fontFamily: 'Orbitron',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 16),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () => widget.onExploreBike(bike),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white, width: 1.5),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop ? 20 : 14,
                                  vertical: isDesktop ? 16 : 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: const Text(
                                'TELEMETRY SPECS',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
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
