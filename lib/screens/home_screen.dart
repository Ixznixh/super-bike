import 'package:flutter/material.dart';
import '../data/superbike_data.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';
import '../widgets/add_bike_dialog.dart';
import '../widgets/engine_sound_player.dart';
import '../widgets/spec_comparison_modal.dart';
import 'bike_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Superbike> bikes;
  String selectedBrand = 'ALL';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bikes = SuperbikeData.initialBikes;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onAddCustomBike(Superbike newBike) {
    setState(() {
      bikes.insert(0, newBike);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.electricCyan,
        content: Text(
          '${newBike.name} added to Telemetry Garage!',
          style: const TextStyle(color: Colors.black, fontFamily: 'Orbitron', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _openAddBikeDialog() {
    showDialog(
      context: context,
      builder: (context) => AddBikeDialog(onAddBike: _onAddCustomBike),
    );
  }

  void _openComparisonModal(Superbike initial) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SpecComparisonModal(allBikes: bikes, initialBike1: initial),
      ),
    );
  }

  List<Superbike> get filteredBikes {
    return bikes.where((bike) {
      final matchesBrand = (selectedBrand == 'ALL') ||
          (bike.brand.toUpperCase() == selectedBrand.toUpperCase());
      final matchesQuery = searchQuery.isEmpty ||
          bike.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          bike.brand.toLowerCase().contains(searchQuery.toLowerCase()) ||
          bike.tagline.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesBrand && matchesQuery;
    }).toList();
  }

  List<String> get availableBrands {
    final set = {'ALL'};
    for (var b in bikes) {
      set.add(b.brand.toUpperCase());
    }
    return set.toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final featuredBike = bikes.isNotEmpty ? bikes.first : null;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.two_wheeler_rounded, color: AppTheme.neonRed, size: 28),
            const SizedBox(width: 10),
            Text(
              'APEX VELOCITY',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: isDesktop ? 20 : 16,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.neonRed.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppTheme.neonRed, width: 0.8),
              ),
              child: const Text(
                'HUD 3.0',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.neonRed,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Add Superbike',
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppTheme.electricCyan),
            onPressed: _openAddBikeDialog,
          ),
          if (bikes.isNotEmpty)
            IconButton(
              tooltip: 'Compare Specs',
              icon: const Icon(Icons.compare_arrows_rounded, color: AppTheme.vividGold),
              onPressed: () => _openComparisonModal(bikes.first),
            ),
          const SizedBox(width: 12),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Leaderboard Ticker Banner
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0FF0D1017),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.bolt, color: AppTheme.vividGold, size: 16),
                    const SizedBox(width: 6),
                    const Text(
                      'TOP SPEED LEADERBOARD: ',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.vividGold,
                      ),
                    ),
                    ...bikes.map((b) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          '${b.brand} ${b.name}: ${b.specs.topSpeedKmh} km/h (${b.specs.horsepower} HP)  •',
                          style: const TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 13,
                            color: Color(0FF94A3B8),
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
                  // Search Bar & Add Button Row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => setState(() => searchQuery = val),
                          style: const TextStyle(color: Colors.white, fontFamily: 'Rajdhani'),
                          decoration: InputDecoration(
                            hintText: 'Search by model name, brand, or specs...',
                            hintStyle: const TextStyle(color: Color(0FF64748B)),
                            prefixIcon: const Icon(Icons.search, color: AppTheme.electricCyan),
                            filled: true,
                            fillColor: const Color(0FF161A23),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0FF2D3548)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0FF2D3548)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.electricCyan),
                            ),
                          ),
                        ),
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: _openAddBikeDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.electricCyan,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.add, size: 20),
                          label: const Text(
                            'ADD SUPERBIKE',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Brand Selector Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: availableBrands.map((brand) {
                        final isSelected = selectedBrand == brand;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              brand,
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.white,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: AppTheme.electricCyan,
                            backgroundColor: const Color(0FF161A23),
                            side: BorderSide(
                              color: isSelected ? AppTheme.electricCyan : const Color(0FF2D3548),
                            ),
                            onSelected: (selected) {
                              if (selected) setState(() => selectedBrand = brand);
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

          // Featured Hero Superbike Banner
          if (featuredBike != null && searchQuery.isEmpty && selectedBrand == 'ALL')
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: _buildHeroBanner(featuredBike, isDesktop),
              ),
            ),

          // Garage Grid Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(width: 4, height: 18, color: AppTheme.neonRed),
                      const SizedBox(width: 8),
                      Text(
                        'SUPERBIKE GARAGE (${filteredBikes.length})',
                        style: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bike Cards Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : (screenWidth > 600 ? 2 : 1),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isDesktop ? 0.85 : 0.88,
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
        ],
      ),
    );
  }

  Widget _buildHeroBanner(Superbike bike, bool isDesktop) {
    return Container(
      decoration: AppTheme.glassDecoration(borderColor: bike.accentColor),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                bike.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: const Color(0FF161A23)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.92),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.neonRed,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'FEATURED FLAGSHIP',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${bike.brand} ${bike.name}'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: isDesktop ? 26 : 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bike.tagline,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Color(0FF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildQuickSpecBadge('${bike.specs.horsepower} HP', bike.accentColor),
                      const SizedBox(width: 8),
                      _buildQuickSpecBadge('${bike.specs.topSpeedKmh} KM/H', AppTheme.electricCyan),
                      const SizedBox(width: 8),
                      _buildQuickSpecBadge('${bike.specs.acceleration0to100}s 0-100', AppTheme.vividGold),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BikeDetailScreen(bike: bike, allBikes: bikes),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bike.accentColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'ENTER TELEMETRY DASHBOARD',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSpecBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0FF161A23).withOpacity(0.9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Orbitron',
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBikeCard(Superbike bike) {
    return Card(
      color: const Color(0FF161A23),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0FF2D3548), width: 1.2),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BikeDetailScreen(bike: bike, allBikes: bikes),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Preview Container
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    bike.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      color: const Color(0FF1E2430),
                      child: const Icon(Icons.two_wheeler, size: 48, color: Color(0FF2D3548)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
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

            // Card Body Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bike.name.toUpperCase(),
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
                      color: Color(0FF94A3B8),
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
