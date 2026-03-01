// Checkerboard spinner generator: alternating checkerboard pattern.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the checkerboard spinner animation.
///
/// Alternates between checkerboard patterns on a 4×6 grid.
/// Results in 4 frames.
Spinner generateCheckerboard({int? intervalInMs}) {
  const width = 6;
  const height = 4;

  final frameList = <String>[];

  for (int phase = 0; phase < 4; phase++) {
    final grid = makeGrid(height, width);

    for (int r = 0; r < height; r++) {
      for (int c = 0; c < width; c++) {
        if (phase < 2) {
          grid[r][c] = (r + c + phase) % 2 == 0;
        } else {
          grid[r][c] = (r + c + phase) % 3 == 0;
        }
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 250);
}

/// Pre-computed checkerboard spinner.
final Spinner checkerboardSpinner = generateCheckerboard();
