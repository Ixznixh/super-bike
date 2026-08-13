import 'package:flutter/material.dart';

class TelemetrySpecs {
  final int horsepower;
  final int torqueNm;
  final int topSpeedKmh;
  final double acceleration0to100;
  final int dryWeightKg;
  final double powerToWeightRatio;
  final int rpmRedline;
  final String engineType;
  final int displacementCc;
  final String transmission;

  const TelemetrySpecs({
    required this.horsepower,
    required this.torqueNm,
    required this.topSpeedKmh,
    required this.acceleration0to100,
    required this.dryWeightKg,
    required this.powerToWeightRatio,
    required this.rpmRedline,
    required this.engineType,
    required this.displacementCc,
    required this.transmission,
  });

  Map<String, dynamic> toMap() {
    return {
      'horsepower': horsepower,
      'torqueNm': torqueNm,
      'topSpeedKmh': topSpeedKmh,
      'acceleration0to100': acceleration0to100,
      'dryWeightKg': dryWeightKg,
      'powerToWeightRatio': powerToWeightRatio,
      'rpmRedline': rpmRedline,
      'engineType': engineType,
      'displacementCc': displacementCc,
      'transmission': transmission,
    };
  }

  factory TelemetrySpecs.fromMap(Map<String, dynamic> map) {
    return TelemetrySpecs(
      horsepower: (map['horsepower'] ?? 200) as int,
      torqueNm: (map['torqueNm'] ?? 110) as int,
      topSpeedKmh: (map['topSpeedKmh'] ?? 300) as int,
      acceleration0to100: (map['acceleration0to100'] as num?)?.toDouble() ?? 2.8,
      dryWeightKg: (map['dryWeightKg'] ?? 170) as int,
      powerToWeightRatio: (map['powerToWeightRatio'] as num?)?.toDouble() ?? 1.2,
      rpmRedline: (map['rpmRedline'] ?? 15000) as int,
      engineType: (map['engineType'] ?? '') as String,
      displacementCc: (map['displacementCc'] ?? 998) as int,
      transmission: (map['transmission'] ?? '') as String,
    );
  }
}

class ElectronicsPackage {
  final String tractionControl;
  final String wheelieControl;
  final String launchControl;
  final String corneringAbs;
  final String quickshifter;
  final String suspension;

  const ElectronicsPackage({
    required this.tractionControl,
    required this.wheelieControl,
    required this.launchControl,
    required this.corneringAbs,
    required this.quickshifter,
    required this.suspension,
  });

  Map<String, dynamic> toMap() {
    return {
      'tractionControl': tractionControl,
      'wheelieControl': wheelieControl,
      'launchControl': launchControl,
      'corneringAbs': corneringAbs,
      'quickshifter': quickshifter,
      'suspension': suspension,
    };
  }

  factory ElectronicsPackage.fromMap(Map<String, dynamic> map) {
    return ElectronicsPackage(
      tractionControl: (map['tractionControl'] ?? '') as String,
      wheelieControl: (map['wheelieControl'] ?? '') as String,
      launchControl: (map['launchControl'] ?? '') as String,
      corneringAbs: (map['corneringAbs'] ?? '') as String,
      quickshifter: (map['quickshifter'] ?? '') as String,
      suspension: (map['suspension'] ?? '') as String,
    );
  }
}

class MilestoneModel {
  final int year;
  final String name;
  final String description;

  const MilestoneModel({
    required this.year,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'name': name,
      'description': description,
    };
  }

  factory MilestoneModel.fromMap(Map<String, dynamic> map) {
    return MilestoneModel(
      year: (map['year'] ?? 2024) as int,
      name: (map['name'] ?? '') as String,
      description: (map['description'] ?? '') as String,
    );
  }
}

class BrandHistory {
  final int foundingYear;
  final String founderName;
  final String headquarters;
  final String racingTitles;
  final String legendStory;
  final List<MilestoneModel> milestones;

  const BrandHistory({
    required this.foundingYear,
    required this.founderName,
    required this.headquarters,
    required this.racingTitles,
    required this.legendStory,
    required this.milestones,
  });

  Map<String, dynamic> toMap() {
    return {
      'foundingYear': foundingYear,
      'founderName': founderName,
      'headquarters': headquarters,
      'racingTitles': racingTitles,
      'legendStory': legendStory,
      'milestones': milestones.map((m) => m.toMap()).toList(),
    };
  }

  factory BrandHistory.fromMap(Map<String, dynamic> map) {
    final list = (map['milestones'] as List<dynamic>?) ?? [];
    return BrandHistory(
      foundingYear: (map['foundingYear'] ?? 1950) as int,
      founderName: (map['founderName'] ?? '') as String,
      headquarters: (map['headquarters'] ?? '') as String,
      racingTitles: (map['racingTitles'] ?? '') as String,
      legendStory: (map['legendStory'] ?? '') as String,
      milestones: list.map((e) => MilestoneModel.fromMap(e as Map<String, dynamic>)).toList(),
    );
  }
}

class Superbike {
  final String id;
  final String name;
  final String brand;
  final String tagline;
  final int year;
  final String priceEstimate;
  final String imageUrl;
  final Color accentColor;
  final TelemetrySpecs specs;
  final ElectronicsPackage electronics;
  final BrandHistory history;
  final List<String> highlights;
  final String engineNoteDescription;
  final String? uploaderEmail;

  Superbike({
    required this.id,
    required this.name,
    required this.brand,
    required this.tagline,
    required this.year,
    required this.priceEstimate,
    required this.imageUrl,
    required this.accentColor,
    required this.specs,
    required this.electronics,
    required this.history,
    required this.highlights,
    required this.engineNoteDescription,
    this.uploaderEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'tagline': tagline,
      'year': year,
      'priceEstimate': priceEstimate,
      'imageUrl': imageUrl,
      'accentColorValue': accentColor.value,
      'specs': specs.toMap(),
      'electronics': electronics.toMap(),
      'history': history.toMap(),
      'highlights': highlights,
      'engineNoteDescription': engineNoteDescription,
      'uploaderEmail': uploaderEmail,
    };
  }

  factory Superbike.fromMap(Map<String, dynamic> map, String docId) {
    final colorVal = map['accentColorValue'] as int? ?? 0xFF00F0FF;
    final highlightsList = (map['highlights'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

    return Superbike(
      id: docId,
      name: (map['name'] ?? '') as String,
      brand: (map['brand'] ?? '') as String,
      tagline: (map['tagline'] ?? '') as String,
      year: (map['year'] ?? 2025) as int,
      priceEstimate: (map['priceEstimate'] ?? '') as String,
      imageUrl: (map['imageUrl'] ?? '') as String,
      accentColor: Color(colorVal),
      specs: TelemetrySpecs.fromMap((map['specs'] as Map<String, dynamic>?) ?? {}),
      electronics: ElectronicsPackage.fromMap((map['electronics'] as Map<String, dynamic>?) ?? {}),
      history: BrandHistory.fromMap((map['history'] as Map<String, dynamic>?) ?? {}),
      highlights: highlightsList,
      engineNoteDescription: (map['engineNoteDescription'] ?? '') as String,
      uploaderEmail: map['uploaderEmail'] as String?,
    );
  }
}
