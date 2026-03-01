// Scanline spinner generator: horizontal scan line bouncing vertically.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the scanline spinner animation.
///
/// Creates a horizontal line that bounces up and down across a 4×6 grid,
/// with a fading trail on even columns. Results in 6 frames.
Spinner generateScanLine({int? intervalInMs}) {
  const width = 6;
  const height = 4;
  const positions = [0, 1, 2, 3, 2, 1];

  final frameList = <String>[];

  for (final row in positions) {
    final grid = makeGrid(height, width);

    for (int c = 0; c < width; c++) {
      grid[row][c] = true;
      if (row > 0) {
        grid[row - 1][c] = c % 2 == 0;
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 120);
}

/// Pre-computed scanLine spinner.
final Spinner scanLineSpinner = generateScanLine();
