// Pendulum spinner generator: swinging pendulum wave.

import 'dart:math' as math;

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the pendulum spinner animation.
///
/// Creates a swinging pendulum wave across a 4×20 pixel grid (10 Braille
/// chars). The spread increases then decreases over the animation cycle.
/// Results in 120 frames.
Spinner generatePendulum({int? intervalInMs}) {
  const width = 10;
  const maxSpread = 1;
  const totalFrames = 120;
  const pixelCols = width * 2;

  final frameList = <String>[];

  for (int t = 0; t < totalFrames; t++) {
    final codes = List<int>.filled(width, brailleBase);
    final progress = t / totalFrames;
    final spread = math.sin(math.pi * progress) * maxSpread;
    final basePhase = progress * math.pi * 8;

    for (int pc = 0; pc < pixelCols; pc++) {
      final swing = math.sin(basePhase + pc * spread);
      final center = (1 - swing) * 1.5;

      for (int row = 0; row < 4; row++) {
        if ((row - center).abs() < 0.7) {
          codes[pc ~/ 2] |= dotBits[row][pc % 2];
        }
      }
    }

    frameList.add(String.fromCharCodes(codes));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 12);
}

/// Pre-computed pendulum spinner.
final Spinner pendulumSpinner = generatePendulum();
