// Fill sweep spinner generator: filling and sweeping rows.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the fillsweep spinner animation.
///
/// Fills rows from bottom to top, holds, then sweeps them away top to bottom
/// on a 4×4 grid. Results in 11 frames.
Spinner generateFillSweep({int? intervalInMs}) {
  const width = 4;
  const height = 4;

  final frameList = <String>[];

  // Phase 1: fill from bottom up
  for (int row = height - 1; row >= 0; row--) {
    final grid = makeGrid(height, width);
    for (int r = row; r < height; r++) {
      for (int c = 0; c < width; c++) {
        grid[r][c] = true;
      }
    }
    frameList.add(gridToBraille(grid));
  }

  // Two full frames
  final full = makeGrid(height, width);
  for (int r = 0; r < height; r++) {
    for (int c = 0; c < width; c++) {
      full[r][c] = true;
    }
  }
  frameList.add(gridToBraille(full));
  frameList.add(gridToBraille(full));

  // Phase 2: sweep from top down
  for (int row = 0; row < height; row++) {
    final grid = makeGrid(height, width);
    for (int r = row + 1; r < height; r++) {
      for (int c = 0; c < width; c++) {
        grid[r][c] = true;
      }
    }
    frameList.add(gridToBraille(grid));
  }

  // Empty frame
  frameList.add(gridToBraille(makeGrid(height, width)));

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 100);
}

/// Pre-computed fillSweep spinner.
final Spinner fillSweepSpinner = generateFillSweep();
