import 'package:flutter/material.dart';

class TelemetrySpecs {
  final int horsepower;
  final int torqueNm;
  final int topSpeedKmh;
  final double acceleration0to100;
  final int dryWeightKg;
  final double powerToWeightRatio; // HP / kg
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
  });
}
