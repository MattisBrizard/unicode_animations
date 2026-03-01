// Orbit spinner generator: circling orbit pattern.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the orbit spinner animation.
///
/// Creates a 2-dot trail orbiting around a 4×2 grid perimeter.
/// Results in 8 frames.
Spinner generateOrbit({int? intervalInMs}) {
  const width = 2;
  const height = 4;

  const path = <(int, int)>[
    (0, 0),
    (0, 1),
    (1, 1),
    (2, 1),
    (3, 1),
    (3, 0),
    (2, 0),
    (1, 0),
  ];

  final frameList = <String>[];

  for (int i = 0; i < path.length; i++) {
    final grid = makeGrid(height, width);

    // Current position
    final (r0, c0) = path[i];
    grid[r0][c0] = true;

    // Trail position (previous)
    final t1 = (i - 1 + path.length) % path.length;
    final (r1, c1) = path[t1];
    grid[r1][c1] = true;

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 100);
}

/// Pre-computed orbit spinner.
final Spinner orbitSpinner = generateOrbit();
