// Sort spinner generator: sorting visualization.

import 'dart:math' as math;

import 'package:unicode_animations/src/seeded_random.dart';
import 'package:unicode_animations/unicode_animations.dart';

/// Generates the sort spinner animation.
///
/// Visualizes a sorting operation: a cursor sweeps left-to-right,
/// smoothly transitioning shuffled values to their sorted positions.
/// Uses a seeded PRNG (seed 19) for deterministic output.
/// Results in 100 frames.
Spinner generateSort({int? intervalInMs}) {
  const width = 10;
  const totalFrames = 100;
  const pixelCols = width * 2;

  final rand = seededRandom(19);
  final shuffled = List<double>.generate(pixelCols, (_) => rand() * 3);
  final target = List<double>.generate(
    pixelCols,
    (int i) => (i / (pixelCols - 1)) * 3,
  );

  final frameList = <String>[];

  for (int t = 0; t < totalFrames; t++) {
    final codes = List<int>.filled(width, brailleBase);
    final progress = t / totalFrames;
    final cursor = progress * pixelCols * 1.2;

    for (int pc = 0; pc < pixelCols; pc++) {
      final charIdx = pc ~/ 2;
      final dc = pc % 2;
      final d = pc - cursor;
      double center;

      if (d < -3) {
        center = target[pc];
      } else if (d < 2) {
        final blend = 1 - (d + 3) / 5;
        final ease = blend * blend * (3 - 2 * blend);
        center = shuffled[pc] + (target[pc] - shuffled[pc]) * ease;

        if (d.abs() < 0.8) {
          for (int r = 0; r < 4; r++) {
            codes[charIdx] |= dotBits[r][dc];
          }
          continue;
        }
      } else {
        center = shuffled[pc] +
            math.sin(progress * math.pi * 16 + pc * 2.7) * 0.6 +
            math.sin(progress * math.pi * 9 + pc * 1.3) * 0.4;
      }

      center = center.clamp(0.0, 3.0);

      for (int r = 0; r < 4; r++) {
        if ((r - center).abs() < 0.7) {
          codes[charIdx] |= dotBits[r][dc];
        }
      }
    }

    frameList.add(String.fromCharCodes(codes));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 40);
}

/// Pre-computed sort spinner.
final Spinner sortSpinner = generateSort();
