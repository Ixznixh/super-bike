import 'package:flutter/material.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';

class AddBikeDialog extends StatefulWidget {
  final ValueChanged<Superbike> onAddBike;

  const AddBikeDialog({super.key, required this.onAddBike});

  @override
  State<AddBikeDialog> createState() => _AddBikeDialogState();
}

class _AddBikeDialogState extends State<AddBikeDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _taglineController = TextEditingController();
  final _yearController = TextEditingController(text: '2025');
  final _priceController = TextEditingController(text: '\$35,000');
  final _imageUrlController = TextEditingController(
    text: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
  );

  final _hpController = TextEditingController(text: '210');
  final _torqueController = TextEditingController(text: '115');
  final _topSpeedController = TextEditingController(text: '310');
  final _accelController = TextEditingController(text: '2.8');
  final _weightController = TextEditingController(text: '172');
  final _engineTypeController = TextEditingController(text: '998cc Inline 4-Cylinder');
  final _racingTitlesController = TextEditingController(text: 'Multiple World Championships');
  final _legendStoryController = TextEditingController(
    text: 'Engineered for relentless track precision and road dominance.',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _taglineController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _hpController.dispose();
    _torqueController.dispose();
    _topSpeedController.dispose();
    _accelController.dispose();
    _weightController.dispose();
    _engineTypeController.dispose();
    _racingTitlesController.dispose();
    _legendStoryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final hp = int.tryParse(_hpController.text) ?? 200;
      final weight = int.tryParse(_weightController.text) ?? 170;
      final ratio = (hp / weight);

      final newBike = Superbike(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        brand: _brandController.text.trim(),
        tagline: _taglineController.text.trim(),
        year: int.tryParse(_yearController.text) ?? 2025,
        priceEstimate: _priceController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        accentColor: AppTheme.electricCyan,
        specs: TelemetrySpecs(
          horsepower: hp,
          torqueNm: int.tryParse(_torqueController.text) ?? 110,
          topSpeedKmh: int.tryParse(_topSpeedController.text) ?? 300,
          acceleration0to100: double.tryParse(_accelController.text) ?? 2.9,
          dryWeightKg: weight,
          powerToWeightRatio: double.parse(ratio.toStringAsFixed(2)),
          rpmRedline: 15000,
          engineType: _engineTypeController.text.trim(),
          displacementCc: 998,
          transmission: '6-speed quickshift transmission',
        ),
        electronics: const ElectronicsPackage(
          tractionControl: 'Multi-stage lean angle TC',
          wheelieControl: 'Adjustable Anti-wheelie',
          launchControl: 'Race Launch Assistant',
          corneringAbs: 'Lean-sensitive Cornering ABS',
          quickshifter: 'Bi-directional Quickshifter',
          suspension: 'Electronic Semi-Active Suspension',
        ),
        history: BrandHistory(
          foundingYear: 1950,
          founderName: _brandController.text.trim(),
          headquarters: 'Global',
          racingTitles: _racingTitlesController.text.trim(),
          legendStory: _legendStoryController.text.trim(),
          milestones: [
            MilestoneModel(
              year: int.tryParse(_yearController.text) ?? 2025,
              name: _nameController.text.trim(),
              description: 'Latest custom model entry added into the Telemetry Garage.',
            ),
          ],
        ),
        highlights: [
          'Custom telemetry configured model',
          'High performance-to-weight chassis',
        ],
        engineNoteDescription: 'Custom high-rev exhaust resonance.',
      );

      widget.onAddBike(newBike);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ADD CUSTOM SUPERBIKE',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.electricCyan,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildTextField(_brandController, 'Brand Name (e.g. Aprilia, Honda)'),
                _buildTextField(_nameController, 'Model Name (e.g. RSV4 Factory)'),
                _buildTextField(_taglineController, 'Tagline'),
                _buildTextField(_priceController, 'Price Estimate'),
                _buildTextField(_imageUrlController, 'Image Web URL'),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Color(0xFF2D3548)),
                ),

                const Text(
                  'TELEMETRY SPECS',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(child: _buildTextField(_hpController, 'Horsepower (HP)', isNumber: true)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField(_torqueController, 'Torque (Nm)', isNumber: true)),
                  ],
                ),

                Row(
                  children: [
                    Expanded(child: _buildTextField(_topSpeedController, 'Top Speed (km/h)', isNumber: true)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField(_weightController, 'Dry Weight (kg)', isNumber: true)),
                  ],
                ),

                _buildTextField(_accelController, '0-100 km/h (seconds)', isNumber: true),
                _buildTextField(_engineTypeController, 'Engine Configuration'),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.electricCyan,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'ADD TO GARAGE DATABASE',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white, fontFamily: 'Rajdhani', fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
          filled: true,
          fillColor: const Color(0xFF161A23),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2D3548)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2D3548)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppTheme.electricCyan),
          ),
        ),
        validator: (val) {
          if (val == null || val.trim().isEmpty) return 'Field required';
          return null;
        },
      ),
    );
  }
}
