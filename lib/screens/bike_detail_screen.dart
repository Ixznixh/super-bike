import 'package:flutter/material.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';
import '../widgets/telemetry_gauge.dart';
import '../widgets/engine_sound_player.dart';
import '../widgets/history_timeline.dart';
import '../widgets/spec_comparison_modal.dart';

class BikeDetailScreen extends StatefulWidget {
  final Superbike bike;
  final List<Superbike> allBikes;

  const BikeDetailScreen({
    super.key,
    required this.bike,
    required this.allBikes,
  });

  @override
  State<BikeDetailScreen> createState() => _BikeDetailScreenState();
}

class _BikeDetailScreenState extends State<BikeDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openComparisonModal() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SpecComparisonModal(
          allBikes: widget.allBikes,
          initialBike1: widget.bike,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bike = widget.bike;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top App Bar
            SliverAppBar(
              backgroundColor: AppTheme.background,
              pinned: true,
              expandedHeight: isDesktop ? 340 : 260,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                OutlinedButton.icon(
                  onPressed: _openComparisonModal,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: bike.accentColor),
                    foregroundColor: bike.accentColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: const Icon(Icons.compare_arrows_rounded, size: 18),
                  label: const Text(
                    'COMPARE SPECS',
                    style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      bike.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0FF161A23),
                        child: const Icon(Icons.two_wheeler, size: 80, color: Color(0FF2D3548)),
                      ),
                    ),
                    // Dark Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            AppTheme.background.withOpacity(0.85),
                            AppTheme.background,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 24,
                      right: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: bike.accentColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: bike.accentColor),
                            ),
                            child: Text(
                              '${bike.brand.toUpperCase()} | MODEL YEAR ${bike.year}',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: bike.accentColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            bike.name.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: isDesktop ? 32 : 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            bike.tagline,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color(0FF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Content Area
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Engine Sound Simulator Widget
                    EngineSoundPlayer(
                      bikeName: bike.name,
                      engineNoteDescription: bike.engineNoteDescription,
                      accentColor: bike.accentColor,
                      redlineRpm: bike.specs.rpmRedline,
                    ),

                    const SizedBox(height: 24),

                    // Tab Navigation Header
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0FF2D3548), width: 1.5)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: bike.accentColor,
                        indicatorWeight: 3,
                        labelColor: bike.accentColor,
                        unselectedLabelColor: const Color(0FF94A3B8),
                        labelStyle: const TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                        tabs: const [
                          Tab(text: 'TELEMETRY HUD'),
                          Tab(text: 'BRAND HISTORY'),
                          Tab(text: 'ELECTRONICS'),
                          Tab(text: 'FULL SPECS'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tab View Body
                    SizedBox(
                      height: isDesktop ? 650 : 800,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildTelemetryTab(bike, isDesktop),
                          HistoryTimelineWidget(
                            history: bike.history,
                            brandName: bike.brand,
                            accentColor: bike.accentColor,
                          ),
                          _buildElectronicsTab(bike),
                          _buildFullSpecsTab(bike),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryTab(Superbike bike, bool isDesktop) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Radial Gauges Row
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.spaceAround,
            children: [
              TelemetryGauge(
                value: bike.specs.horsepower.toDouble(),
                maxValue: 350,
                label: 'Horsepower',
                unit: 'BHP',
                color: bike.accentColor,
              ),
              TelemetryGauge(
                value: bike.specs.topSpeedKmh.toDouble(),
                maxValue: 420,
                label: 'Top Speed',
                unit: 'KM/H',
                color: AppTheme.electricCyan,
              ),
              TelemetryGauge(
                value: bike.specs.torqueNm.toDouble(),
                maxValue: 180,
                label: 'Torque',
                unit: 'Nm',
                color: AppTheme.vividGold,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Linear Telemetry Performance Bars
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PERFORMANCE TELEMETRY RATIOS',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: bike.accentColor,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                TelemetryBar(
                  label: 'Power-to-Weight Ratio',
                  valueText: '${bike.specs.powerToWeightRatio} HP/KG',
                  percentage: (bike.specs.powerToWeightRatio / 1.8),
                  color: bike.accentColor,
                ),
                const SizedBox(height: 14),
                TelemetryBar(
                  label: '0-100 KM/H Sprint Time',
                  valueText: '${bike.specs.acceleration0to100} SEC',
                  percentage: (4.0 - bike.specs.acceleration0to100) / 2.0,
                  color: AppTheme.electricCyan,
                ),
                const SizedBox(height: 14),
                TelemetryBar(
                  label: 'Dry Chassis Weight',
                  valueText: '${bike.specs.dryWeightKg} KG',
                  percentage: (220 - bike.specs.dryWeightKg) / 70,
                  color: AppTheme.vividGold,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Highlights Bullet Points
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0FF161A23),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0FF2D3548)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ENGINEERING HIGHLIGHTS',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...bike.highlights.map((highlight) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.flash_on_rounded, size: 18, color: bike.accentColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            highlight,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color(0FFF0F4F8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElectronicsTab(Superbike bike) {
    final elec = bike.electronics;
    final List<Map<String, String>> items = [
      {'title': 'Traction Control', 'desc': elec.tractionControl, 'icon': 'settings_remote'},
      {'title': 'Wheelie Control', 'desc': elec.wheelieControl, 'icon': 'trending_up'},
      {'title': 'Launch Control', 'desc': elec.launchControl, 'icon': 'speed'},
      {'title': 'Cornering ABS', 'desc': elec.corneringAbs, 'icon': 'shield'},
      {'title': 'Quickshifter System', 'desc': elec.quickshifter, 'icon': 'bolt'},
      {'title': 'Electronic Suspension', 'desc': elec.suspension, 'icon': 'tune'},
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0FF161A23),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0FF2D3548)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bike.accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.memory_rounded, color: bike.accentColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item['desc']!,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color(0FF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFullSpecsTab(Superbike bike) {
    final specs = bike.specs;
    final List<Map<String, String>> rows = [
      {'label': 'Engine Configuration', 'value': specs.engineType},
      {'label': 'Displacement', 'value': '${specs.displacementCc} cc'},
      {'label': 'Maximum Horsepower', 'value': '${specs.horsepower} HP @ ${specs.rpmRedline} RPM'},
      {'label': 'Peak Torque', 'value': '${specs.torqueNm} Nm'},
      {'label': 'Top Speed', 'value': '${specs.topSpeedKmh} km/h'},
      {'label': '0 to 100 km/h', 'value': '${specs.acceleration0to100} seconds'},
      {'label': 'Dry Weight', 'value': '${specs.dryWeightKg} kg'},
      {'label': 'Power-to-Weight Ratio', 'value': '${specs.powerToWeightRatio} HP/kg'},
      {'label': 'Transmission', 'value': specs.transmission},
      {'label': 'MSRP Price Estimate', 'value': bike.priceEstimate},
    ];

    return ListView.separated(
      itemCount: rows.length,
      separatorBuilder: (context, index) => const Divider(color: Color(0FF2D3548), height: 1),
      itemBuilder: (context, index) {
        final row = rows[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                row['label']!,
                style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0FF94A3B8),
                ),
              ),
              Expanded(
                child: Text(
                  row['value']!,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: bike.accentColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
