// Rain spinner generator: falling rain drops.

import 'package:unicode_animations/unicode_animations.dart';

/// Generates the rain spinner animation.
///
/// Creates falling rain drops across a 4×8 grid with staggered column offsets.
/// Results in 12 frames.
Spinner generateRain({int? intervalInMs}) {
  const width = 8;
  const height = 4;
  const totalFrames = 12;
  const offsets = [0, 3, 1, 5, 2, 7, 4, 6];

  final frameList = <String>[];

  for (int f = 0; f < totalFrames; f++) {
    final grid = makeGrid(height, width);

    for (int c = 0; c < width; c++) {
      final row = (f + offsets[c]) % (height + 2);
      if (row < height) {
        grid[row][c] = true;
      }
    }

    frameList.add(gridToBraille(grid));
  }

  return Spinner(frames: frameList, intervalInMs: intervalInMs ?? 100);
}

/// Pre-computed rain spinner.
final Spinner rainSpinner = generateRain();
