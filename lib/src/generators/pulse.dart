// Pulse spinner generator: expanding circular pulse.

import 'dart:math' as math;

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the pulse spinner animation.
///
/// Creates concentric ring pulses expanding outward on a 4×6 grid.
/// Results in 5 frames.
Spinner generatePulse({int? intervalInMs}) {
  const width = 6;
  const height = 4;
  const cx = width / 2 - 0.5;
  const cy = height / 2 - 0.5;
  const radii = [0.5, 1.2, 2.0, 3.0, 3.5];

  final frameList = <String>[];

  for (final r in radii) {
    final grid = makeGrid(height, width);

    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final dist = math.sqrt(
          (col - cx) * (col - cx) + (row - cy) * (row - cy),
        );
        if ((dist - r).abs() < 0.9) {
          grid[row][col] = true;
        }
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 180);
}

/// Pre-computed pulse spinner.
final Spinner pulseSpinner = generatePulse();
