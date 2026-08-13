import 'package:flutter/material.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';

class SpecComparisonModal extends StatefulWidget {
  final List<Superbike> allBikes;
  final Superbike initialBike1;

  const SpecComparisonModal({
    super.key,
    required this.allBikes,
    required this.initialBike1,
  });

  @override
  State<SpecComparisonModal> createState() => _SpecComparisonModalState();
}

class _SpecComparisonModalState extends State<SpecComparisonModal> {
  late Superbike bike1;
  late Superbike bike2;

  @override
  void initState() {
    super.initState();
    bike1 = widget.initialBike1;
    // Default second bike to a different one if available
    bike2 = widget.allBikes.firstWhere(
      (b) => b.id != bike1.id,
      orElse: () => widget.allBikes.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 900),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.glassBorder, width: 1.5),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.compare_arrows_rounded, color: AppTheme.electricCyan, size: 28),
                    const SizedBox(width: 10),
                    const Text(
                      'TELEMETRY MATRIX COMPARISON',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8)),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bike Selectors
            Row(
              children: [
                Expanded(child: _buildBikeDropdown(bike1, (selected) {
                  if (selected != null) setState(() => bike1 = selected);
                })),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'VS',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.neonRed,
                    ),
                  ),
                ),
                Expanded(child: _buildBikeDropdown(bike2, (selected) {
                  if (selected != null) setState(() => bike2 = selected);
                })),
              ],
            ),

            const SizedBox(height: 24),

            // Comparison Metrics Rows
            _buildComparisonRow(
              'HORSEPOWER (BHP)',
              '${bike1.specs.horsepower} HP',
              '${bike2.specs.horsepower} HP',
              bike1.specs.horsepower,
              bike2.specs.horsepower,
              bike1.accentColor,
              bike2.accentColor,
            ),
            const SizedBox(height: 14),

            _buildComparisonRow(
              'TORQUE (Nm)',
              '${bike1.specs.torqueNm} Nm',
              '${bike2.specs.torqueNm} Nm',
              bike1.specs.torqueNm,
              bike2.specs.torqueNm,
              bike1.accentColor,
              bike2.accentColor,
            ),
            const SizedBox(height: 14),

            _buildComparisonRow(
              'TOP SPEED (KM/H)',
              '${bike1.specs.topSpeedKmh} KM/H',
              '${bike2.specs.topSpeedKmh} KM/H',
              bike1.specs.topSpeedKmh,
              bike2.specs.topSpeedKmh,
              bike1.accentColor,
              bike2.accentColor,
            ),
            const SizedBox(height: 14),

            _buildComparisonRow(
              '0-100 KM/H ACCELERATION',
              '${bike1.specs.acceleration0to100} s',
              '${bike2.specs.acceleration0to100} s',
              (4.0 - bike1.specs.acceleration0to100) * 100,
              (4.0 - bike2.specs.acceleration0to100) * 100,
              bike1.accentColor,
              bike2.accentColor,
            ),
            const SizedBox(height: 14),

            _buildComparisonRow(
              'DRY WEIGHT (KG)',
              '${bike1.specs.dryWeightKg} KG',
              '${bike2.specs.dryWeightKg} KG',
              (250 - bike1.specs.dryWeightKg).toDouble(),
              (250 - bike2.specs.dryWeightKg).toDouble(),
              bike1.accentColor,
              bike2.accentColor,
            ),
            const SizedBox(height: 14),

            _buildComparisonRow(
              'POWER TO WEIGHT RATIO',
              '${bike1.specs.powerToWeightRatio} HP/KG',
              '${bike2.specs.powerToWeightRatio} HP/KG',
              bike1.specs.powerToWeightRatio * 100,
              bike2.specs.powerToWeightRatio * 100,
              bike1.accentColor,
              bike2.accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBikeDropdown(Superbike current, ValueChanged<Superbike?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF161A23),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: current.accentColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Superbike>(
          value: current,
          isExpanded: true,
          dropdownColor: const Color(0xFF161A23),
          icon: Icon(Icons.arrow_drop_down, color: current.accentColor),
          items: widget.allBikes.map((bike) {
            return DropdownMenuItem<Superbike>(
              value: bike,
              child: Text(
                '${bike.brand} ${bike.name}',
                style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildComparisonRow(
    String title,
    String val1Text,
    String val2Text,
    num val1,
    num val2,
    Color color1,
    Color color2,
  ) {
    final bool isVal1Better = val1 >= val2;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF161A23),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D3548)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Rajdhani',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF94A3B8),
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Bike 1 value
              Expanded(
                child: Text(
                  val1Text,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isVal1Better ? color1 : const Color(0xFF94A3B8),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '|',
                  style: TextStyle(color: Color(0xFF2D3548), fontSize: 18),
                ),
              ),
              // Bike 2 value
              Expanded(
                child: Text(
                  val2Text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: !isVal1Better ? color2 : const Color(0xFF94A3B8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
