// Breathe spinner generator: breathing expansion/contraction.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the breathe spinner animation.
///
/// Expands dots outward then contracts inward on a 4×2 grid.
/// Results in 17 frames.
Spinner generateBreathe({int? intervalInMs}) {
  const stages = <List<(int, int)>>[
    [],
    [(1, 0)],
    [(0, 1), (2, 0)],
    [(0, 0), (1, 1), (3, 0)],
    [(0, 0), (1, 1), (2, 0), (3, 1)],
    [(0, 0), (0, 1), (1, 1), (2, 0), (3, 1)],
    [(0, 0), (0, 1), (1, 0), (2, 1), (3, 0), (3, 1)],
    [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (3, 0), (3, 1)],
    [(0, 0), (0, 1), (1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1)],
  ];

  // Build sequence: expand then contract (skip duplicate peak)
  final sequence = <List<(int, int)>>[
    ...stages,
    ...stages.reversed.skip(1),
  ];

  final frameList = <String>[];

  for (final dots in sequence) {
    final grid = makeGrid(4, 2);
    for (final (r, c) in dots) {
      grid[r][c] = true;
    }
    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 100);
}

/// Pre-computed breathe spinner.
final Spinner breatheSpinner = generateBreathe();
