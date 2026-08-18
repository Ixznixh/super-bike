import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/superbike_data.dart';
import '../models/superbike_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_dialog.dart';
import '../widgets/floating_concierge_button.dart';
import '../widgets/hero_carousel_banner.dart';
import '../widgets/manufacturer_footer.dart';
import '../widgets/manufacturer_header.dart';
import '../widgets/spec_comparison_modal.dart';
import 'bike_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Superbike> localBikes = SuperbikeData.initialBikes;
  List<Superbike> cloudBikes = [];
  StreamSubscription<List<Superbike>>? _bikesSubscription;
  StreamSubscription<User?>? _authSubscription;

  User? currentUser;
  String selectedBrand = 'ALL';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    currentUser = _authService.currentUser;

    // Listen to Firebase Auth state
    _authSubscription = _authService.authStateChanges.listen((user) {
      if (mounted) {
        setState(() => currentUser = user);
      }
    });

    // Automatically sync & seed all flagship superbikes to Firebase Cloud Firestore
    _firestoreService.syncAllBikesToFirebase();

    // Listen to Firestore real-time cloud bikes stream
    try {
      _bikesSubscription = _firestoreService.bikesStream.listen((firestoreBikes) {
        if (mounted && firestoreBikes.isNotEmpty) {
          firestoreBikes.sort((a, b) => a.id.compareTo(b.id));
          setState(() {
            cloudBikes = firestoreBikes;
          });
        }
      }, onError: (err) {
        debugPrint('Firestore stream error: $err');
      });
    } catch (e) {
      debugPrint('Firestore stream init exception: $e');
    }
  }

  @override
  void dispose() {
    _bikesSubscription?.cancel();
    _authSubscription?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // Single Source of Truth: Firebase Cloud Firestore
  List<Superbike> get allBikes {
    if (cloudBikes.isNotEmpty) {
      return cloudBikes;
    }
    return localBikes;
  }

  void _openAuthDialog() {
    showDialog(
      context: context,
      builder: (context) => const AuthDialog(),
    );
  }

  void _openComparisonModal(Superbike initial) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SpecComparisonModal(allBikes: allBikes, initialBike1: initial),
      ),
    );
  }

  // Strictly limit accessible catalog to Top 5 bikes when currentUser == null
  List<Superbike> get accessibleBikes {
    if (currentUser == null) {
      return allBikes.take(5).toList();
    }
    return allBikes;
  }

  List<Superbike> get filteredBikes {
    return accessibleBikes.where((bike) {
      final matchesBrand = (selectedBrand == 'ALL') ||
          (bike.brand.toUpperCase() == selectedBrand.toUpperCase());
      final matchesQuery = searchQuery.isEmpty ||
          bike.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          bike.brand.toLowerCase().contains(searchQuery.toLowerCase()) ||
          bike.tagline.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesBrand && matchesQuery;
    }).toList();
  }

  void _onSelectBrand(String brand) {
    if (currentUser == null && brand != 'ALL') {
      final top5Brands = accessibleBikes.map((b) => b.brand.toUpperCase()).toSet();
      if (!top5Brands.contains(brand.toUpperCase())) {
        // Brand is outside top 5 preview bikes - prompt Google login dialog
        _openAuthDialog();
        return;
      }
    }
    setState(() => selectedBrand = brand);
  }

  List<String> get availableBrands {
    final set = {'ALL'};
    for (var b in allBikes) {
      set.add(b.brand.toUpperCase());
    }
    return set.toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: const Color(0xFF090B0F),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Top Manufacturer Portal Header
              SliverToBoxAdapter(
                child: ManufacturerHeader(
                  currentUser: currentUser,
                  onLoginTap: _openAuthDialog,
                  onLogoutTap: () => _authService.signOut(),
                  onNavSelect: (section) {
                    if (section == 'SUPERBIKES' || section == 'SPECS') {
                      setState(() {
                        selectedBrand = 'ALL';
                        searchQuery = '';
                      });
                    }
                  },
                ),
              ),

              // Full-Bleed Hero Carousel Slider
              if (searchQuery.isEmpty && selectedBrand == 'ALL' && accessibleBikes.isNotEmpty)
                SliverToBoxAdapter(
                  child: HeroCarouselBanner(
                    featuredBikes: accessibleBikes.take(5).toList(),
                    onExploreBike: (bike) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BikeDetailScreen(bike: bike, allBikes: allBikes),
                        ),
                      );
                    },
                  ),
                ),

              // Leaderboard Ticker Banner
              SliverToBoxAdapter(
                child: Container(
                  color: const Color(0xFF090B0F),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Icon(Icons.bolt, color: AppTheme.vividGold, size: 16),
                        const SizedBox(width: 6),
                        const Text(
                          'OFFICIAL TELEMETRY LEADERBOARD: ',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.vividGold,
                          ),
                        ),
                        ...allBikes.map((b) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              '${b.brand} ${b.name}: ${b.specs.topSpeedKmh} km/h (${b.specs.horsepower} HP)  •',
                              style: const TextStyle(
                                fontFamily: 'Rajdhani',
                                fontSize: 13,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),

              // Search and Brand Filter Controls
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) => setState(() => searchQuery = val),
                              style: const TextStyle(color: Colors.white, fontFamily: 'Rajdhani'),
                              decoration: InputDecoration(
                                hintText: 'Search by model name, brand, or community specs...',
                                hintStyle: const TextStyle(color: Color(0xFF64748B)),
                                prefixIcon: const Icon(Icons.search, color: AppTheme.triumphRed),
                                filled: true,
                                fillColor: const Color(0xFF161A23),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(color: Color(0xFF2D3548)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(color: Color(0xFF2D3548)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: const BorderSide(color: AppTheme.triumphRed),
                                ),
                              ),
                            ),
                          ),
                          if (allBikes.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            OutlinedButton.icon(
                              onPressed: () => _openComparisonModal(allBikes.first),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.vividGold,
                                side: const BorderSide(color: AppTheme.vividGold, width: 1.2),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              ),
                              icon: const Icon(Icons.compare_arrows_rounded, size: 18),
                              label: const Text(
                                'COMPARE SPECS',
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Brand Selector Pills (Triumph Red Accent)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: availableBrands.map((brand) {
                            final isSelected = selectedBrand == brand;
                            final top5Brands = accessibleBikes.map((b) => b.brand.toUpperCase()).toSet();
                            final isLockedForGuest = currentUser == null && brand != 'ALL' && !top5Brands.contains(brand);

                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                avatar: isLockedForGuest
                                    ? const Icon(Icons.lock_rounded, size: 12, color: Color(0xFF64748B))
                                    : null,
                                label: Text(
                                  brand,
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : (isLockedForGuest ? const Color(0xFF64748B) : Colors.white70),
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: AppTheme.triumphRed,
                                backgroundColor: const Color(0xFF161A23),
                                side: BorderSide(
                                  color: isSelected
                                      ? AppTheme.triumphRed
                                      : (isLockedForGuest ? const Color(0xFF1E293B) : const Color(0xFF2D3548)),
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                onSelected: (selected) {
                                  if (selected) _onSelectBrand(brand);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

          // Garage Grid Title & Unlock Pill
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 10,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 4, height: 18, color: AppTheme.triumphRed),
                      const SizedBox(width: 8),
                      Text(
                        currentUser == null
                            ? (screenWidth < 600 ? 'TOP 5 PREVIEW' : 'TOP 5 SUPERBIKES PREVIEW (5 OF 50)')
                            : 'SUPERBIKE GARAGE (${filteredBikes.length} BIKES)',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: screenWidth < 600 ? 14 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  if (currentUser == null)
                    InkWell(
                      onTap: _openAuthDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.electricCyan.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.electricCyan, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.lock_rounded, size: 12, color: AppTheme.electricCyan),
                            const SizedBox(width: 4),
                            Text(
                              screenWidth < 600 ? 'UNLOCK ALL 50' : 'LOG IN TO UNLOCK ALL 50',
                              style: const TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.electricCyan,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.neonGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.neonGreen, width: 1),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, size: 12, color: AppTheme.neonGreen),
                          SizedBox(width: 4),
                          Text(
                            'ALL 50 BIKES UNLOCKED',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.neonGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Bike Cards Grid or Locked Empty State
          if (filteredBikes.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: AppTheme.glassDecoration(borderColor: AppTheme.electricCyan),
                  child: Column(
                    children: [
                      const Icon(Icons.lock_person_rounded, size: 48, color: AppTheme.electricCyan),
                      const SizedBox(height: 16),
                      Text(
                        currentUser == null
                            ? 'BIKE OR BRAND LOCKED IN GUEST PREVIEW'
                            : 'NO SUPERBIKES MATCH YOUR FILTER',
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentUser == null
                            ? 'In guest mode, only the Top 5 Ranked Superbikes are accessible. Sign in with Google to search and unlock all 50 superbikes!'
                            : 'Try adjusting your search query or brand selector filter.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                      ),
                      if (currentUser == null) ...[
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _openAuthDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.electricCyan,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          icon: const Icon(Icons.key_rounded, size: 16),
                          label: const Text(
                            'LOG IN WITH GOOGLE TO UNLOCK ALL 50 BIKES',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 3 : (screenWidth > 600 ? 2 : 1),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isDesktop ? 0.85 : (screenWidth < 600 ? 1.05 : 0.88),
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final bike = filteredBikes[index];
                    return _buildBikeCard(bike);
                  },
                  childCount: filteredBikes.length,
                ),
              ),
            ),

          // Unlock Full Catalog Banner for Guests (Not logged in)
          if (currentUser == null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: AppTheme.glassDecoration(borderColor: AppTheme.electricCyan),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.electricCyan.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.electricCyan, width: 1.5),
                        ),
                        child: const Icon(Icons.lock_rounded, size: 36, color: AppTheme.electricCyan),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '45 MORE SUPERBIKES LOCKED',
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign in with Google to unlock all 50 ranked superbikes, deep telemetry stats, and brand history timelines.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _openAuthDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.electricCyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          elevation: 8,
                          shadowColor: AppTheme.electricCyan.withValues(alpha: 0.4),
                        ),
                        icon: const Icon(Icons.key_rounded, size: 18),
                        label: const Text(
                          'LOG IN WITH GOOGLE TO UNLOCK ALL 50 BIKES',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Official Manufacturer Portal Footer
          SliverToBoxAdapter(
            child: ManufacturerFooter(
              onNavSelect: (section) {},
            ),
          ),
        ],
      ),

        // Floating WhatsApp & Test Ride Concierge Button
        FloatingConciergeButton(
          onRequestTestRide: () => _openAuthDialog(),
        ),
      ],
    ),
  );
}

  Widget _buildBikeCard(Superbike bike) {
    return Card(
      color: const Color(0xFF161A23),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF2D3548), width: 1.2),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BikeDetailScreen(bike: bike, allBikes: allBikes),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    bike.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      color: const Color(0xFF1E2430),
                      child: const Icon(Icons.two_wheeler, size: 48, color: Color(0xFF2D3548)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: bike.accentColor),
                      ),
                      child: Text(
                        bike.brand.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: bike.accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bike.displayTitle.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bike.specs.engineType,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniStat('${bike.specs.horsepower} HP', bike.accentColor),
                      _buildMiniStat('${bike.specs.topSpeedKmh} km/h', AppTheme.electricCyan),
                      _buildMiniStat('${bike.specs.dryWeightKg} kg', AppTheme.vividGold),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(String text, Color color) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
