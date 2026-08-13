import 'package:flutter/material.dart';
import '../models/superbike_model.dart';
import '../theme/app_theme.dart';

class HistoryTimelineWidget extends StatelessWidget {
  final BrandHistory history;
  final String brandName;
  final Color accentColor;

  const HistoryTimelineWidget({
    super.key,
    required this.history,
    required this.brandName,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Overview Header Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.glassDecoration(borderColor: accentColor.withOpacity(0.4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$brandName HERITAGE',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: accentColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: accentColor.withOpacity(0.5)),
                    ),
                    child: Text(
                      'EST. ${history.foundingYear}',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Color(0FF94A3B8)),
                  const SizedBox(width: 6),
                  Text(
                    'Headquarters: ${history.headquarters} | Founder: ${history.founderName}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Color(0FF94A3B8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.emoji_events_outlined, size: 16, color: AppTheme.vividGold),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Racing Titles: ${history.racingTitles}',
                      style: const TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.vividGold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                history.legendStory,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0FFF0F4F8),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Timeline Header
        Row(
          children: [
            Container(width: 4, height: 20, color: accentColor),
            const SizedBox(width: 10),
            Text(
              'HISTORICAL EVOLUTION & MILESTONES',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Timeline Nodes List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.milestones.length,
          itemBuilder: (context, index) {
            final milestone = history.milestones[index];
            final isLast = index == history.milestones.length - 1;

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Node Line
                  SizedBox(
                    width: 40,
                    child: Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withOpacity(0.6),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: const Color(0FF2D3548),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Milestone Details Card
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0FF161A23),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0FF2D3548)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                milestone.name,
                                style: const TextStyle(
                                  fontFamily: 'Rajdhani',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0FF1E2430),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${milestone.year}',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            milestone.description,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              color: Color(0FF94A3B8),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
