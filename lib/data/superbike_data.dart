import 'package:flutter/material.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';

class SuperbikeData {
  static const Color ktmOrange = Color(0xFFFF6600);
  static const Color apriliaRed = Color(0xFFFF1A1A);
  static const Color hondaRed = Color(0xFFE60012);
  static const Color suzukiBlue = Color(0xFF003399);
  static const Color triumphSilver = Color(0xFFC0C0C0);

  static List<Superbike> get initialBikes => [
    // 1. Ducati Panigale V4 R
    Superbike(
      id: 'bike-01-panigale-v4r',
      name: 'Ducati Panigale V4 R',
      brand: 'Ducati',
      tagline: '#1 🇮🇹 Italy | 998cc V4 | 240 HP Flagship',
      year: 2024,
      priceEstimate: '\$44,995',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 240, torqueNm: 112, topSpeedKmh: 315, acceleration0to100: 2.7,
        dryWeightKg: 167, powerToWeightRatio: 1.43, rpmRedline: 16500,
        engineType: '998cc Desmosedici Stradale R 90° V4', displacementCc: 998,
        transmission: '6-speed with Ducati Quick Shift EVO 2',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 3', wheelieControl: 'DWC EVO', launchControl: 'DPL EVO',
        corneringAbs: 'Bosch Cornering ABS EVO', quickshifter: 'DQS EVO 2 Up/Down',
        suspension: 'Fully Adjustable Öhlins NPX 25/30 Pressurized Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Antonio Cavalieri Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: '15 WSBK World Championships, 4 MotoGP Titles',
        legendStory: 'Official Ducati Press: Homologated MotoGP engine technology for street and track supremacy.',
        milestones: [MilestoneModel(year: 2024, name: 'Panigale V4 R', description: '240 HP homologated racer.')],
      ),
      highlights: ['Carbon fiber aero winglets', 'Dry clutch assembly', 'Variable intake horns'],
      engineNoteDescription: 'Desmodromic V4 racing exhaust.',
    ),

    // 2. BMW M 1000 RR
    Superbike(
      id: 'bike-02-bmw-m1000rr',
      name: 'BMW M 1000 RR',
      brand: 'BMW Motorrad',
      tagline: '#2 🇩🇪 Germany | 999cc I4 | M Motorsport Homologation',
      year: 2024,
      priceEstimate: '\$37,995',
      imageUrl: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.bmwBlue,
      specs: const TelemetrySpecs(
        horsepower: 212, torqueNm: 113, topSpeedKmh: 314, acceleration0to100: 2.9,
        dryWeightKg: 170, powerToWeightRatio: 1.24, rpmRedline: 15100,
        engineType: '999cc Inline 4-Cylinder ShiftCam', displacementCc: 999,
        transmission: '6-speed constant-mesh gearbox',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 6-axis IMU', wheelieControl: 'DTC Wheelie Control', launchControl: 'Launch Control & Pit Limiter',
        corneringAbs: 'ABS Pro Race', quickshifter: 'Shift Assistant Pro', suspension: 'Marzocchi 45mm DDC Damping',
      ),
      history: const BrandHistory(
        foundingYear: 1923, founderName: 'Max Friz', headquarters: 'Munich, Germany 🇩🇪',
        racingTitles: 'Isle of Man TT Winner', legendStory: 'Official BMW Motorrad Press: M Motorsport winglets and ShiftCam technology.',
        milestones: [MilestoneModel(year: 2024, name: 'M 1000 RR', description: 'M Motorsport Superbike.')],
      ),
      highlights: ['BMW ShiftCam Technology', 'M Carbon Wheels', 'M Aero Winglets'],
      engineNoteDescription: 'Crisp ShiftCam inline-4 exhaust note.',
    ),

    // 3. Aprilia RSV4 Factory
    Superbike(
      id: 'bike-03-aprilia-rsv4-factory',
      name: 'Aprilia RSV4 Factory',
      brand: 'Aprilia',
      tagline: '#3 🇮🇹 Italy | 1,099cc V4 | 217 HP Track Domination',
      year: 2024,
      priceEstimate: '\$25,999',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: apriliaRed,
      specs: const TelemetrySpecs(
        horsepower: 217, torqueNm: 125, topSpeedKmh: 305, acceleration0to100: 2.8,
        dryWeightKg: 177, powerToWeightRatio: 1.22, rpmRedline: 13500,
        engineType: '1,099cc 65° V4 4-stroke', displacementCc: 1099,
        transmission: '6-speed with Aprilia Quick Shift (AQS)',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'APRC (Aprilia Performance Ride Control)', wheelieControl: 'AWC (Aprilia Wheelie Control)',
        launchControl: 'ALC (Aprilia Launch Control)', corneringAbs: 'Bosch 9.3 MP ABS',
        quickshifter: 'AQS Up/Down', suspension: 'Öhlins Smart EC 2.0 Semi-Active',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Alberto Beggio', headquarters: 'Noale, Italy 🇮🇹',
        racingTitles: '54 World Titles (WSBK & GP)', legendStory: 'Official Aprilia Racing Press: 54 World Titles born in Noale, Italy.',
        milestones: [MilestoneModel(year: 2024, name: 'RSV4 Factory', description: '217 HP 1,099cc V4 Superbike.')],
      ),
      highlights: ['Integrated winglet fairing', 'Öhlins Smart EC 2.0 suspension', 'Lightweight forged aluminum wheels'],
      engineNoteDescription: 'Roaring 65° V4 exhaust resonance.',
    ),

    // 4. Ducati Panigale V4 S
    Superbike(
      id: 'bike-04-panigale-v4s',
      name: 'Ducati Panigale V4 S',
      brand: 'Ducati',
      tagline: '#4 🇮🇹 Italy | 1,103cc V4 | 215.5 HP Electronic Suspension',
      year: 2024,
      priceEstimate: '\$32,195',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 215, torqueNm: 124, topSpeedKmh: 300, acceleration0to100: 2.8,
        dryWeightKg: 174, powerToWeightRatio: 1.23, rpmRedline: 14500,
        engineType: '1,103cc Desmosedici Stradale V4', displacementCc: 1103,
        transmission: '6-speed DQS Up/Down EVO 2',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 3', wheelieControl: 'DWC EVO', launchControl: 'DPL EVO',
        corneringAbs: 'Bosch Cornering ABS EVO', quickshifter: 'DQS EVO 2', suspension: 'Öhlins NPX 25/30 Electronic',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Antonio Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: '15 WSBK Titles', legendStory: 'Official Ducati Press: Desmosedici V4 engine paired with electronic Öhlins Smart EC suspension.',
        milestones: [MilestoneModel(year: 2024, name: 'Panigale V4 S', description: '1,103cc V4 Street Legal Weapon.')],
      ),
      highlights: ['Öhlins Smart EC 2.0 electronic suspension', 'Marchesini forged aluminum wheels', 'Desmosedici V4 engine'],
      engineNoteDescription: 'Guttural 1,103cc V4 exhaust tone.',
    ),

    // 5. Kawasaki Ninja H2R
    Superbike(
      id: 'bike-05-ninja-h2r',
      name: 'Kawasaki Ninja H2R',
      brand: 'Kawasaki',
      tagline: '#5 🇯🇵 Japan | 998cc Supercharged I4 | 326 HP 400 km/h Beast',
      year: 2024,
      priceEstimate: '\$58,000',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 326, torqueNm: 165, topSpeedKmh: 400, acceleration0to100: 2.2,
        dryWeightKg: 193, powerToWeightRatio: 1.68, rpmRedline: 14000,
        engineType: '998cc Supercharged Inline-4', displacementCc: 998,
        transmission: '6-speed dog-ring transmission',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC 9-mode', wheelieControl: 'KLCM Launch Control', launchControl: 'KLCM Integrated',
        corneringAbs: 'KIBS ABS System', quickshifter: 'KQS Quick Shifter', suspension: 'Öhlins TTX36 Shock & KYB Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Shozo Kawasaki', headquarters: 'Minato, Tokyo, Japan 🇯🇵',
        racingTitles: '7 WSBK Championships', legendStory: 'Official Kawasaki Press: Centrifugal supercharger engineered by Kawasaki Heavy Industries Aerospace.',
        milestones: [MilestoneModel(year: 2024, name: 'Ninja H2R', description: '326 HP supercharged track monster.')],
      ),
      highlights: ['Centrifugal supercharger spinning at 130k RPM', 'Carbon aero wings', 'Silver mirror self-healing paint'],
      engineNoteDescription: 'Supercharger flutter with 326 HP inline-4 scream.',
    ),

    // 6. Honda CBR1000RR-R Fireblade SP
    Superbike(
      id: 'bike-06-honda-fireblade-sp',
      name: 'Honda CBR1000RR-R Fireblade SP',
      brand: 'Honda',
      tagline: '#6 🇯🇵 Japan | 999cc I4 | 215 HP Born to Race',
      year: 2024,
      priceEstimate: '\$28,900',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: hondaRed,
      specs: const TelemetrySpecs(
        horsepower: 215, torqueNm: 113, topSpeedKmh: 299, acceleration0to100: 2.7,
        dryWeightKg: 180, powerToWeightRatio: 1.19, rpmRedline: 14500,
        engineType: '999cc Liquid-Cooled Inline 4-Cylinder', displacementCc: 999,
        transmission: '6-speed with Quickshifter',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'HSTC (Honda Selectable Torque Control)', wheelieControl: 'Wheelie Control 3-level',
        launchControl: 'Start Mode Launch Control', corneringAbs: 'Braking ABS Sport/Track',
        quickshifter: 'Quickshifter Standard', suspension: 'Öhlins NPX Smart EC 3.0',
      ),
      history: const BrandHistory(
        foundingYear: 1948, founderName: 'Soichiro Honda', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: '800+ Grand Prix Wins', legendStory: 'Official Honda HRC Press: RC213V-S MotoGP titanium engine architecture.',
        milestones: [MilestoneModel(year: 2024, name: 'CBR1000RR-R SP', description: 'RC213V-S MotoGP engine tech.')],
      ),
      highlights: ['RC213V-S MotoGP titanium conrods', 'Brembo Stylema calipers', 'Öhlins Smart EC suspension'],
      engineNoteDescription: 'High-pitch screamer inline-4 exhaust.',
    ),

    // 7. BMW S 1000 RR
    Superbike(
      id: 'bike-07-bmw-s1000rr',
      name: 'BMW S 1000 RR',
      brand: 'BMW Motorrad',
      tagline: '#7 🇩🇪 Germany | 999cc I4 | 205 HP ShiftCam Leader',
      year: 2024,
      priceEstimate: '\$18,295',
      imageUrl: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.bmwBlue,
      specs: const TelemetrySpecs(
        horsepower: 205, torqueNm: 113, topSpeedKmh: 303, acceleration0to100: 2.9,
        dryWeightKg: 175, powerToWeightRatio: 1.17, rpmRedline: 14600,
        engineType: '999cc Inline-4 ShiftCam', displacementCc: 999,
        transmission: '6-speed with Shift Assistant Pro',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 6-axis', wheelieControl: 'DTC Wheelie', launchControl: 'Launch Control',
        corneringAbs: 'ABS Pro', quickshifter: 'Shift Assistant Pro', suspension: 'Marzocchi USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1923, founderName: 'Karl Rapp', headquarters: 'Munich, Germany 🇩🇪',
        racingTitles: 'WSBK & Isle of Man TT', legendStory: 'Official BMW Motorrad Press: ShiftCam variable valve timing benchmark.',
        milestones: [MilestoneModel(year: 2024, name: 'S 1000 RR', description: '205 HP ShiftCam superbike.')],
      ),
      highlights: ['ShiftCam variable valve timing', 'Winglet aerodynamic downforce', 'Flex Frame chassis'],
      engineNoteDescription: 'Precise high-rpm German inline-4 soundtrack.',
    ),

    // 8. Kawasaki Ninja ZX-10RR
    Superbike(
      id: 'bike-08-ninja-zx10rr',
      name: 'Kawasaki Ninja ZX-10RR',
      brand: 'Kawasaki',
      tagline: '#8 🇯🇵 Japan | 998cc I4 | 214 HP WSBK Winner',
      year: 2024,
      priceEstimate: '\$30,499',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 214, torqueNm: 112, topSpeedKmh: 300, acceleration0to100: 2.8,
        dryWeightKg: 181, powerToWeightRatio: 1.18, rpmRedline: 14700,
        engineType: '998cc Inline 4-Cylinder Pankl Pistons', displacementCc: 998,
        transmission: '6-speed cassette type',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'S-KTRC', wheelieControl: 'KLCM', launchControl: 'KLCM',
        corneringAbs: 'KIBS', quickshifter: 'KQS', suspension: 'Showa Balance Free Front Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: '6 Consecutive WSBK Titles', legendStory: 'Official Kawasaki Press: Pankl titanium connecting rods & Marchesini forged rims.',
        milestones: [MilestoneModel(year: 2024, name: 'ZX-10RR', description: 'Pankl titanium rods & Marchesini rims.')],
      ),
      highlights: ['Pankl titanium connecting rods', 'Marchesini forged wheels', 'Aerodynamic integrated winglets'],
      engineNoteDescription: 'Screaming WSBK race tuned inline-4.',
    ),

    // 9. Ducati Streetfighter V4 SP2
    Superbike(
      id: 'bike-09-streetfighter-v4-sp2',
      name: 'Ducati Streetfighter V4 SP2',
      brand: 'Ducati',
      tagline: '#9 🇮🇹 Italy | 1,103cc V4 | 208 HP Hyper Naked Track Spec',
      year: 2024,
      priceEstimate: '\$37,995',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 208, torqueNm: 123, topSpeedKmh: 290, acceleration0to100: 2.8,
        dryWeightKg: 177, powerToWeightRatio: 1.17, rpmRedline: 14500,
        engineType: '1,103cc Desmosedici Stradale V4', displacementCc: 1103,
        transmission: '6-speed DQS Up/Down EVO 2',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 3', wheelieControl: 'DWC EVO', launchControl: 'DPL EVO',
        corneringAbs: 'Bosch Cornering ABS', quickshifter: 'DQS EVO 2', suspension: 'Öhlins Smart EC 2.0',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'MotoGP World Champions', legendStory: 'Official Ducati Press: Carbon rims and STM SBK dry clutch in Winter Test livery.',
        milestones: [MilestoneModel(year: 2024, name: 'Streetfighter SP2', description: 'Carbon rims & STM dry clutch.')],
      ),
      highlights: ['STM-EVO SBK dry clutch', 'Carbon fiber rims', 'Winter Test livery'],
      engineNoteDescription: 'Dry clutch rattle with 208 HP V4 roar.',
    ),

    // 10. Yamaha YZF-R1M
    Superbike(
      id: 'bike-10-yzf-r1m',
      name: 'Yamaha YZF-R1M',
      brand: 'Yamaha',
      tagline: '#10 🇯🇵 Japan | 998cc I4 | 200 HP Crossplane CP4 Icon',
      year: 2024,
      priceEstimate: '\$27,699',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.electricCyan,
      specs: const TelemetrySpecs(
        horsepower: 200, torqueNm: 112, topSpeedKmh: 299, acceleration0to100: 2.8,
        dryWeightKg: 177, powerToWeightRatio: 1.13, rpmRedline: 14500,
        engineType: '998cc Crossplane CP4 Inline-4', displacementCc: 998,
        transmission: '6-speed multi-plate slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'TCS Lean Angle', wheelieControl: 'LIF Control', launchControl: 'LCS System',
        corneringAbs: 'BC Brake Control', quickshifter: 'QSS 2-way', suspension: 'Öhlins Electronic ERS NPX',
      ),
      history: const BrandHistory(
        foundingYear: 1955, founderName: 'Genichi Kawakami', headquarters: 'Iwata, Japan 🇯🇵',
        racingTitles: '18 MotoGP World Titles', legendStory: 'Official Yamaha Racing Press: Carbon bodywork and Öhlins ERS inspired by MotoGP YZR-M1.',
        milestones: [MilestoneModel(year: 2024, name: 'YZF-R1M', description: 'Carbon bodywork & Öhlins ERS.')],
      ),
      highlights: ['CP4 crossplane firing order (270°-180°-90°-180°)', 'Carbon bodywork', 'CCU telemetry telemetry logger'],
      engineNoteDescription: 'Guttural V4-like crossplane CP4 roar.',
    ),

    // 11. MV Agusta Brutale 1000 RR
    Superbike(
      id: 'bike-11-brutale-1000-rr',
      name: 'MV Agusta Brutale 1000 RR',
      brand: 'MV Agusta',
      tagline: '#11 🇮🇹 Italy | 998cc I4 | 208 HP Hyper Naked Art',
      year: 2024,
      priceEstimate: '\$37,798',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.vividGold,
      specs: const TelemetrySpecs(
        horsepower: 208, torqueNm: 1165, topSpeedKmh: 300, acceleration0to100: 2.8,
        dryWeightKg: 186, powerToWeightRatio: 1.11, rpmRedline: 13400,
        engineType: '998cc 16-valve radial valve inline-4', displacementCc: 998,
        transmission: '6-speed cassette type with EAS 3.0',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'MVICS 8-level', wheelieControl: 'FLC Front Lift Control', launchControl: 'Launch Assist',
        corneringAbs: 'Continental MK100 ABS', quickshifter: 'EAS 3.0 Up/Down', suspension: 'Öhlins Nix EC Electronic',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Domenico Agusta', headquarters: 'Varese, Italy 🇮🇹',
        racingTitles: '38 World Rider Championships', legendStory: 'Official MV Agusta Press: Motorcycle Art with Ferrari F1 radial valve head.',
        milestones: [MilestoneModel(year: 2024, name: 'Brutale 1000 RR', description: '208 HP hyper naked artwork.')],
      ),
      highlights: ['Ferrari F1 radial valve arrangement', 'Öhlins electronic suspension', 'Full carbon fiber body panels'],
      engineNoteDescription: 'Screaming F1-style radial valve inline-4.',
    ),

    // 12. MV Agusta Rush 1000
    Superbike(
      id: 'bike-12-rush-1000',
      name: 'MV Agusta Rush 1000',
      brand: 'MV Agusta',
      tagline: '#12 🇮🇹 Italy | 998cc I4 | 208 HP Drag Strip Concept',
      year: 2024,
      priceEstimate: '\$50,098',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.vividGold,
      specs: const TelemetrySpecs(
        horsepower: 208, torqueNm: 1165, topSpeedKmh: 300, acceleration0to100: 2.8,
        dryWeightKg: 186, powerToWeightRatio: 1.11, rpmRedline: 13400,
        engineType: '998cc Inline-4 Radial Valves', displacementCc: 998,
        transmission: '6-speed cassette type',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'MVICS 2.1', wheelieControl: 'FLC Wheelie Control', launchControl: 'Launch Mode',
        corneringAbs: 'Continental MK100 ABS', quickshifter: 'EAS 3.0', suspension: 'Öhlins EC Electronic',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Count Agusta', headquarters: 'Varese, Italy 🇮🇹',
        racingTitles: '38 World Titles', legendStory: 'Official MV Agusta Press: Limited edition 300 unit drag racing concept bike.',
        milestones: [MilestoneModel(year: 2024, name: 'Rush 1000', description: 'Limited edition 300 units drag concept.')],
      ),
      highlights: ['Carbon rear wheel cover disc', 'SC Project dual exhaust', 'Fighter jet LED headlight'],
      engineNoteDescription: 'Aggressive SC Project dual exhaust scream.',
    ),

    // 13. Ducati Streetfighter V4
    Superbike(
      id: 'bike-13-streetfighter-v4',
      name: 'Ducati Streetfighter V4',
      brand: 'Ducati',
      tagline: '#13 🇮🇹 Italy | 1,103cc V4 | 208 HP Fight Formula',
      year: 2024,
      priceEstimate: '\$22,095',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 208, torqueNm: 123, topSpeedKmh: 285, acceleration0to100: 2.9,
        dryWeightKg: 180, powerToWeightRatio: 1.15, rpmRedline: 14500,
        engineType: '1,103cc Desmosedici Stradale V4', displacementCc: 1103,
        transmission: '6-speed DQS EVO 2',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 3', wheelieControl: 'DWC EVO', launchControl: 'DPL EVO',
        corneringAbs: 'Bosch Cornering ABS', quickshifter: 'DQS EVO 2', suspension: 'Showa BPF Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'WSBK Champions', legendStory: 'Official Ducati Press: The Fight Formula stripping the Panigale fairing and adding biplane wings.',
        milestones: [MilestoneModel(year: 2024, name: 'Streetfighter V4', description: '208 HP Desmosedici V4 Naked.')],
      ),
      highlights: ['Biplane aerodynamic wings (28kg downforce)', 'Desmosedici Stradale V4', 'High handlebar ergonomics'],
      engineNoteDescription: 'Desmosedici V4 roar at 14,500 RPM.',
    ),

    // 14. Aprilia RSV4 1100
    Superbike(
      id: 'bike-14-aprilia-rsv4-1100',
      name: 'Aprilia RSV4 1100',
      brand: 'Aprilia',
      tagline: '#14 🇮🇹 Italy | 1,099cc V4 | 217 HP Italian V4 Weapon',
      year: 2024,
      priceEstimate: '\$18,999',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: apriliaRed,
      specs: const TelemetrySpecs(
        horsepower: 217, torqueNm: 125, topSpeedKmh: 305, acceleration0to100: 2.8,
        dryWeightKg: 179, powerToWeightRatio: 1.21, rpmRedline: 13500,
        engineType: '1,099cc 65° V4', displacementCc: 1099,
        transmission: '6-speed with AQS',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'APRC System', wheelieControl: 'AWC', launchControl: 'ALC',
        corneringAbs: 'Bosch ABS', quickshifter: 'AQS Up/Down', suspension: 'Sachs USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Aprilia', headquarters: 'Noale, Italy 🇮🇹',
        racingTitles: '54 World Titles', legendStory: 'Official Aprilia Racing Press: 65° V4 architecture delivering 217 HP.',
        milestones: [MilestoneModel(year: 2024, name: 'RSV4 1100', description: '217 HP V4 Superbike.')],
      ),
      highlights: ['1,099cc 65° V4 engine', 'Dual layer winglet fairing', 'Aprilia Race ABS'],
      engineNoteDescription: 'Thrilling 65° V4 exhaust crescendo.',
    ),

    // 15. BMW M 1000 R
    Superbike(
      id: 'bike-15-bmw-m1000r',
      name: 'BMW M 1000 R',
      brand: 'BMW Motorrad',
      tagline: '#15 🇩🇪 Germany | 999cc I4 | 210 HP M Hyper Roadster',
      year: 2024,
      priceEstimate: '\$21,345',
      imageUrl: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.bmwBlue,
      specs: const TelemetrySpecs(
        horsepower: 210, torqueNm: 113, topSpeedKmh: 280, acceleration0to100: 2.9,
        dryWeightKg: 177, powerToWeightRatio: 1.18, rpmRedline: 14600,
        engineType: '999cc ShiftCam Inline-4', displacementCc: 999,
        transmission: '6-speed Shift Assistant Pro',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 6-axis', wheelieControl: 'DTC Wheelie', launchControl: 'Launch Control',
        corneringAbs: 'ABS Pro', quickshifter: 'Shift Assistant Pro', suspension: 'Marzocchi DDC Suspension',
      ),
      history: const BrandHistory(
        foundingYear: 1923, founderName: 'BMW', headquarters: 'Munich, Germany 🇩🇪',
        racingTitles: 'BMW M Motorsport', legendStory: 'Official BMW Motorrad Press: 210 HP M Roadster with M winglets.',
        milestones: [MilestoneModel(year: 2024, name: 'M 1000 R', description: '210 HP M Roadster.')],
      ),
      highlights: ['M Winglets generating 11kg downforce', 'ShiftCam engine', 'M Brakes & M Forged wheels'],
      engineNoteDescription: 'Crisp M Division ShiftCam exhaust note.',
    ),

    // 16. Kawasaki Ninja ZX-10R
    Superbike(
      id: 'bike-16-ninja-zx10r',
      name: 'Kawasaki Ninja ZX-10R',
      brand: 'Kawasaki',
      tagline: '#16 🇯🇵 Japan | 998cc I4 | 203 HP Track Legend',
      year: 2024,
      priceEstimate: '\$17,799',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 203, torqueNm: 115, topSpeedKmh: 299, acceleration0to100: 2.9,
        dryWeightKg: 184, powerToWeightRatio: 1.10, rpmRedline: 14300,
        engineType: '998cc Liquid-Cooled Inline-4', displacementCc: 998,
        transmission: '6-speed cassette',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'S-KTRC', wheelieControl: 'KLCM', launchControl: 'KLCM',
        corneringAbs: 'KIBS', quickshifter: 'KQS Up/Down', suspension: 'Showa BFF Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'WSBK Champions', legendStory: 'Official Kawasaki Racing Press: Showa BFF fork & cowl integrated winglets.',
        milestones: [MilestoneModel(year: 2024, name: 'Ninja ZX-10R', description: '203 HP Ninja Superbike.')],
      ),
      highlights: ['Integrated cowl winglets', 'Showa BFF pressurized fork', 'Electronic Cruise Control'],
      engineNoteDescription: 'Classic inline-4 Kawasaki racing note.',
    ),

    // 17. Suzuki GSX-R1000R
    Superbike(
      id: 'bike-17-gsxr1000r',
      name: 'Suzuki GSX-R1000R',
      brand: 'Suzuki',
      tagline: '#17 🇯🇵 Japan | 999cc I4 | 202 HP King of Sportbikes',
      year: 2024,
      priceEstimate: '\$18,499',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: suzukiBlue,
      specs: const TelemetrySpecs(
        horsepower: 202, torqueNm: 117, topSpeedKmh: 299, acceleration0to100: 2.9,
        dryWeightKg: 183, powerToWeightRatio: 1.10, rpmRedline: 14500,
        engineType: '999cc DOHC Inline-4 VVT', displacementCc: 999,
        transmission: '6-speed with Bi-directional Quickshifter',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'Motion Track TCS 10-mode', wheelieControl: 'Suzuki Lift Control', launchControl: 'Suzuki Launch Control',
        corneringAbs: 'Motion Track Brake System', quickshifter: 'Bi-directional Quickshifter', suspension: 'Showa BFF & BFRC Suspension',
      ),
      history: const BrandHistory(
        foundingYear: 1909, founderName: 'Michio Suzuki', headquarters: 'Hamamatsu, Shizuoka, Japan 🇯🇵',
        racingTitles: 'MotoGP World Champions & EWC', legendStory: 'Official Suzuki Press: Suzuki Racing Variable Valve Timing (SR-VVT) technology.',
        milestones: [MilestoneModel(year: 2024, name: 'GSX-R1000R', description: 'Variable Valve Timing (SR-VVT) tech.')],
      ),
      highlights: ['Broad Powerband SR-VVT Variable Valve Timing', 'Showa BFF suspension', 'Brembo monoblock radial calipers'],
      engineNoteDescription: 'Pure screaming VVT inline-4 exhaust.',
    ),

    // 18. Ducati Panigale V2
    Superbike(
      id: 'bike-18-panigale-v2',
      name: 'Ducati Panigale V2',
      brand: 'Ducati',
      tagline: '#18 🇮🇹 Italy | 890cc V2 | 155 HP Superquadro Twin',
      year: 2024,
      priceEstimate: '\$18,595',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 155, torqueNm: 104, topSpeedKmh: 270, acceleration0to100: 3.2,
        dryWeightKg: 153, powerToWeightRatio: 1.01, rpmRedline: 11500,
        engineType: '890cc Superquadro L-twin', displacementCc: 890,
        transmission: '6-speed DQS Up/Down EVO 2',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 2', wheelieControl: 'DWC EVO', launchControl: 'EBC EVO Engine Brake',
        corneringAbs: 'Bosch Cornering ABS EVO', quickshifter: 'DQS EVO 2', suspension: 'Showa BPF Fork & Sachs Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'WSBK Supersport Champions', legendStory: 'Official Ducati Press: Superquadro L-twin twin-cylinder superbike heritage.',
        milestones: [MilestoneModel(year: 2024, name: 'Panigale V2', description: '155 HP L-twin middleweight superbike.')],
      ),
      highlights: ['Superquadro L-twin engine', 'Single-sided aluminum swingarm', 'Panigale V4 inspired styling'],
      engineNoteDescription: 'Deep booming Desmo L-twin thrum.',
    ),

    // 19. Yamaha YZF-R1
    Superbike(
      id: 'bike-19-yzf-r1',
      name: 'Yamaha YZF-R1',
      brand: 'Yamaha',
      tagline: '#19 🇯🇵 Japan | 998cc I4 | 200 HP Standard Crossplane',
      year: 2024,
      priceEstimate: '\$18,399',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.electricCyan,
      specs: const TelemetrySpecs(
        horsepower: 200, torqueNm: 112, topSpeedKmh: 299, acceleration0to100: 2.9,
        dryWeightKg: 179, powerToWeightRatio: 1.11, rpmRedline: 14500,
        engineType: '998cc Crossplane CP4 Inline-4', displacementCc: 998,
        transmission: '6-speed slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'TCS 9-mode', wheelieControl: 'LIF Control', launchControl: 'LCS System',
        corneringAbs: 'BC Brake Control', quickshifter: 'QSS 2-way', suspension: 'KYB 43mm USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1955, founderName: 'Yamaha', headquarters: 'Iwata, Japan 🇯🇵',
        racingTitles: 'MotoGP World Champions', legendStory: 'Official Yamaha Racing Press: Deltabox aluminum frame with CP4 crossplane technology.',
        milestones: [MilestoneModel(year: 2024, name: 'YZF-R1', description: '200 HP CP4 Superbike.')],
      ),
      highlights: ['Crossplane CP4 engine', 'Deltabox aluminum frame', 'Magnesium wheels'],
      engineNoteDescription: 'Uneven crossplane CP4 exhaust soundtrack.',
    ),

    // 20. Honda CBR1000RR-R Fireblade
    Superbike(
      id: 'bike-20-honda-fireblade-std',
      name: 'Honda CBR1000RR-R Fireblade',
      brand: 'Honda',
      tagline: '#20 🇯🇵 Japan | 999cc I4 | 215 HP Standard Fireblade',
      year: 2024,
      priceEstimate: '\$24,500',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: hondaRed,
      specs: const TelemetrySpecs(
        horsepower: 215, torqueNm: 113, topSpeedKmh: 299, acceleration0to100: 2.8,
        dryWeightKg: 182, powerToWeightRatio: 1.18, rpmRedline: 14500,
        engineType: '999cc Inline 4-Cylinder', displacementCc: 999,
        transmission: '6-speed with Quickshifter',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'HSTC 9-level', wheelieControl: 'Wheelie Control', launchControl: 'Start Mode',
        corneringAbs: 'ABS Sport/Track', quickshifter: 'Quickshifter', suspension: 'Showa BPF Fork & BFRC Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1948, founderName: 'Soichiro Honda', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: '800+ GP Victories', legendStory: 'Official Honda Press: Grand Prix Red livery and MotoGP aerodynamics.',
        milestones: [MilestoneModel(year: 2024, name: 'Fireblade Standard', description: '215 HP Track Superbike.')],
      ),
      highlights: ['MotoGP aerodynamic winglets', 'Titanium connecting rods', 'TFT display'],
      engineNoteDescription: 'Screaming Honda inline-4 exhaust note.',
    ),

    // 21. Suzuki Hayabusa
    Superbike(
      id: 'bike-21-suzuki-hayabusa',
      name: 'Suzuki Hayabusa',
      brand: 'Suzuki',
      tagline: '#21 🇯🇵 Japan | 1,340cc I4 | 190 HP Ultimate Sport Legend',
      year: 2024,
      priceEstimate: '\$19,099',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: suzukiBlue,
      specs: const TelemetrySpecs(
        horsepower: 190, torqueNm: 150, topSpeedKmh: 299, acceleration0to100: 2.8,
        dryWeightKg: 221, powerToWeightRatio: 0.85, rpmRedline: 11000,
        engineType: '1,340cc Liquid-cooled Inline-4', displacementCc: 1340,
        transmission: '6-speed constant mesh',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'SIRSP (Suzuki Intelligent Ride System 10-mode)', wheelieControl: 'Anti-Lift Control', launchControl: 'Launch Control 3-mode',
        corneringAbs: 'Motion Track ABS', quickshifter: 'Bi-directional Quickshifter', suspension: 'KYB Fully Adjustable Fork & Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1909, founderName: 'Michio Suzuki', headquarters: 'Hamamatsu, Japan 🇯🇵',
        racingTitles: 'World Speed Record Holder', legendStory: 'Official Suzuki Press: Peregrine Falcon aerodynamic silhouette with 1,340cc engine.',
        milestones: [MilestoneModel(year: 2024, name: 'Hayabusa Gen 3', description: '1,340cc Ultimate Sportbike.')],
      ),
      highlights: ['Massive 150 Nm low-end torque', 'Iconic aerodynamic body silhouette', 'SIRS electronic riding suite'],
      engineNoteDescription: 'Deep thunderous 1,340cc inline-4 rumble.',
    ),

    // 22. Kawasaki Ninja H2 SX SE
    Superbike(
      id: 'bike-22-ninja-h2-sx-se',
      name: 'Kawasaki Ninja H2 SX SE',
      brand: 'Kawasaki',
      tagline: '#22 🇯🇵 Japan | 998cc Supercharged I4 | 200 HP Hyper Tourer',
      year: 2024,
      priceEstimate: '\$28,000',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 200, torqueNm: 137, topSpeedKmh: 299, acceleration0to100: 2.9,
        dryWeightKg: 225, powerToWeightRatio: 0.88, rpmRedline: 12000,
        engineType: '998cc Balanced Supercharged Inline-4', displacementCc: 998,
        transmission: '6-speed dog-ring',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC', wheelieControl: 'KLCM', launchControl: 'Launch Mode',
        corneringAbs: 'KIBS', quickshifter: 'KQS', suspension: 'KECS Semi-Active Suspension',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Supercharged Pioneers', legendStory: 'Official Kawasaki Press: Balanced Supercharger engine with ARAS Radar collision detection.',
        milestones: [MilestoneModel(year: 2024, name: 'H2 SX SE', description: 'Supercharged Sports Tourer with Radar.')],
      ),
      highlights: ['ARAS Radar Front/Rear Collision Warning', 'Balanced Supercharger engine', 'KECS semi-active electronic suspension'],
      engineNoteDescription: 'Supercharger chirp with 200 HP sport touring exhaust.',
    ),

    // 23. Ducati Streetfighter V2
    Superbike(
      id: 'bike-23-streetfighter-v2',
      name: 'Ducati Streetfighter V2',
      brand: 'Ducati',
      tagline: '#23 🇮🇹 Italy | 890cc V2 | 153 HP Naked Superquadro',
      year: 2024,
      priceEstimate: '\$18,195',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 153, torqueNm: 101, topSpeedKmh: 260, acceleration0to100: 3.2,
        dryWeightKg: 158, powerToWeightRatio: 0.96, rpmRedline: 11500,
        engineType: '890cc Superquadro V2', displacementCc: 890,
        transmission: '6-speed DQS EVO 2',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 2', wheelieControl: 'DWC EVO', launchControl: 'EBC Engine Brake',
        corneringAbs: 'Bosch Cornering ABS', quickshifter: 'DQS EVO 2', suspension: 'Showa BPF Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'Italian Racing Heritage', legendStory: 'Official Ducati Press: Panigale V2 performance stripped into a lightweight hyper naked.',
        milestones: [MilestoneModel(year: 2024, name: 'Streetfighter V2', description: '153 HP L-twin hyper naked.')],
      ),
      highlights: ['Panigale V2 ergonomics without fairings', 'Single-sided swingarm', 'High handlebar upright posture'],
      engineNoteDescription: 'Crisp twin-cylinder Desmo note.',
    ),

    // 24. KTM 1390 Super Duke R EVO
    Superbike(
      id: 'bike-24-ktm-1390-super-duke-evo',
      name: 'KTM 1390 Super Duke R EVO',
      brand: 'KTM',
      tagline: '#24 🇦🇹 Austria | 1,350cc V-twin | 190 HP The Beast 4.0',
      year: 2024,
      priceEstimate: '\$21,499',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: ktmOrange,
      specs: const TelemetrySpecs(
        horsepower: 190, torqueNm: 145, topSpeedKmh: 280, acceleration0to100: 2.8,
        dryWeightKg: 179, powerToWeightRatio: 1.06, rpmRedline: 10500,
        engineType: '1,350cc LC8 75° V-twin', displacementCc: 1350,
        transmission: '6-speed PANKL gearbox',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'MTC (Motorcycle Traction Control 9-level)', wheelieControl: 'Anti-Wheelie Mode', launchControl: 'Launch Control',
        corneringAbs: 'Supermoto ABS & Cornering ABS', quickshifter: 'Quickshifter+ Up/Down', suspension: 'WP APEX Semi-Active Technology (SAT)',
      ),
      history: const BrandHistory(
        foundingYear: 1934, founderName: 'Johann Trunkenpolz', headquarters: 'Mattighofen, Austria 🇦🇹',
        racingTitles: '300+ Dakar & Offroad/MotoGP Titles', legendStory: 'Official KTM Press: "The Beast" 1,350cc LC8 V-twin with WP APEX SAT suspension.',
        milestones: [MilestoneModel(year: 2024, name: '1390 Super Duke R EVO', description: '1,350cc 190 HP LC8 V-twin monster.')],
      ),
      highlights: ['WP APEX 3rd Gen Semi-Active suspension', '145 Nm V-twin torque', 'Camshift variable valve timing'],
      engineNoteDescription: 'Thunderous LC8 75° V-twin roar.',
    ),

    // 25. Triumph Speed Triple 1200 RS
    Superbike(
      id: 'bike-25-triumph-speed-triple-1200rs',
      name: 'Triumph Speed Triple 1200 RS',
      brand: 'Triumph',
      tagline: '#25 🇬🇧 UK | 1,160cc Triple | 180 HP Ultimate British Roadster',
      year: 2024,
      priceEstimate: '\$18,895',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: triumphSilver,
      specs: const TelemetrySpecs(
        horsepower: 180, torqueNm: 125, topSpeedKmh: 270, acceleration0to100: 2.9,
        dryWeightKg: 179, powerToWeightRatio: 1.00, rpmRedline: 11150,
        engineType: '1,160cc Liquid-Cooled 12-Valve DOHC Inline 3-Cylinder', displacementCc: 1160,
        transmission: '6-speed with Triumph Shift Assist',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'Optimised Cornering Traction Control', wheelieControl: 'Front Wheel Lift Control', launchControl: 'Launch Assist',
        corneringAbs: 'Optimised Cornering ABS', quickshifter: 'Triumph Shift Assist Up/Down', suspension: 'Öhlins NIX30 Fork & TTX36 Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1902, founderName: 'Siegfried Bettmann', headquarters: 'Hinckley, Leicestershire, UK 🇬🇧',
        racingTitles: 'Moto2 Exclusive Engine Supplier', legendStory: 'Official Triumph Press: Moto2 engine development team engineering for ultimate roadster performance.',
        milestones: [MilestoneModel(year: 2024, name: 'Speed Triple 1200 RS', description: '180 HP 1,160cc Triple Roadster.')],
      ),
      highlights: ['Moto2 engine design team development', 'Öhlins fully adjustable suspension', 'Metzeler Racetec RR tires'],
      engineNoteDescription: 'Addictive high-pitched British triple howl.',
    ),

    // 26. Triumph Daytona 660
    Superbike(
      id: 'bike-26-triumph-daytona-660',
      name: 'Triumph Daytona 660',
      brand: 'Triumph',
      tagline: '#26 🇬🇧 UK | 660cc Triple | 95 HP Sport Triple Return',
      year: 2024,
      priceEstimate: '\$9,195',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: triumphSilver,
      specs: const TelemetrySpecs(
        horsepower: 95, torqueNm: 69, topSpeedKmh: 220, acceleration0to100: 3.6,
        dryWeightKg: 183, powerToWeightRatio: 0.51, rpmRedline: 12650,
        engineType: '660cc Inline 3-Cylinder', displacementCc: 660,
        transmission: '6-speed slip and assist clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'Switchable Traction Control', wheelieControl: 'Integrated Control', launchControl: 'N/A',
        corneringAbs: 'ABS Standard', quickshifter: 'Triumph Shift Assist Optional', suspension: 'Showa 41mm SFF-BP Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1902, founderName: 'Triumph', headquarters: 'Hinckley, UK 🇬🇧',
        racingTitles: 'Isle of Man TT & Moto2', legendStory: 'Official Triumph Press: The iconic Daytona supersport name returns powered by a 660cc triple.',
        milestones: [MilestoneModel(year: 2024, name: 'Daytona 660', description: '95 HP Triple Middleweight Sportbike.')],
      ),
      highlights: ['High-revving 660cc triple engine', 'Showa Big Piston forks', '3 Riding Modes (Sport, Road, Rain)'],
      engineNoteDescription: 'Smooth screaming 3-cylinder exhaust note.',
    ),

    // 27. KTM 990 RC R
    Superbike(
      id: 'bike-27-ktm-990-rc-r',
      name: 'KTM 990 RC R',
      brand: 'KTM',
      tagline: '#27 🇦🇹 Austria | 947cc Twin | 128 HP Track Supersport',
      year: 2025,
      priceEstimate: '\$15,499',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: ktmOrange,
      specs: const TelemetrySpecs(
        horsepower: 128, torqueNm: 103, topSpeedKmh: 250, acceleration0to100: 3.1,
        dryWeightKg: 168, powerToWeightRatio: 0.76, rpmRedline: 10500,
        engineType: '947cc LC8c Parallel Twin', displacementCc: 947,
        transmission: '6-speed Quickshifter+ enabled',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'Lean Angle MTC', wheelieControl: 'Anti-Wheelie', launchControl: 'Track Launch Control',
        corneringAbs: 'Supermoto ABS Pro', quickshifter: 'Quickshifter+ Up/Down', suspension: 'WP APEX Open Cartridge Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1934, founderName: 'KTM', headquarters: 'Mattighofen, Austria 🇦🇹',
        racingTitles: 'MotoGP Race Winners', legendStory: 'Official KTM Press: Wind-tunnel developed MotoGP winglets and LC8c engine.',
        milestones: [MilestoneModel(year: 2025, name: '990 RC R', description: '128 HP LC8c Parallel Twin Supersport.')],
      ),
      highlights: ['Wind-tunnel tested MotoGP winglets', 'Ergonomic adjustable footpegs', 'WP APEX fully adjustable suspension'],
      engineNoteDescription: 'Punchy LC8c parallel twin firing note.',
    ),

    // 28. Aprilia Tuono V4 Factory
    Superbike(
      id: 'bike-28-aprilia-tuono-v4-factory',
      name: 'Aprilia Tuono V4 Factory',
      brand: 'Aprilia',
      tagline: '#28 🇮🇹 Italy | 1,099cc V4 | 175 HP Hyper Naked V4',
      year: 2024,
      priceEstimate: '\$19,599',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: apriliaRed,
      specs: const TelemetrySpecs(
        horsepower: 175, torqueNm: 121, topSpeedKmh: 280, acceleration0to100: 2.9,
        dryWeightKg: 181, powerToWeightRatio: 0.96, rpmRedline: 12800,
        engineType: '1,099cc 65° V4', displacementCc: 1099,
        transmission: '6-speed with AQS',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'APRC 8-level', wheelieControl: 'AWC', launchControl: 'ALC',
        corneringAbs: 'Bosch ABS', quickshifter: 'AQS Up/Down', suspension: 'Öhlins Smart EC 2.0 Electronic',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Aprilia', headquarters: 'Noale, Italy 🇮🇹',
        racingTitles: 'WSBK & GP Champions', legendStory: 'Official Aprilia Racing Press: RSV4 superbike chassis with upright handlebar ergonomics.',
        milestones: [MilestoneModel(year: 2024, name: 'Tuono V4 Factory', description: '175 HP Öhlins Smart EC Hyper Naked.')],
      ),
      highlights: ['Öhlins Smart EC 2.0 semi-active suspension', 'RSV4 chassis geometry', 'Aerodynamic winglet fairing'],
      engineNoteDescription: 'Thunderous 65° V4 exhaust roar.',
    ),

    // 29. Ducati SuperSport 950 S
    Superbike(
      id: 'bike-29-supersport-950-s',
      name: 'Ducati SuperSport 950 S',
      brand: 'Ducati',
      tagline: '#29 🇮🇹 Italy | 937cc V2 | 110 HP Everyday Sportsbike',
      year: 2024,
      priceEstimate: '\$18,095',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 110, torqueNm: 93, topSpeedKmh: 240, acceleration0to100: 3.4,
        dryWeightKg: 184, powerToWeightRatio: 0.59, rpmRedline: 9000,
        engineType: '937cc Testastretta 11° L-twin', displacementCc: 937,
        transmission: '6-speed DQS Up/Down EVO',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO', wheelieControl: 'DWC EVO', launchControl: 'N/A',
        corneringAbs: 'Bosch Cornering ABS', quickshifter: 'DQS EVO Up/Down', suspension: 'Öhlins 48mm USD Fork & Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'Italian Racing Heritage', legendStory: 'Official Ducati Press: Testastretta 11° L-twin engine paired with Öhlins suspension.',
        milestones: [MilestoneModel(year: 2024, name: 'SuperSport 950 S', description: '110 HP Öhlins equipped sports tourer.')],
      ),
      highlights: ['Öhlins fully adjustable suspension', 'Panigale style LED DRL headlight', 'Height-adjustable windscreen'],
      engineNoteDescription: 'Rich Testastretta 11° twin pulse.',
    ),

    // 30. BMW S 1000 R
    Superbike(
      id: 'bike-30-bmw-s1000r',
      name: 'BMW S 1000 R',
      brand: 'BMW Motorrad',
      tagline: '#30 🇩🇪 Germany | 999cc I4 | 165 HP Dynamic Roadster',
      year: 2024,
      priceEstimate: '\$14,545',
      imageUrl: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.bmwBlue,
      specs: const TelemetrySpecs(
        horsepower: 165, torqueNm: 114, topSpeedKmh: 255, acceleration0to100: 3.1,
        dryWeightKg: 180, powerToWeightRatio: 0.91, rpmRedline: 12000,
        engineType: '999cc Inline-4 engine', displacementCc: 999,
        transmission: '6-speed constant mesh',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 6-axis', wheelieControl: 'DTC Wheelie', launchControl: 'Launch Control',
        corneringAbs: 'ABS Pro', quickshifter: 'Shift Assistant Pro Optional', suspension: 'USD 45mm Telescopic Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1923, founderName: 'BMW', headquarters: 'Munich, Germany 🇩🇪',
        racingTitles: 'Superbike Heritage', legendStory: 'Official BMW Motorrad Press: S 1000 RR superbike engine scaled for roadster agility.',
        milestones: [MilestoneModel(year: 2024, name: 'S 1000 R', description: '165 HP Dynamic Roadster.')],
      ),
      highlights: ['Lightweight Flex Frame', 'M Package options available', 'TFT display with connectivity'],
      engineNoteDescription: 'Smooth refined German 999cc inline-4.',
    ),

    // 31. Kawasaki Z H2 SE
    Superbike(
      id: 'bike-31-z-h2-se',
      name: 'Kawasaki Z H2 SE',
      brand: 'Kawasaki',
      tagline: '#31 🇯🇵 Japan | 998cc Supercharged I4 | 200 HP Supercharged Naked',
      year: 2024,
      priceEstimate: '\$20,700',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 200, torqueNm: 137, topSpeedKmh: 280, acceleration0to100: 2.7,
        dryWeightKg: 227, powerToWeightRatio: 0.88, rpmRedline: 12000,
        engineType: '998cc Supercharged Inline-4', displacementCc: 998,
        transmission: '6-speed dog-ring',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC 3-mode', wheelieControl: 'KLCM Launch Mode', launchControl: 'KLCM Integrated',
        corneringAbs: 'KIBS ABS', quickshifter: 'KQS Up/Down', suspension: 'KECS Semi-Active Suspension with Showa Skyhook',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Supercharged Dominance', legendStory: 'Official Kawasaki Press: KECS semi-active electronic suspension with Showa Skyhook tech.',
        milestones: [MilestoneModel(year: 2024, name: 'Z H2 SE', description: '200 HP Supercharged Z flagship.')],
      ),
      highlights: ['KECS semi-active suspension with Skyhook', 'Brembo Stylema calipers', 'Balanced Supercharger'],
      engineNoteDescription: 'Supercharger blow-off flutter with 200 HP grunt.',
    ),

    // 32. Kawasaki Z900 SE
    Superbike(
      id: 'bike-32-z900-se',
      name: 'Kawasaki Z900 SE',
      brand: 'Kawasaki',
      tagline: '#32 🇯🇵 Japan | 948cc I4 | 125 HP Öhlins Edition',
      year: 2024,
      priceEstimate: '\$11,399',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 125, torqueNm: 98, topSpeedKmh: 240, acceleration0to100: 3.3,
        dryWeightKg: 192, powerToWeightRatio: 0.65, rpmRedline: 11000,
        engineType: '948cc Liquid-Cooled Inline-4', displacementCc: 948,
        transmission: '6-speed assist and slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC 3-mode', wheelieControl: 'Integrated KTRC', launchControl: 'N/A',
        corneringAbs: 'Nissin ABS', quickshifter: 'N/A', suspension: 'Öhlins S46 Rear Shock & Gold USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Z Legend Series', legendStory: 'Official Kawasaki Press: Öhlins S46 rear shock & Brembo M4.32 monoblock calipers.',
        milestones: [MilestoneModel(year: 2024, name: 'Z900 SE', description: '125 HP Öhlins Special Edition.')],
      ),
      highlights: ['Öhlins S46 rear shock absorber', 'Brembo M4.32 monoblock calipers', 'Sugomi aggressive styling'],
      engineNoteDescription: 'Responsive 948cc inline-4 intake growl.',
    ),

    // 33. Triumph Street Triple 765 RS
    Superbike(
      id: 'bike-33-street-triple-765-rs',
      name: 'Triumph Street Triple 765 RS',
      brand: 'Triumph',
      tagline: '#33 🇬🇧 UK | 765cc Triple | 130 HP Moto2 Powered',
      year: 2024,
      priceEstimate: '\$12,595',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: triumphSilver,
      specs: const TelemetrySpecs(
        horsepower: 130, torqueNm: 80, topSpeedKmh: 245, acceleration0to100: 3.2,
        dryWeightKg: 166, powerToWeightRatio: 0.78, rpmRedline: 12500,
        engineType: '765cc Moto2 Derived Inline 3-Cylinder', displacementCc: 765,
        transmission: '6-speed Triumph Shift Assist',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'Optimised Cornering TC', wheelieControl: 'Anti-Wheelie Control', launchControl: 'Track Mode',
        corneringAbs: 'Optimised Cornering ABS', quickshifter: 'Triumph Shift Assist Up/Down', suspension: 'Showa BPF Fork & Öhlins STX40 Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1902, founderName: 'Triumph', headquarters: 'Hinckley, UK 🇬🇧',
        racingTitles: 'Exclusive Moto2 Engine Supplier', legendStory: 'Official Triumph Press: Powered directly by Moto2 race engine team specifications.',
        milestones: [MilestoneModel(year: 2024, name: 'Street Triple 765 RS', description: '130 HP Moto2 spec middleweight benchmark.')],
      ),
      highlights: ['Moto2 engine development specs', 'Brembo Stylema brakes', 'Öhlins STX40 rear shock'],
      engineNoteDescription: 'Distinct Moto2 765cc triple howl.',
    ),

    // 34. Aprilia RS 660 Factory
    Superbike(
      id: 'bike-34-aprilia-rs-660-factory',
      name: 'Aprilia RS 660 Factory',
      brand: 'Aprilia',
      tagline: '#34 🇮🇹 Italy | 659cc Twin | 100 HP Lightweight Supersport',
      year: 2024,
      priceEstimate: '\$13,499',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: apriliaRed,
      specs: const TelemetrySpecs(
        horsepower: 100, torqueNm: 67, topSpeedKmh: 230, acceleration0to100: 3.5,
        dryWeightKg: 160, powerToWeightRatio: 0.62, rpmRedline: 11500,
        engineType: '659cc Forward-facing Parallel Twin', displacementCc: 659,
        transmission: '6-speed AQS',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'ATC (Aprilia Traction Control)', wheelieControl: 'AWC', launchControl: 'ALC',
        corneringAbs: 'Multi-map Cornering ABS', quickshifter: 'AQS Up/Down', suspension: 'Öhlins NIX30 Fork & STX46 Shock',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Aprilia', headquarters: 'Noale, Italy 🇮🇹',
        racingTitles: '54 World Titles', legendStory: 'Official Aprilia Racing Press: RSV4 derived cylinder head and Öhlins suspension.',
        milestones: [MilestoneModel(year: 2024, name: 'RS 660 Factory', description: '100 HP Öhlins equipped parallel twin.')],
      ),
      highlights: ['RSV4 derived front cylinder bank engine', 'Öhlins suspension', 'Dual fairing aerodynamic airflow'],
      engineNoteDescription: '270° firing order parallel twin growl.',
    ),

    // 35. Yamaha R7
    Superbike(
      id: 'bike-35-yamaha-r7',
      name: 'Yamaha R7',
      brand: 'Yamaha',
      tagline: '#35 🇯🇵 Japan | 689cc Twin | 73 HP CP2 Supersport',
      year: 2024,
      priceEstimate: '\$9,199',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.electricCyan,
      specs: const TelemetrySpecs(
        horsepower: 73, torqueNm: 67, topSpeedKmh: 215, acceleration0to100: 3.8,
        dryWeightKg: 172, powerToWeightRatio: 0.42, rpmRedline: 10000,
        engineType: '689cc CP2 270° Inline Twin', displacementCc: 689,
        transmission: '6-speed assist and slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'N/A', wheelieControl: 'N/A', launchControl: 'N/A',
        corneringAbs: 'ABS Standard', quickshifter: 'QSS Optional', suspension: 'KYB 41mm Inverted Front Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1955, founderName: 'Yamaha', headquarters: 'Iwata, Japan 🇯🇵',
        racingTitles: 'Supersport Champions', legendStory: 'Official Yamaha Racing Press: Slim ergonomics with 270° CP2 crossplane concept engine.',
        milestones: [MilestoneModel(year: 2024, name: 'Yamaha R7', description: '73 HP CP2 Supersport.')],
      ),
      highlights: ['270° crossplane concept CP2 twin', 'Slimmest R-series bodywork', 'Inverted front fork'],
      engineNoteDescription: 'Torquey 270° CP2 twin exhaust pulse.',
    ),

    // 36. Ducati Monster
    Superbike(
      id: 'bike-36-ducati-monster',
      name: 'Ducati Monster',
      brand: 'Ducati',
      tagline: '#36 🇮🇹 Italy | 890cc V2 | 111 HP Lightweight Icon',
      year: 2024,
      priceEstimate: '\$12,995',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 111, torqueNm: 93, topSpeedKmh: 235, acceleration0to100: 3.4,
        dryWeightKg: 166, powerToWeightRatio: 0.67, rpmRedline: 9250,
        engineType: '937cc Testastretta 11° L-twin', displacementCc: 937,
        transmission: '6-speed DQS Up/Down',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 8-level', wheelieControl: 'DWC', launchControl: 'Launch Control 3-level',
        corneringAbs: 'Cornering ABS 3-level', quickshifter: 'DQS Up/Down', suspension: '43mm USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Miguel Galluzzi (Designer)', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'Naked Bike Legend', legendStory: 'Official Ducati Press: Aluminum Front Frame inspired by Panigale V4.',
        milestones: [MilestoneModel(year: 2024, name: 'Monster 937', description: '111 HP lightweight aluminum Front Frame.')],
      ),
      highlights: ['Panigale V4 derived Front Frame', 'Testastretta 11° engine', 'Weight reduced to 166 kg dry'],
      engineNoteDescription: 'Classic Ducati Testastretta twin note.',
    ),

    // 37. Honda CBR650R
    Superbike(
      id: 'bike-37-honda-cbr650r',
      name: 'Honda CBR650R',
      brand: 'Honda',
      tagline: '#37 🇯🇵 Japan | 649cc I4 | 94 HP E-Clutch Tech',
      year: 2024,
      priceEstimate: '\$9,899',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: hondaRed,
      specs: const TelemetrySpecs(
        horsepower: 94, torqueNm: 63, topSpeedKmh: 220, acceleration0to100: 3.6,
        dryWeightKg: 190, powerToWeightRatio: 0.49, rpmRedline: 12000,
        engineType: '649cc 16-valve DOHC Inline 4-Cylinder', displacementCc: 649,
        transmission: '6-speed with optional Honda E-Clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'HSTC', wheelieControl: 'Integrated HSTC', launchControl: 'N/A',
        corneringAbs: 'Dual Channel ABS', quickshifter: 'Honda E-Clutch Automatic', suspension: 'Showa 41mm SFF-BP Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1948, founderName: 'Honda', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Honda CB & CBR Heritage', legendStory: 'Official Honda Press: World\'s first motorcycle with Honda E-Clutch automatic clutch control.',
        milestones: [MilestoneModel(year: 2024, name: 'CBR650R E-Clutch', description: 'First motorcycle with Honda E-Clutch.')],
      ),
      highlights: ['Honda E-Clutch electronic clutch system', 'Inline-4 middleweight engine', 'Showa SFF-BP USD fork'],
      engineNoteDescription: 'Smooth screaming 649cc inline-4.',
    ),

    // 38. Kawasaki Ninja ZX-6R
    Superbike(
      id: 'bike-38-ninja-zx6r',
      name: 'Kawasaki Ninja ZX-6R',
      brand: 'Kawasaki',
      tagline: '#38 🇯🇵 Japan | 636cc I4 | 124 HP 636cc Screamer',
      year: 2024,
      priceEstimate: '\$11,399',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 124, torqueNm: 69, topSpeedKmh: 260, acceleration0to100: 3.2,
        dryWeightKg: 175, powerToWeightRatio: 0.71, rpmRedline: 15000,
        engineType: '636cc Liquid-Cooled Inline-4', displacementCc: 636,
        transmission: '6-speed cassette type',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC 3-mode', wheelieControl: 'KTRC Integrated', launchControl: 'N/A',
        corneringAbs: 'KIBS ABS', quickshifter: 'KQS Up-Only', suspension: 'Showa SFF-BP Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'WorldSSP Champion', legendStory: 'Official Kawasaki Press: 636cc displacement providing 124 HP and street mid-range performance.',
        milestones: [MilestoneModel(year: 2024, name: 'Ninja ZX-6R 636', description: '124 HP 636cc Supersport.')],
      ),
      highlights: ['636cc displacement advantage', 'Showa Separate Function Big Piston fork', 'TFT display with Riding Modes'],
      engineNoteDescription: '15,000 RPM screaming 636cc inline-4.',
    ),

    // 39. Yamaha R6 Race
    Superbike(
      id: 'bike-39-yamaha-r6-race',
      name: 'Yamaha R6 Race',
      brand: 'Yamaha',
      tagline: '#39 🇯🇵 Japan | 599cc I4 | 118 HP WorldSSP Dominator',
      year: 2024,
      priceEstimate: '\$12,699',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.electricCyan,
      specs: const TelemetrySpecs(
        horsepower: 118, torqueNm: 62, topSpeedKmh: 265, acceleration0to100: 3.1,
        dryWeightKg: 165, powerToWeightRatio: 0.71, rpmRedline: 16000,
        engineType: '599cc Titanium Valve Inline-4', displacementCc: 599,
        transmission: '6-speed slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'TCS 6-level', wheelieControl: 'N/A', launchControl: 'N/A',
        corneringAbs: 'ABS Standard', quickshifter: 'QSS Quick Shift', suspension: 'KYB R1-spec 43mm USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1955, founderName: 'Yamaha', headquarters: 'Iwata, Japan 🇯🇵',
        racingTitles: '10+ WorldSSP Titles', legendStory: 'Official Yamaha Racing Press: Unrestricted 16,000 RPM track edition.',
        milestones: [MilestoneModel(year: 2024, name: 'R6 Race', description: 'Unrestricted 16,000 RPM track edition.')],
      ),
      highlights: ['Titanium valves & YCC-I variable intake', 'R1-derived KYB 43mm front fork', 'Deltabox aluminum frame'],
      engineNoteDescription: 'High-pitch 16,000 RPM screaming inline-4.',
    ),

    // 40. Honda CBR600RR
    Superbike(
      id: 'bike-40-honda-cbr600rr',
      name: 'Honda CBR600RR',
      brand: 'Honda',
      tagline: '#40 🇯🇵 Japan | 599cc I4 | 121 HP Winglet Supersport',
      year: 2024,
      priceEstimate: '\$12,099',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: hondaRed,
      specs: const TelemetrySpecs(
        horsepower: 121, torqueNm: 64, topSpeedKmh: 260, acceleration0to100: 3.2,
        dryWeightKg: 170, powerToWeightRatio: 0.71, rpmRedline: 14250,
        engineType: '599cc Liquid-Cooled Inline-4', displacementCc: 599,
        transmission: '6-speed with Quickshifter',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'HSTC 9-level', wheelieControl: 'Wheelie Control', launchControl: 'Launch Control',
        corneringAbs: 'Bosch 6-axis Cornering ABS', quickshifter: 'Quickshifter Standard', suspension: 'Showa 41mm BPF Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1948, founderName: 'Honda', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Exclusive Moto2 Engine Supplier (2010-2018)', legendStory: 'Official Honda HRC Press: Moto2 engine heritage and MotoGP winglets.',
        milestones: [MilestoneModel(year: 2024, name: 'CBR600RR', description: 'MotoGP aerodynamic winglets & 6-axis IMU.')],
      ),
      highlights: ['MotoGP aerodynamic winglets', '6-axis IMU electronics', 'Center-exit under-tail exhaust'],
      engineNoteDescription: 'High-revving Moto2 legacy inline-4.',
    ),

    // 41. Suzuki GSX-8R
    Superbike(
      id: 'bike-41-suzuki-gsx-8r',
      name: 'Suzuki GSX-8R',
      brand: 'Suzuki',
      tagline: '#41 🇯🇵 Japan | 776cc Twin | 83 HP Parallel Twin Sport',
      year: 2024,
      priceEstimate: '\$9,439',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: suzukiBlue,
      specs: const TelemetrySpecs(
        horsepower: 83, torqueNm: 78, topSpeedKmh: 215, acceleration0to100: 3.7,
        dryWeightKg: 185, powerToWeightRatio: 0.44, rpmRedline: 9800,
        engineType: '776cc 270° Parallel Twin', displacementCc: 776,
        transmission: '6-speed with Bi-directional Quickshifter',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'SIRS (Suzuki Drive Mode Selector 3-mode)', wheelieControl: 'N/A', launchControl: 'N/A',
        corneringAbs: 'ABS Standard', quickshifter: 'Bi-directional Quickshifter Standard', suspension: 'Showa SFF-BP USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1909, founderName: 'Suzuki', headquarters: 'Hamamatsu, Japan 🇯🇵',
        racingTitles: 'MotoGP Champions', legendStory: 'Official Suzuki Press: Suzuki Cross Balancer 270° parallel twin architecture.',
        milestones: [MilestoneModel(year: 2024, name: 'GSX-8R', description: '776cc parallel twin sportbike.')],
      ),
      highlights: ['Suzuki Cross Balancer for smooth V-twin torque', 'Showa SFF-BP suspension', 'Bi-directional quickshifter standard'],
      engineNoteDescription: 'Deep 270° parallel twin rumble.',
    ),

    // 42. Kawasaki Ninja 650
    Superbike(
      id: 'bike-42-ninja-650',
      name: 'Kawasaki Ninja 650',
      brand: 'Kawasaki',
      tagline: '#42 🇯🇵 Japan | 649cc Twin | 68 HP Everyday Sport',
      year: 2024,
      priceEstimate: '\$8,299',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 68, torqueNm: 64, topSpeedKmh: 210, acceleration0to100: 4.0,
        dryWeightKg: 178, powerToWeightRatio: 0.38, rpmRedline: 10000,
        engineType: '649cc Parallel Twin', displacementCc: 649,
        transmission: '6-speed assist and slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC 2-mode', wheelieControl: 'N/A', launchControl: 'N/A',
        corneringAbs: 'ABS Standard', quickshifter: 'N/A', suspension: '41mm Telescopic Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Ninja Family', legendStory: 'Official Kawasaki Press: Everyday sport ergonomics with KTRC Traction Control.',
        milestones: [MilestoneModel(year: 2024, name: 'Ninja 650', description: 'TFT Display & KTRC Traction Control.')],
      ),
      highlights: ['Kawasaki TRaction Control (KTRC)', 'TFT color display with Bluetooth', 'Assist & Slipper Clutch'],
      engineNoteDescription: 'Parallel twin exhaust beat.',
    ),

    // 43. Yamaha R9
    Superbike(
      id: 'bike-43-yamaha-r9',
      name: 'Yamaha R9',
      brand: 'Yamaha',
      tagline: '#43 🇯🇵 Japan | 890cc Triple | 119 HP CP3 Supersport Next Gen',
      year: 2025,
      priceEstimate: '\$12,499',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.electricCyan,
      specs: const TelemetrySpecs(
        horsepower: 119, torqueNm: 93, topSpeedKmh: 250, acceleration0to100: 3.2,
        dryWeightKg: 170, powerToWeightRatio: 0.70, rpmRedline: 10500,
        engineType: '890cc CP3 Inline 3-Cylinder', displacementCc: 890,
        transmission: '6-speed Quick Shift System',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'TCS Lean Angle 6-axis', wheelieControl: 'LIF Control', launchControl: 'LCS Launch System',
        corneringAbs: 'BC Brake Control', quickshifter: 'QSS 3rd Gen Up/Down', suspension: 'KYB Fully Adjustable 43mm USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1955, founderName: 'Yamaha', headquarters: 'Iwata, Japan 🇯🇵',
        racingTitles: 'R-Series Legacy', legendStory: 'Official Yamaha Racing Press: Next generation supersport with CP3 crossplane concept engine.',
        milestones: [MilestoneModel(year: 2025, name: 'Yamaha R9', description: '890cc CP3 Supersport with MotoGP winglets.')],
      ),
      highlights: ['MotoGP-derived aerodynamic winglets', 'CP3 crossplane concept triple engine', 'Lightweight gravity-cast aluminum frame'],
      engineNoteDescription: 'Roaring CP3 3-cylinder exhaust crescendo.',
    ),

    // 44. Aprilia RS 457
    Superbike(
      id: 'bike-44-aprilia-rs-457',
      name: 'Aprilia RS 457',
      brand: 'Aprilia',
      tagline: '#44 🇮🇹 Italy | 457cc Twin | 48 HP Lightweight Racer',
      year: 2024,
      priceEstimate: '\$6,799',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: apriliaRed,
      specs: const TelemetrySpecs(
        horsepower: 48, torqueNm: 44, topSpeedKmh: 190, acceleration0to100: 4.5,
        dryWeightKg: 159, powerToWeightRatio: 0.30, rpmRedline: 10500,
        engineType: '457cc Liquid-cooled Parallel Twin', displacementCc: 457,
        transmission: '6-speed with Quickshifter optional',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'ATC 3-level', wheelieControl: 'Integrated ATC', launchControl: 'N/A',
        corneringAbs: 'Dual Channel ABS with Supermoto Mode', quickshifter: 'Aprilia Quick Shift Optional', suspension: '41mm USD Preload Adjustable Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1945, founderName: 'Aprilia', headquarters: 'Noale, Italy 🇮🇹',
        racingTitles: '54 World Titles', legendStory: 'Official Aprilia Racing Press: Aluminum perimeter frame segment first.',
        milestones: [MilestoneModel(year: 2024, name: 'RS 457', description: '48 HP aluminum chassis supersport.')],
      ),
      highlights: ['Aluminum perimeter frame (Segment First)', 'ByBre radial caliper', 'Ride-by-Wire with 3 Riding Modes'],
      engineNoteDescription: 'Crisp parallel twin 270° firing note.',
    ),

    // 45. KTM RC 390
    Superbike(
      id: 'bike-45-ktm-rc-390',
      name: 'KTM RC 390',
      brand: 'KTM',
      tagline: '#45 🇦🇹 Austria | 373cc Single | 43 HP Moto3 Pocket Rocket',
      year: 2024,
      priceEstimate: '\$5,899',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: ktmOrange,
      specs: const TelemetrySpecs(
        horsepower: 43, torqueNm: 37, topSpeedKmh: 175, acceleration0to100: 4.9,
        dryWeightKg: 155, powerToWeightRatio: 0.28, rpmRedline: 10000,
        engineType: '373cc Single Cylinder 4-stroke', displacementCc: 373,
        transmission: '6-speed slipper clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'MTC Lean Angle', wheelieControl: 'N/A', launchControl: 'N/A',
        corneringAbs: 'Bosch Cornering ABS with Supermoto Mode', quickshifter: 'Quickshifter+ Optional', suspension: 'WP APEX 43mm Adjustable Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1934, founderName: 'KTM', headquarters: 'Mattighofen, Austria 🇦🇹',
        racingTitles: 'Moto3 World Champions', legendStory: 'Official KTM Press: Moto3 race engineering adapted for street supersport performance.',
        milestones: [MilestoneModel(year: 2024, name: 'RC 390', description: '43 HP WP APEX equipped track supersport.')],
      ),
      highlights: ['WP APEX adjustable front & rear suspension', 'Supermoto ABS mode', 'Bionic lightweight wheels'],
      engineNoteDescription: 'High-revving single cylinder thumper note.',
    ),

    // 46. BMW M 1000 XR
    Superbike(
      id: 'bike-46-bmw-m1000xr',
      name: 'BMW M 1000 XR',
      brand: 'BMW Motorrad',
      tagline: '#46 🇩🇪 Germany | 999cc I4 | 201 HP M Crossover Hypersport',
      year: 2024,
      priceEstimate: '\$24,295',
      imageUrl: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.bmwBlue,
      specs: const TelemetrySpecs(
        horsepower: 201, torqueNm: 113, topSpeedKmh: 278, acceleration0to100: 3.0,
        dryWeightKg: 205, powerToWeightRatio: 0.98, rpmRedline: 14600,
        engineType: '999cc ShiftCam Inline-4', displacementCc: 999,
        transmission: '6-speed Shift Assistant Pro',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 6-axis', wheelieControl: 'DTC Wheelie', launchControl: 'Launch Control',
        corneringAbs: 'ABS Pro', quickshifter: 'Shift Assistant Pro', suspension: 'Dynamic Damping Control (DDC)',
      ),
      history: const BrandHistory(
        foundingYear: 1923, founderName: 'BMW', headquarters: 'Munich, Germany 🇩🇪',
        racingTitles: 'M Motorsport Series', legendStory: 'Official BMW Motorrad Press: 201 HP M Crossover with M winglets generating 12kg downforce.',
        milestones: [MilestoneModel(year: 2024, name: 'M 1000 XR', description: '201 HP M Crossover.')],
      ),
      highlights: ['M Winglets generating 12kg downforce', 'M Carbon wheels option', 'ShiftCam 201 HP engine'],
      engineNoteDescription: 'Deep inline-4 ShiftCam crossover soundtrack.',
    ),

    // 47. Ducati Diavel V4
    Superbike(
      id: 'bike-47-ducati-diavel-v4',
      name: 'Ducati Diavel V4',
      brand: 'Ducati',
      tagline: '#47 🇮🇹 Italy | 1,158cc V4 | 168 HP Muscle Cruiser',
      year: 2024,
      priceEstimate: '\$26,995',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 168, torqueNm: 126, topSpeedKmh: 270, acceleration0to100: 3.0,
        dryWeightKg: 211, powerToWeightRatio: 0.80, rpmRedline: 10750,
        engineType: '1,158cc V4 Granturismo', displacementCc: 1158,
        transmission: '6-speed DQS Up/Down',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 8-level', wheelieControl: 'DWC', launchControl: 'DPL Launch Control',
        corneringAbs: 'Bosch Cornering ABS', quickshifter: 'DQS Up/Down', suspension: '50mm USD Fully Adjustable Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'Design Award Winner', legendStory: 'Official Ducati Press: Quad-tip exhaust tailpipes with V4 Granturismo muscle cruiser power.',
        milestones: [MilestoneModel(year: 2024, name: 'Diavel V4', description: '168 HP V4 Granturismo Muscle Cruiser.')],
      ),
      highlights: ['Quad-tip exhaust tailpipes', 'Rear cylinder deactivation at idle', '240/45 ZR17 massive rear tire'],
      engineNoteDescription: 'Thunderous V4 Granturismo quad-pipe exhaust thrum.',
    ),

    // 48. Kawasaki Ninja 1000SX
    Superbike(
      id: 'bike-48-ninja-1000sx',
      name: 'Kawasaki Ninja 1000SX',
      brand: 'Kawasaki',
      tagline: '#48 🇯🇵 Japan | 1,043cc I4 | 142 HP Sport Tourer Icon',
      year: 2024,
      priceEstimate: '\$13,699',
      imageUrl: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonGreen,
      specs: const TelemetrySpecs(
        horsepower: 142, torqueNm: 111, topSpeedKmh: 245, acceleration0to100: 3.2,
        dryWeightKg: 214, powerToWeightRatio: 0.66, rpmRedline: 11000,
        engineType: '1,043cc Liquid-Cooled Inline-4', displacementCc: 1043,
        transmission: '6-speed with KQS Quick Shifter',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'KTRC 3-mode', wheelieControl: 'KTRC Integrated', launchControl: 'N/A',
        corneringAbs: 'KIBS Cornering Management', quickshifter: 'KQS Up/Down', suspension: '41mm USD Fork',
      ),
      history: const BrandHistory(
        foundingYear: 1896, founderName: 'Kawasaki', headquarters: 'Tokyo, Japan 🇯🇵',
        racingTitles: 'Sport Tourer Benchmark', legendStory: 'Official Kawasaki Press: Integrated pannier mounts with Electronic Cruise Control.',
        milestones: [MilestoneModel(year: 2024, name: 'Ninja 1000SX', description: '142 HP Inline-4 Sport Tourer.')],
      ),
      highlights: ['Electronic Cruise Control', 'Integrated pannier mounts', 'TFT display with Rideology App'],
      engineNoteDescription: 'Smooth linear 1,043cc inline-4 roar.',
    ),

    // 49. BMW R 1300 R
    Superbike(
      id: 'bike-49-bmw-r1300r',
      name: 'BMW R 1300 R',
      brand: 'BMW Motorrad',
      tagline: '#49 🇩🇪 Germany | 1,300cc Boxer | 145 HP ShiftCam Boxer Roadster',
      year: 2025,
      priceEstimate: '\$16,995',
      imageUrl: 'https://images.unsplash.com/photo-1609630875171-b1321377ee65?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.bmwBlue,
      specs: const TelemetrySpecs(
        horsepower: 145, torqueNm: 149, topSpeedKmh: 240, acceleration0to100: 3.3,
        dryWeightKg: 210, powerToWeightRatio: 0.69, rpmRedline: 9000,
        engineType: '1,300cc 2-cylinder Boxer with ShiftCam', displacementCc: 1300,
        transmission: '6-speed with Shift Assistant Pro',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC 6-axis', wheelieControl: 'DTC Wheelie Control', launchControl: 'N/A',
        corneringAbs: 'ABS Pro', quickshifter: 'Shift Assistant Pro', suspension: 'Evo Telelever & Paralever DSA',
      ),
      history: const BrandHistory(
        foundingYear: 1923, founderName: 'Max Friz', headquarters: 'Munich, Germany 🇩🇪',
        racingTitles: 'Boxer Engine Pioneers', legendStory: 'Official BMW Motorrad Press: 1,300cc ShiftCam Boxer twin producing 149 Nm torque.',
        milestones: [MilestoneModel(year: 2025, name: 'R 1300 R', description: '145 HP ShiftCam Boxer Roadster.')],
      ),
      highlights: ['149 Nm massive boxer torque', 'ShiftCam variable intake timing', 'Evo Telelever front suspension'],
      engineNoteDescription: 'Deep throaty 1,300cc Boxer twin thrum.',
    ),

    // 50. Ducati Panigale V4 Lamborghini
    Superbike(
      id: 'bike-50-panigale-v4-lamborghini',
      name: 'Ducati Panigale V4 Lamborghini',
      brand: 'Ducati',
      tagline: '#50 🇮🇹 Italy | 1,103cc V4 | 228 HP Streetfighter Huracán STO Limited Edition',
      year: 2024,
      priceEstimate: '\$68,000',
      imageUrl: 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=1200&q=80',
      accentColor: AppTheme.neonRed,
      specs: const TelemetrySpecs(
        horsepower: 228, torqueNm: 123, topSpeedKmh: 310, acceleration0to100: 2.7,
        dryWeightKg: 168, powerToWeightRatio: 1.35, rpmRedline: 15500,
        engineType: '1,103cc Desmosedici Stradale V4', displacementCc: 1103,
        transmission: '6-speed DQS EVO 2 with STM-EVO SBK dry clutch',
      ),
      electronics: const ElectronicsPackage(
        tractionControl: 'DTC EVO 3', wheelieControl: 'DWC EVO', launchControl: 'DPL EVO',
        corneringAbs: 'Bosch Cornering ABS EVO', quickshifter: 'DQS EVO 2', suspension: 'Öhlins Smart EC 2.0 Electronic',
      ),
      history: const BrandHistory(
        foundingYear: 1926, founderName: 'Ducati & Lamborghini', headquarters: 'Bologna, Italy 🇮🇹',
        racingTitles: 'Hypercar Collaboration', legendStory: 'Official Ducati & Lamborghini Press: Ultra-exclusive 630-unit collaboration matching the Huracán STO super sports car.',
        milestones: [MilestoneModel(year: 2024, name: 'Panigale V4 Lamborghini', description: 'Limited edition 630 units STO styling.')],
      ),
      highlights: ['Lamborghini Huracán STO Verde Citrea green & Arancio Dac livery', 'Forged carbon wheels matching Huracán STO', 'Titanium Akrapovič exhaust'],
      engineNoteDescription: 'Exotic Akrapovič titanium V4 supercar roar.',
    ),
  ];
}
