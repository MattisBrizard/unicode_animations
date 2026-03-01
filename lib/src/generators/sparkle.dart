// Sparkle spinner generator: random sparkle pattern.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the sparkle spinner animation.
///
/// Uses 6 pre-defined sparkle patterns on a 4×8 grid.
/// Results in 6 frames.
Spinner generateSparkle({int? intervalInMs}) {
  const width = 8;
  const height = 4;

  // Each list is a flattened H×W pattern (row-major)
  const patterns = <List<int>>[
    [
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0
    ],
    [
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      0,
      1,
      0
    ],
    [
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      0,
      1,
      0,
      0,
      0,
      1
    ],
    [
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      1,
      0,
      0,
      1,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      0
    ],
    [
      0,
      0,
      0,
      1,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      1,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      1
    ],
    [
      0,
      1,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      1,
      0,
      0,
      0
    ],
  ];

  final frameList = <String>[];

  for (final pat in patterns) {
    final grid = makeGrid(height, width);

    for (int r = 0; r < height; r++) {
      for (int c = 0; c < width; c++) {
        grid[r][c] = pat[r * width + c] != 0;
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 150);
}

/// Pre-computed sparkle spinner.
final Spinner sparkleSpinner = generateSparkle();
