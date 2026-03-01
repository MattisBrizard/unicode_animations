// Cascade spinner generator: diagonal cascade sweep.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the cascade spinner animation.
///
/// Creates a diagonal line sweeping across a 4×8 grid.
/// Results in 13 frames.
Spinner generateCascade({int? intervalInMs}) {
  const width = 8;
  const height = 4;

  final frameList = <String>[];

  for (int offset = -2; offset < width + height; offset++) {
    final grid = makeGrid(height, width);

    for (int r = 0; r < height; r++) {
      for (int c = 0; c < width; c++) {
        final diag = c + r;
        if (diag == offset || diag == offset - 1) {
          grid[r][c] = true;
        }
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 60);
}

/// Pre-computed cascade spinner.
final Spinner cascadeSpinner = generateCascade();
