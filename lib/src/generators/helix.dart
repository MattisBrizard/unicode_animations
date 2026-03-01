// Helix spinner generator: double sine wave helix.

import 'dart:math' as math;

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the helix spinner animation.
///
/// Creates two interleaving sine waves on a 4×8 grid.
/// Results in 16 frames.
Spinner generateHelix({int? intervalInMs}) {
  const width = 8;
  const height = 4;
  const totalFrames = 16;

  final frameList = <String>[];

  for (int f = 0; f < totalFrames; f++) {
    final grid = makeGrid(height, width);

    for (int c = 0; c < width; c++) {
      final phase = (f + c) * (math.pi / 4);
      final y1 = ((math.sin(phase) + 1) / 2 * (height - 1)).round();
      final y2 = ((math.sin(phase + math.pi) + 1) / 2 * (height - 1)).round();
      grid[y1][c] = true;
      grid[y2][c] = true;
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 80);
}

/// Pre-computed helix spinner.
final Spinner helixSpinner = generateHelix();
