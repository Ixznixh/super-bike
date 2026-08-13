import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class EngineSoundPlayer extends StatefulWidget {
  final String bikeName;
  final String engineNoteDescription;
  final Color accentColor;
  final int redlineRpm;

  const EngineSoundPlayer({
    super.key,
    required this.bikeName,
    required this.engineNoteDescription,
    required this.accentColor,
    required this.redlineRpm,
  });

  @override
  State<EngineSoundPlayer> createState() => _EngineSoundPlayerState();
}

class _EngineSoundPlayerState extends State<EngineSoundPlayer>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  int currentRpm = 1200; // Idle RPM
  Timer? _rpmTimer;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _rpmTimer?.cancel();
    _waveController.dispose();
    super.dispose();
  }

  void _toggleEngineRev() {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      _waveController.repeat(reverse: true);
      // Simulate RPM Rev surge
      _rpmTimer?.cancel();
      _rpmTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
        if (!mounted) return;
        setState(() {
          if (currentRpm < widget.redlineRpm - 500) {
            currentRpm += (Random().nextInt(800) + 600);
          } else {
            currentRpm = (widget.redlineRpm * 0.85).toInt() + Random().nextInt(500);
          }
        });
      });

      // Auto stop after 6 seconds
      Future.delayed(const Duration(seconds: 6), () {
        if (mounted && isPlaying) {
          _stopSound();
        }
      });
    } else {
      _stopSound();
    }
  }

  void _stopSound() {
    _rpmTimer?.cancel();
    _waveController.stop();
    setState(() {
      isPlaying = false;
      currentRpm = 1200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0FF161A23),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPlaying ? widget.accentColor : const Color(0FF2D3548),
          width: 1.5,
        ),
        boxShadow: isPlaying
            ? [
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.3),
                  blurRadius: 16,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _toggleEngineRev,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isPlaying ? widget.accentColor : const Color(0FF1E2430),
                    boxShadow: [
                      BoxShadow(
                        color: (isPlaying ? widget.accentColor : Colors.black)
                            .withOpacity(0.5),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                    color: isPlaying ? Colors.black : widget.accentColor,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPlaying ? 'ENGINE REV SIMULATOR (ACTIVE)' : 'START EXHAUST SOUND',
                      style: TextStyle(
                        fontFamily: 'Orbitron',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isPlaying ? widget.accentColor : Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.engineNoteDescription,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0FF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Live Tachometer Display
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$currentRpm',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: currentRpm > (widget.redlineRpm * 0.8)
                          ? const Color(0FFFF2A54)
                          : widget.accentColor,
                    ),
                  ),
                  const Text(
                    'RPM',
                    style: TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0FF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Sound Frequency Equalizer Animation
          SizedBox(
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAlignment.end,
              children: List.generate(24, (index) {
                final double heightMultiplier = isPlaying
                    ? (sin((index + _waveController.value * 10)) * 0.5 + 0.5)
                    : 0.15;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 4,
                  height: max(4.0, 24.0 * heightMultiplier),
                  decoration: BoxDecoration(
                    color: isPlaying
                        ? widget.accentColor.withOpacity(0.5 + (index % 5) * 0.1)
                        : const Color(0FF2D3548),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
