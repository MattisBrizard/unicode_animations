// Compress spinner generator: data compression visualization.

import 'dart:math' as math;

import 'package:unicode_animations/src/seeded_random.dart';
import 'package:unicode_animations/unicode_animations.dart';

/// Generates the compress spinner animation.
///
/// Visualizes data compression: random dots are progressively filtered
/// and squeezed into a narrowing column. Uses a seeded PRNG (seed 42)
/// for deterministic output.
/// Results in 100 frames.
Spinner generateCompress({int? intervalInMs}) {
  const width = 10;
  const totalFrames = 100;
  const pixelCols = width * 2;
  const totalDots = pixelCols * 4;

  final rand = seededRandom(42);
  final importance = List<double>.generate(totalDots, (_) => rand());

  final frameList = <String>[];

  for (int t = 0; t < totalFrames; t++) {
    final codes = List<int>.filled(width, brailleBase);
    final progress = t / totalFrames;
    final sieveThreshold = math.max(0.1, 1 - progress * 1.2);
    final squeeze = math.min(1.0, progress / 0.85);
    final activeWidth = math.max(1.0, pixelCols * (1 - squeeze * 0.95));

    for (int pc = 0; pc < pixelCols; pc++) {
      final mappedPc = (pc / pixelCols) * activeWidth;
      if (mappedPc >= activeWidth) continue;
      final targetPc = mappedPc.round();
      if (targetPc >= pixelCols) continue;
      final charIdx = targetPc ~/ 2;
      final dc = targetPc % 2;

      for (int row = 0; row < 4; row++) {
        if (importance[pc * 4 + row] < sieveThreshold) {
          codes[charIdx] |= dotBits[row][dc];
        }
      }
    }

    frameList.add(String.fromCharCodes(codes));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 40);
}

/// Pre-computed compress spinner.
final Spinner compressSpinner = generateCompress();
