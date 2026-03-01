// Wave rows spinner generator: wave moving through rows.

import 'dart:math' as math;

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the waverows spinner animation.
///
/// Creates a sine wave moving through a 4×8 grid with fading dots.
/// Results in 16 frames.
Spinner generateWaveRows({int? intervalInMs}) {
  const width = 8;
  const height = 4;
  const totalFrames = 16;

  final frameList = <String>[];

  for (int f = 0; f < totalFrames; f++) {
    final grid = makeGrid(height, width);

    for (int c = 0; c < width; c++) {
      final phase = f - c * 0.5;
      final row = (math.sin(phase * 0.8) + 1) / 2 * (height - 1);
      final roundedRow = row.round();
      grid[roundedRow][c] = true;
      if (roundedRow > 0) {
        grid[roundedRow - 1][c] = (f + c) % 3 == 0;
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 90);
}

/// Pre-computed waveRows spinner.
final Spinner waveRowsSpinner = generateWaveRows();
